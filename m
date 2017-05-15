From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Mon, 15 May 2017 07:24:28 -0500
Message-ID: <20170515122428.GD651@uda0271908>
References: <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com>
 <20170511204406.GI7154@uda0271908>
 <20170511210628.GA3489@atomide.com>
 <20170512134042.GK7154@uda0271908>
 <20170512145849.GE3489@atomide.com>
 <20170512152144.GA651@uda0271908>
 <172B0853-86A2-4253-B56D-8F7E716E5E0E@tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <172B0853-86A2-4253-B56D-8F7E716E5E0E@tecnorama.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>
Cc: Tony Lindgren <tony@atomide.com>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 15, 2017 at 09:07:10AM +0200, Moreno Bartalucci wrote:
> 
> > Il giorno 12 mag 2017, alle ore 17:21, Bin Liu <b-liu@ti.com> ha scritto:
> > 
> > […]
> > 
> > Moreno, would you mind to test the patch below with your modem?
> > 
> > […]
> >> 
> >>> 8< --------------------
> >>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> >>> index 9c7ee26ef388..465281244596 100644
> >>> --- a/drivers/usb/musb/musb_dsps.c
> >>> +++ b/drivers/usb/musb/musb_dsps.c
> >>> @@ -245,9 +245,14 @@ static int dsps_check_status(struct musb *musb, void *unused)
> >>>                dsps_mod_timer_optional(glue);
> >>>                break;
> >>>        case OTG_STATE_A_WAIT_BCON:
> >>> +               /* keep VBUS on for host-only mode */
> >>> +               if (musb->port_mode == MUSB_PORT_MODE_HOST) {
> >>> +                       dsps_mod_timer_optional(glue);
> >>> +                       break;
> >>> +               }
> >>>                musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> >>>                skip_session = 1;
> >>> -               /* fall */
> >>> +               /* fall through */
> >>> 
> >>>        case OTG_STATE_A_IDLE:
> >>>        case OTG_STATE_B_IDLE:
> 
> Hello Bin,
> 
> I tested the above patch with my device and it seems to work correctly with the current mainline kernel.
> 
> I tested it with my “production” kernel as well (4.9.20) but, for it to work, I had to change it slightly.

Thanks for testing.

> 
> This is what I tested for kernel 4.9.20:
> 
> --- a/drivers/usb/musb/musb_dsps.c	2017-05-15 08:40:23.000000000 +0200
> +++ b/drivers/usb/musb/musb_dsps.c	2017-05-15 08:49:17.000000000 +0200
> @@ -213,6 +213,12 @@ static int dsps_check_status(struct musb
>  				msecs_to_jiffies(wrp->poll_timeout));
>  		break;
>  	case OTG_STATE_A_WAIT_BCON:
> +		/* keep VBUS on for host-only mode */
> +		if (musb->port_mode == MUSB_PORT_MODE_HOST) {
> +			mod_timer(&glue->timer, jiffies +
> +					msecs_to_jiffies(wrp->poll_timeout));
> +			break;
> +		}
>  		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  		skip_session = 1;
>  		/* fall */
> 
> In this form, it appears to work properly for 4.9.20 too.

Yeah, the mod_timer() call is wrapped into dsps_mod_timer_optional() by
369469a92393d ("usb: musb: Add support for optional VBUS irq to dsps
glue layer"), introduced in v4.11-rc1.

Regards,
-Bin.
