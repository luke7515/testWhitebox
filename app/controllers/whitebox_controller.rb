class WhiteboxController < ApplicationController
  def update

    @whitebox = Whitebox.find(params[:whiteboxid])
    @whitebox.content = params[:content]
    @editing = Editing.find(params[:editingid])
    @editing.edit = false
    @editing.save
    sync_update @editing
    if @whitebox.save
        @temp = Temp.new(:content => "Whitebox Changed")
        @temp.save
        sync_new @temp
        sync_update @whitebox
        respond_to do |format|
          format.js
        end
    end

  end

  def update2
    @editing = Editing.find(params[:editingid])
    @editing.edit = true
    @editing.user_id = params[:userid]
    if @editing.save
      sync_update @editing
      respond_to do |format|
        format.js
      end
    end

  end
end
