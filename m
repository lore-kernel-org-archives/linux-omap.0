From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 1/9] omap4: powerdomain: Add supported INACTIVE power
 state
Date: Mon, 7 Feb 2011 18:32:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102071801540.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102061335400.7672@utopia.booyaka.com> <9cb5f3c283cc93d27be0c727f6f3bafa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60570 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab1BHBc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 20:32:28 -0500
In-Reply-To: <9cb5f3c283cc93d27be0c727f6f3bafa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 7 Feb 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, February 07, 2011 2:12 AM
> >
> > Continuing the discussion here:
> >
> >    http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg43509.html
> >
> > 1. It appears that the OMAP4 powerdomain ON-ACTIVE state is a new
> > state
> > for OMAP4, and does not exist as such on previous chips (unless the
> > PRM_VOLTCTRL.AUTO_* bits are all disabled)
> >
> Actually it's not new state but more of convention change. ON-ACTIVE
> is like ON in OMAP3.

Hmm, based on our earlier list mails, that seems confusing.  Setting an 
OMAP3 powerdomain next-power-state to 'ON' in OMAP3 allows voltage domain 
transitions to the SLEEP level.  But setting an OMAP4 powerdomain 
next-power-state to 'ON-ACTIVE' does not allow voltage domain 
transitions to the SLEEP level.  And setting an OMAP4 powerdomain 
next-power-state to 'ON-INACTIVE' does allow voltage domain transitions to 
the SLEEP level.  Is that correct?

If that's correct, then OMAP4 ON-ACTIVE is a functionally new powerdomain 
next-power-state setting, and OMAP4 ON-INACTIVE is the same state as OMAP3 
ON.  Unless there's something obvious that I'm missing?

> > 2. It also appears that the OMAP4 powerdomain ON-INACTIVE state
> > is equivalent to the OMAP3 powerdomain ON state (again, assuming
> > that the
> > PRM_VOLTCTRL.AUTO_SLEEP bit is set on OMAP3).
> >
> This is correct.
> 
> > Could you please comment on whether these statements are true or
> > false?
> >
> 
> Just to summarise my undertsnaing of this here.
> On OMAP3 too, we had possibility of being in a one of the
> Two state when programmed to PD ON state.
> ON-ACTIVE or ON-INACTIVE. The PD status registers just
> says INACTIVE or ON based on the clodomains states within PD.

Right, but when 'ON' is written into an OMAP3 powerdomain's 
next-power-state bits, voltage domain transitions are allowed.  So I'm 
just trying to confirm that OMAP3 ON state is functionally equivalent to 
the OMAP4 ON-INACTIVE state, and not functionally equivalent to the OMAP4 
ON-ACTIVE state.

We have to ensure that the core code-internal meaning of the (ON, 
INACTIVE, RET, OFF) states doesn't vary across SoC types.  Otherwise "ON" 
on OMAP4 won't mean "ON" on OMAP3, and the goal is for the core code to be 
SoC-independent.

One way to do that would be to add a small mapping layer for the 
powerdomain set-next-power-state code to:

- allow programming INACTIVE on OMAP3, by ensuring that, when all 
  powerdomains in a voltage domain are in INACTIVE, that AUTO_SLEEP
  is set to 1, and then setting the hardware next-power-state to ON; and

- allow programming ON on OMAP3, by ensuring that AUTO_SLEEP is set 
  to 0, and setting the hardware next-power-state to ON.

On OMAP4, presumably it wouldn't be needed to mess with the AUTO_SLEEP 
bit.

Probably to make that work cleanly, either clockdomains or powerdomains 
would need to be associated with voltage domains; and some kind of counter 
would need to be implemented in the voltage domains to indicate when it is 
appropriate to write to the AUTO_SLEEP bit.


- Paul
