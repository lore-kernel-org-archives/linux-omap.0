From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 13:23:06 -0700
Message-ID: <20170511202306.GY3489@atomide.com>
References: <20170327165946.GL10760@atomide.com>
 <20170327171534.GA4403@uda0271908>
 <20170327175536.GP10760@atomide.com>
 <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511200220.GH7154@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu@ti.com> [170511 13:05]:
> On Thu, May 11, 2017 at 12:38:11PM -0700, Tony Lindgren wrote:
> > 
> > I wonder if just keeping VBUS on longer in OTG_STATE_A_WAIT_BCON
> > solves this issue?
> 
> We don't cut VBUS intentionally for host mode (when devctl=0x19). The
> VBUS got cut in this case only because when a device is detached, the
> otg state changes from A_HOST -> A_WAIT_BCON, then otg_timer() cuts VBUS
> and sets the state to A_IDLE, then next otg_timer() turns on VBUS (I
> haven't check how the otg state becomes A_WAIT_VRISE from here).
> 
> Not sure how to *easily* keep VBUS here, without adding condition check
> in otg_timer() for TG_STATE_A_WAIT_BCON.
> 
> > solves this issue? It seems the issue is with modems that get
> > reconfigured after the initial enumeration?
> 
> Idealy we shouldn't cut VBUS at all in this case for host-only. I am
> looking for a small patch to solve this, if possilbe ;)

Maybe try something like below, compile tested only. I don't
think I have any USB modem here to test with.

> > We could poll for new devices every 2 seconds, if anything is seen
> > on the bus, keep VBUS on at least 20 seconds, then if nothing is
> > found, poll every 2 seconds again.
> 
> I am not sure this is relevant, VBUS is constantly on once the otg stage
> becomes A_HOST -> A_WAIT_BCON -> A_IDLE -> A_WAIT_VRISE, within a
> second.

Yup, but it sounds like once the modem changes mode, it disappears
from the USB bus for a long enough time where we go to A_WAIT_BCON
again. Or else I'm misunderstanding what's going on.

It's also possible that we have dsps_check_status() getting called
again on disconnect before the new 20 second period is over, I did
not check for that yet.

Regards,

Tony

8< -----------------------
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -270,6 +270,10 @@ static int dsps_check_status(struct musb *musb, void *unused)
 		musb_writel(musb->ctrl_base, wrp->coreintr_set,
 			    MUSB_INTR_VBUSERROR << wrp->usb_shift);
 		break;
+	case OTG_STATE_A_HOST:
+		if (glue->vbus_irq)
+			dsps_mod_timer(glue, 20000);	/* 20s */
+		break;
 	default:
 		break;
 	}
-- 
2.13.0
