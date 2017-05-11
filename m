From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH] usb-musb: keep VBUS on when device is disconnected
Date: Thu, 11 May 2017 15:02:20 -0500
Message-ID: <20170511200220.GH7154@uda0271908>
References: <63FD9E13-2B70-485C-80A7-206BEC16905A@tecnorama.it>
 <20170327165946.GL10760@atomide.com>
 <20170327171534.GA4403@uda0271908>
 <20170327175536.GP10760@atomide.com>
 <20170511185038.GE7154@uda0271908>
 <20170511185528.GW3489@atomide.com>
 <20170511190100.GF7154@uda0271908>
 <20170511191005.GG7154@uda0271908>
 <20170511192013.GA4459@uda0271908>
 <20170511193810.GX3489@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170511193810.GX3489@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Moreno Bartalucci <moreno.bartalucci@tecnorama.it>, Lars Melin <larsm17@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alessio Igor Bogani <abogani@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 11, 2017 at 12:38:11PM -0700, Tony Lindgren wrote:
> * Bin Liu <b-liu@ti.com> [170511 12:23]:
> > On Thu, May 11, 2017 at 02:10:05PM -0500, Bin Liu wrote:
> > [...]
> > > > > > The otg state machine implementation in the musb drivers are kind of strange.
> > > > > > OTG_STATE_A_WAIT_BCON suppose to be a steady state when no usb device is
> > > > > > attached, but the musb drivers use it as a transient state to handle error
> > > > > > cases, such as overcurrent ot HNP timeout, which is done in the 'case
> > > > > > OTG_STATE_A_WAIT_BCON' branch in otg_timer() (or dsps_check_status() for dsps
> > > > > > glue).
> > > > > > 
> > > > > > Then later when 2f3fd2c5bde1 adds
> > > > > > 
> > > > > > -       /* Poll for ID change in OTG port mode */
> > > > > > -       if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
> > > > > > -                       musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
> > > > > > +       /* Poll for ID change and connect */
> > > > > > +       switch (musb->xceiv->otg->state) {
> > > > > > +       case OTG_STATE_B_IDLE:
> > > > > > +       case OTG_STATE_A_WAIT_BCON:
> > > > > >                 mod_timer(&glue->timer, jiffies +
> > > > > >                                 msecs_to_jiffies(wrp->poll_timeout));
> > > > > > +               break;
> > > > > > 
> > > > > > which causes dsps_check_status (or otg_timer()) got called for a normal
> > > > > > condition with OTG_STATE_A_WAIT_BCON, then turns off VBUS...
> > > > > > 
> > > > > > Will try to see how to solve this...
> > > > > 
> > > > > Maybe we just need to add back the earlier check for non-OTG devices
> > > > > "musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE" into case
> > > > > OTG_STATE_A_WAIT_BCON?
> > > > 
> > > > Not sure if it will work. The check is to kick out device-only mode.
> > > > DUAL_ROLE means both OTG and host-only.
> > > > 
> > > > > 
> > > > > Not sure if am335x configured with host port ever idle that way,
> > > > > but maybe VBUS can be kept on with musb idle.
> > > > 
> > > > Just tried to remove 
> > > > 
> > > > +       case OTG_STATE_A_WAIT_BCON:
> > > > 
> > > > for the polling, but the port stops detecting device attach, musb
> > > > power/devctl registers are good, trying to see why... maybe related to
> > > > PM state?
> > > 
> > > usb_otg_hs is idle, so not able to detect attach. So need to get the
> > > timer rolling in here to make it detect working.
> > > Maybe need to add a flag in dsps_check_status() to not turn off vbus in
> > > this case? Really don't like the idea...
> 
> Yeah that's what I recall too. The timer is needed until the m3 can
> implement an irqchip and we can set that up as the irq for the host
> only port.
> 
> > I am not sure I gave out the picture clearly.
> > 
> > Before added the runtime PM support, in host mode (devctl=0x19) the
> > otg_timer is stopped, the controller is ready to detect attach.
> > 
> > Later when added the runtime PM support, usb_otg_hs hwmod becomes idle
> > when a device is detached, so the otg_timer is needed to keep hwmod
> > enable/idle periodically to detect attach, which triggers the issue
> > because otg_timer() turns off vbus unconditionally when otg state is
> > OTG_STATE_A_WAIT_BCON.
> 
> I wonder if just keeping VBUS on longer in OTG_STATE_A_WAIT_BCON
> solves this issue?

We don't cut VBUS intentionally for host mode (when devctl=0x19). The
VBUS got cut in this case only because when a device is detached, the
otg state changes from A_HOST -> A_WAIT_BCON, then otg_timer() cuts VBUS
and sets the state to A_IDLE, then next otg_timer() turns on VBUS (I
haven't check how the otg state becomes A_WAIT_VRISE from here).

Not sure how to *easily* keep VBUS here, without adding condition check
in otg_timer() for TG_STATE_A_WAIT_BCON.

> solves this issue? It seems the issue is with modems that get
> reconfigured after the initial enumeration?

Idealy we shouldn't cut VBUS at all in this case for host-only. I am
looking for a small patch to solve this, if possilbe ;)

> 
> We could poll for new devices every 2 seconds, if anything is seen
> on the bus, keep VBUS on at least 20 seconds, then if nothing is
> found, poll every 2 seconds again.

I am not sure this is relevant, VBUS is constantly on once the otg stage
becomes A_HOST -> A_WAIT_BCON -> A_IDLE -> A_WAIT_VRISE, within a
second.

Regards,
-Bin.
