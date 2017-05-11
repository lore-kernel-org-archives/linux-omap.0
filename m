From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 14:10:05 -0500
Message-ID: <20170511191005.GG7154@uda0271908>
References: <00882633-3F61-4010-A4D2-D04473282B10@tecnorama.it>
 <20170327131701.GA12674@uda0271908>
 <20170327143049.GG10760@atomide.com>
 <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com>
 <20170327171534.GA4403@uda0271908>
 <20170327175536.GP10760@atomide.com>
 <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511190100.GF7154@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 11, 2017 at 02:01:00PM -0500, Bin Liu wrote:
> On Thu, May 11, 2017 at 11:55:28AM -0700, Tony Lindgren wrote:
> > * Bin Liu <b-liu@ti.com> [170511 11:53]:
> > > On Mon, Mar 27, 2017 at 10:55:37AM -0700, Tony Lindgren wrote:
> > > > * Bin Liu <b-liu@ti.com> [170327 10:17]:
> > > > > On Mon, Mar 27, 2017 at 09:59:47AM -0700, Tony Lindgren wrote:
> > > > > > * Moreno Bartalucci <moreno.bartalucci@tecnorama.it> [170327 09:23]:
> > > > > > > If I understood your patch, however, if the device (anyone, not just my one) takes longer to switch, VBUS is deasserted anyway.
> > > > > > 
> > > > > > Yeah some of them can take at least 10 seconds even to enumerate.
> > > > > > So probably we need to have to have some longer timeout set for
> > > > > > OTG_STATE_A_WAIT_BCON, like 20 or 30 seconds.
> > > > > > 
> > > > > > > Although this patch is working for me, personally I would prefer a solution which would not deassert VBUS. At least on a host only port. Honestly I don’t know how a dual role port should work.
> > > > > > 
> > > > > > It's been really long time since I read the OTG spec. There
> > > > > > may be some diagram showing the required timeouts in the spec
> > > > > > if there is one for VBUS.
> > > > > > 
> > > > > > Maybe we need some property to specify vbus-always-on-in-host-mode?
> > > > > 
> > > > > The MUSB otg state machine has been changed in many place since the last
> > > > > time I looked at it, and I am not sure how exactly it works now.
> > > > 
> > > > Yup.. I looked up the timers in the OTG spec and they are described
> > > > in chapter "8.5.5.2" as a_wait_bcon_tmo or a_wait_bcon_tmr. But
> > > > I could not find any values for them.
> > > > 
> > > > Anyways, clearly we want things working with real devices :)
> > > > 
> > > > > If the $subject patch can correctly keep the VBUS on for host-only mode,
> > > > > we can somehow use dr_modei value to distinguish the mode. We don't have
> > > > > to create a new vbus-always-on-in-host-mode flag. VBUS has to be always
> > > > > on in host-only mode anyway, until some error condition happens.
> > > > 
> > > > Yeh and it seems PM still works with the $subject patch also for
> > > > host mode. So maybe that's enough to fix the issue.
> > > > 
> > > > Also I don't have any idea why for ages we have been writing
> > > > 0 to devctl there.. Maybe we've had a bug there that only now
> > > > shows up when we idle things.
> > > 
> > > The otg state machine implementation in the musb drivers are kind of strange.
> > > OTG_STATE_A_WAIT_BCON suppose to be a steady state when no usb device is
> > > attached, but the musb drivers use it as a transient state to handle error
> > > cases, such as overcurrent ot HNP timeout, which is done in the 'case
> > > OTG_STATE_A_WAIT_BCON' branch in otg_timer() (or dsps_check_status() for dsps
> > > glue).
> > > 
> > > Then later when 2f3fd2c5bde1 adds
> > > 
> > > -       /* Poll for ID change in OTG port mode */
> > > -       if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
> > > -                       musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
> > > +       /* Poll for ID change and connect */
> > > +       switch (musb->xceiv->otg->state) {
> > > +       case OTG_STATE_B_IDLE:
> > > +       case OTG_STATE_A_WAIT_BCON:
> > >                 mod_timer(&glue->timer, jiffies +
> > >                                 msecs_to_jiffies(wrp->poll_timeout));
> > > +               break;
> > > 
> > > which causes dsps_check_status (or otg_timer()) got called for a normal
> > > condition with OTG_STATE_A_WAIT_BCON, then turns off VBUS...
> > > 
> > > Will try to see how to solve this...
> > 
> > Maybe we just need to add back the earlier check for non-OTG devices
> > "musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE" into case
> > OTG_STATE_A_WAIT_BCON?
> 
> Not sure if it will work. The check is to kick out device-only mode.
> DUAL_ROLE means both OTG and host-only.
> 
> > 
> > Not sure if am335x configured with host port ever idle that way,
> > but maybe VBUS can be kept on with musb idle.
> 
> Just tried to remove 
> 
> +       case OTG_STATE_A_WAIT_BCON:
> 
> for the polling, but the port stops detecting device attach, musb
> power/devctl registers are good, trying to see why... maybe related to
> PM state?

usb_otg_hs is idle, so not able to detect attach. So need to get the
timer rolling in here to make it detect working.
Maybe need to add a flag in dsps_check_status() to not turn off vbus in
this case? Really don't like the idea...

Regards,
-Bin.
