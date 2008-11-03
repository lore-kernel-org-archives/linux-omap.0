From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] musb: fixes vbus off issue after disconnect
Date: Mon, 3 Nov 2008 14:50:48 +0200
Message-ID: <20081103125047.GM21760@gandalf.research.nokia.com>
References: <1225357988-10985-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29162 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbYKCMvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 07:51:08 -0500
Content-Disposition: inline
In-Reply-To: <1225357988-10985-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, david-b@pacbell.net, me@felipebalbi.com, felipe.balbi@nokia.com

On Thu, Oct 30, 2008 at 02:43:08PM +0530, Ajay Kumar Gupta wrote:
> Vbus is switched off (after a_wait_bcon) whenever a device
> is disconnected from musb host even when musb is configured
> only as host.Earlier we use to switch on the power using
> [echo "F" >/proc/driver/musb_hdrc] but now this proc entry is
> deleted thus musb doesn't work after device disconnect.
> 
> This patch puts is_otg_enabled() check before scheduling
> a switch-off timer in disconnect path.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/musb/musb_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index dbf8861..6856da3 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -767,7 +767,7 @@ static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
>  		case OTG_STATE_A_HOST:
>  		case OTG_STATE_A_SUSPEND:
>  			musb_root_disconnect(musb);
> -			if (musb->a_wait_bcon != 0)
> +			if (musb->a_wait_bcon != 0 && is_otg_enabled(musb))

I'd say we need to turn off vbus whenever possible. This looks like the
problem is somewhere else but here. Maybe we're missing a disconnect
event. I recall we only ack disconnect upon next reconnection of the
device due to isses with tusb rev1.0. Maybe  the problem lies there.

Turning off vbus is good to save batery, and I'd say we keep it off as
long as possible. Vbus should probably be handled by userland in otg
cases, although I couldn't get Dave to agree with it :-p

I believe that we should have a "session" entry on sysfs and upon cable
connection, one side switches to a_idle and the other stays in b_idle.
The device that writes to session (echo 1 > session) will become host
(either b_host or a_host, meaning that hnp would also trigger based on
that).

Anyways, this is story for another patch.

-- 
balbi
