From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
Date: Mon, 15 Mar 2010 14:22:38 +0300
Message-ID: <4B9E187E.6090802@ru.mvista.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com> <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268648622-28529-2-git-send-email-Hui.Wang-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wang Hui <Hui.Wang-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Wang Hui wrote:

> On omap2/3 series platforms, the musb can't raise id pin change
> detection interrupt, so we must change otg mode through sysfs
> interface manually. Currently when the musb is in B mode, if we
> want musb to be changed to A mode, we should plug a mini-A cable
> and then execute echo host > /sys/devices/platform/musb_hdrc/mode.
> But if the musb is in A mode, we can't change it to B mode through
> this method.
> To solve this problem, add a process for sending end session request.
> This process works like this, if the musb is in A mode, it will send
> an end session request first, then it will follow original routine:
> start a new session, during this session, it will identify whether
> A or B is plugging in the socket,  then it will init controller to A
> or B mode according to its identification.
>
> Usage: change cable as you desired,
>        change musb mode by #>echo host[peripheral] > /sys/devices/\
>        platform/musb_hdrc/mode,
>        then you will get required musb mode.
>
> Signed-off-by: Wang Hui <Hui.Wang-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
> ---
>  drivers/usb/musb/omap2430.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3fe1686..b02897e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -194,6 +194,11 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>  {
>  	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>  
> +	if ((devctl & MUSB_DEVCTL_BDEVICE) == 0x0) {
> +		devctl &= ~MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +	}
> +
>  	devctl |= MUSB_DEVCTL_SESSION;
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
>   

   The whole musb_platform_set_mode() seems to be implemented 
incorrectly on OMAPs -- it shouldn't touch the DevCtl.Session bit. This 
function should control the ID pin override instead -- if the controller 
supports it. SRP must be initiated thru other means, i.e. 'srp' file in 
sysfs.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
