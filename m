From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 14:06:28 -0700
Message-ID: <20170511210628.GA3489@atomide.com>
References: <20170327175536.GP10760@atomide.com>
 <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
 <20170511200220.GH7154@uda0271908>
 <20170511202306.GY3489@atomide.com>
 <20170511204406.GI7154@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511204406.GI7154@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu@ti.com> [170511 13:47]:
> On Thu, May 11, 2017 at 01:23:06PM -0700, Tony Lindgren wrote:
> > 
> > Maybe try something like below, compile tested only. I don't
> > think I have any USB modem here to test with.
> 
> The patch below doesn't help. In device detach by the time
> dsps_check_status() is called, the otg state is already A_WAIT_BCON, set
> by musb_root_disconnect() in musb_stage0_irq() when handling DISCONNECT
> interrupt.

Oh OK.

> I don't think it is about how long the modem disappears. When detach happens,
> DISCONNECT interrupt happens, then dsps_check_status() is scheduled with
> state A_WAIT_BCON, then VBUS got cut.
> 
> BTY, I didn't debug with a modem, just with a device detach. Tring to
> see how to not cut vbus at all in dsps_check_status().

OK

> > It's also possible that we have dsps_check_status() getting called
> > again on disconnect before the new 20 second period is over, I did
> > not check for that yet.
> 
> After a few trials, I start to think about a little cleanup in the otg
> state machine in the musb drivers, I think we need to somehow
> distinguish between normal and error conditions for A_WAIT_BCON state.

Well maybe the minimal fix for now is just pretty much back to
square one of this thread. This should keep VBUS always on.
Then we can figure out some logic to cut VBUS later on.

And yeah, the state machine is really hard to follow so some kind
of clean up would be nice.

Regards,

Tony

8< -------------------
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -245,7 +245,6 @@ static int dsps_check_status(struct musb *musb, void *unused)
 		dsps_mod_timer_optional(glue);
 		break;
 	case OTG_STATE_A_WAIT_BCON:
-		musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 		skip_session = 1;
 		/* fall */
 
