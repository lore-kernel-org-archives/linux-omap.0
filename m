From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch-2.6.34-rc2+ 10/11] musb_core: don't call musb_platform_exit()
 twice
Date: Wed, 24 Mar 2010 15:10:10 +0300
Message-ID: <4BAA0122.2060402@ru.mvista.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com> <1269431279-22438-11-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269431279-22438-11-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Felipe Balbi wrote:

> From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
>
> musb_platform_exit() is called twice from musb_init_controller() iff controller
> initialization fails. Move the call (and the DevCtl register writes surrounding
> it) from musb_free() to musb_remove().
>
> Fix misplaced and now incorrect 'goto's in musb_init_controller().
>
> Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 827b813..90ac17b 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
>   
[...]
> @@ -2054,6 +2046,8 @@ bad_config:
>  			musb_readb(musb->mregs, MUSB_DEVCTL));
>  
>  	}
> +	if (status < 0)
> +		goto fail2;
>  
>  	status = musb_init_debugfs(musb);
>  	if (status < 0)
>   

   Hm, I don't see this call in the current driver -- are you sure 
you've used the right tree?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
