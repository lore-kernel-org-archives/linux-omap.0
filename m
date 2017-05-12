From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Fri, 12 May 2017 08:40:42 -0500
Message-ID: <20170512134042.GK7154@uda0271908>
References: <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com>
 <20170511204406.GI7154@uda0271908>
 <20170511210628.GA3489@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511210628.GA3489@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 11, 2017 at 02:06:28PM -0700, Tony Lindgren wrote:
> 
> Well maybe the minimal fix for now is just pretty much back to
> square one of this thread. This should keep VBUS always on.
> Then we can figure out some logic to cut VBUS later on.
> 
> And yeah, the state machine is really hard to follow so some kind
> of clean up would be nice.

Okay, figured out why clearing session in OTG_STATE_A_WAIT_BCON, it is
not for error condition handling (which is done in musb-core), but for
going back to b_idle state from a_host for dual-role mode. otg_timer()
(now is dsps_check_status()) was only called for otg port originally, so
it wasn't an issue, until started calling it for host mode as well when
runtime PM was added.
> 
> Regards,
> 
> Tony
> 
> 8< -------------------
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -245,7 +245,6 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  		dsps_mod_timer_optional(glue);
>  		break;
>  	case OTG_STATE_A_WAIT_BCON:
> -		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  		skip_session = 1;
>  		/* fall */
>  

So the above patch breaks otg port when switching from host to device
mode. The following change should solve it. But Tony do you see any way
to improve it with glue->vbus_irq?

Regards,
-Bin.

8< --------------------
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9c7ee26ef388..465281244596 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -245,9 +245,14 @@ static int dsps_check_status(struct musb *musb, void *unused)
                dsps_mod_timer_optional(glue);
                break;
        case OTG_STATE_A_WAIT_BCON:
+               /* keep VBUS on for host-only mode */
+               if (musb->port_mode == MUSB_PORT_MODE_HOST) {
+                       dsps_mod_timer_optional(glue);
+                       break;
+               }
                musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
                skip_session = 1;
-               /* fall */
+               /* fall through */
 
        case OTG_STATE_A_IDLE:
        case OTG_STATE_B_IDLE:
