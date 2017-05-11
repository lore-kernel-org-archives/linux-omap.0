From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 13:50:38 -0500
Message-ID: <20170511185038.GE7154@uda0271908>
References: <20170315140801.97230-1-moreno.bartalucci@tecnorama.it>
 <20170324185836.GC19814@uda0271908>
 <2d10809f-d482-ffa9-30b7-8785e94ab102@gmail.com>
 <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
 <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com>
 <20170327171534.GA4403@uda0271908>
 <20170327175536.GP10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327175536.GP10760@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 27, 2017 at 10:55:37AM -0700, Tony Lindgren wrote:
> * Bin Liu <b-liu@ti.com> [170327 10:17]:
> > On Mon, Mar 27, 2017 at 09:59:47AM -0700, Tony Lindgren wrote:
> > > * Moreno Bartalucci <moreno.bartalucci@tecnorama.it> [170327 09:23]:
> > > > If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.
> > > 
> > > Yeah some of them can take at least 10 seconds even to enumerate.
> > > So probably we need to have to have some longer timeout set for
> > > OTG_STATE_A_WAIT_BCON, like 20 or 30 seconds.
> > > 
> > > > Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.
> > > 
> > > It's been really long time since I read the OTG spec. There
> > > may be some diagram showing the required timeouts in the spec
> > > if there is one for VBUS.
> > > 
> > > Maybe we need some property to specify vbus-always-on-in-host-mode?
> > 
> > The MUSB otg state machine has been changed in many place since the last
> > time I looked at it, and I am not sure how exactly it works now.
> 
> Yup.. I looked up the timers in the OTG spec and they are described
> in chapter "8.5.5.2" as a_wait_bcon_tmo or a_wait_bcon_tmr. But
> I could not find any values for them.
> 
> Anyways, clearly we want things working with real devices :)
> 
> > If the $subject patch can correctly keep the VBUS on for host-only mode,
> > we can somehow use dr_modei value to distinguish the mode. We don't have
> > to create a new vbus-always-on-in-host-mode flag. VBUS has to be always
> > on in host-only mode anyway, until some error condition happens.
> 
> Yeh and it seems PM still works with the $subject patch also for
> host mode. So maybe that's enough to fix the issue.
> 
> Also I don't have any idea why for ages we have been writing
> 0 to devctl there.. Maybe we've had a bug there that only now
> shows up when we idle things.

The otg state machine implementation in the musb drivers are kind of strange.
OTG_STATE_A_WAIT_BCON suppose to be a steady state when no usb device is
attached, but the musb drivers use it as a transient state to handle error
cases, such as overcurrent ot HNP timeout, which is done in the 'case
OTG_STATE_A_WAIT_BCON' branch in otg_timer() (or dsps_check_status() for dsps
glue).

Then later when 2f3fd2c5bde1 adds

-       /* Poll for ID change in OTG port mode */
-       if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
-                       musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
+       /* Poll for ID change and connect */
+       switch (musb->xceiv->otg->state) {
+       case OTG_STATE_B_IDLE:
+       case OTG_STATE_A_WAIT_BCON:
                mod_timer(&glue->timer, jiffies +
                                msecs_to_jiffies(wrp->poll_timeout));
+               break;

which causes dsps_check_status (or otg_timer()) got called for a normal
condition with OTG_STATE_A_WAIT_BCON, then turns off VBUS...

Will try to see how to solve this...

Regards,
-Bin.
