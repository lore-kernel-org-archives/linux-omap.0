From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] USB: musb: move musb debugfs entry under usb debugfs
 root dir
Date: Fri, 27 Aug 2010 22:34:45 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1CBD0@dbde02.ent.ti.com>
References: <1282923939-14872-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282923939-14872-1-git-send-email-tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <feli>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> 
> From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> All hcd's debugfs entries are under usb debugfs root dir already,
> so musb should not be a exception.
> 
> Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_debugfs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
> index c79a5e3..b19c31c 100644
> --- a/drivers/usb/musb/musb_debugfs.c
> +++ b/drivers/usb/musb/musb_debugfs.c
> @@ -257,7 +257,7 @@ int __init musb_init_debugfs(struct musb *musb)
>  	struct dentry		*file;
>  	int			ret;
>  
> -	root = debugfs_create_dir("musb", NULL);
> +	root = debugfs_create_dir("musb", usb_debug_root);
>  	if (IS_ERR(root)) {
>  		ret = PTR_ERR(root);
>  		goto err0;

Hi,

This will not work when you do not have USB Host support enabled in
your kernel.

- Anand


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
