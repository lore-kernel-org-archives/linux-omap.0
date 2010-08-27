From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: musb: move musb debugfs entry under usb debugfs
	root dir
Date: Fri, 27 Aug 2010 10:16:42 -0700
Message-ID: <20100827171642.GB19775@kroah.com>
References: <1282923939-14872-1-git-send-email-tom.leiming@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CBD0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CBD0-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 27, 2010 at 10:34:45PM +0530, Gadiyar, Anand wrote:
> tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > 
> > From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > All hcd's debugfs entries are under usb debugfs root dir already,
> > so musb should not be a exception.
> > 
> > Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/usb/musb/musb_debugfs.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
> > index c79a5e3..b19c31c 100644
> > --- a/drivers/usb/musb/musb_debugfs.c
> > +++ b/drivers/usb/musb/musb_debugfs.c
> > @@ -257,7 +257,7 @@ int __init musb_init_debugfs(struct musb *musb)
> >  	struct dentry		*file;
> >  	int			ret;
> >  
> > -	root = debugfs_create_dir("musb", NULL);
> > +	root = debugfs_create_dir("musb", usb_debug_root);
> >  	if (IS_ERR(root)) {
> >  		ret = PTR_ERR(root);
> >  		goto err0;
> 
> Hi,
> 
> This will not work when you do not have USB Host support enabled in
> your kernel.

Then we should move the creation of usb_debug_root out into somewhere
that will work for both types of systems, right?  Now where that might
be, I can't tell at the moment...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
