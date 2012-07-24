From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Tue, 24 Jul 2012 08:36:08 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E972876@DBDE01.ent.ti.com>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
 <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
 <20120723133704.GB21254@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9727CB@DBDE01.ent.ti.com>
 <20120724080724.GA29810@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51732 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab2GXIiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:38:08 -0400
In-Reply-To: <20120724080724.GA29810@avionic-0098.mockup.avionic-design.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 24, 2012 at 13:37:24, Thierry Reding wrote:
> On Tue, Jul 24, 2012 at 07:52:06AM +0000, Philip, Avinash wrote:
> > On Mon, Jul 23, 2012 at 19:07:04, Thierry Reding wrote:
> > > On Mon, Jul 23, 2012 at 12:44:38PM +0000, Philip, Avinash wrote:
> > > > On Mon, Jul 23, 2012 at 14:52:04, Thierry Reding wrote:
> > > > > On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> > > > > > On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > > > > > > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > > > > > > +	/*
> > > > > > > > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > > > > > > > +	 * and  'APWM mode' to enable APWM output
> > > > > > > > +	 */
> > > > > > > > +	reg_val = readw(pc->mmio_base + ECCTL2);
> > > > > > > > +	reg_val |= ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > > > > > > 
> > > > > > > You already set the APWM_MODE bit in .config(), why is it needed here
> > > > > > > again? Seeing that .disable() clears the bit as well, perhaps leaving it
> > > > > > > clear in .config() is the better option.
> > > > > > 
> > > > > > Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pin = low 
> > > > > > in idle state).
> > > > > > 
> > > > > > The Period & Compare registers are updated from Shadow registers (CAP1 & CAP2)
> > > > > > During PWM configuration. To enable loading from Shadow registers, APWM mode 
> > > > > > should be set.
> > > > > > The same is done in .config().
> > > > > 
> > > > > My point was that if you do it in .enable(), then why do you still set
> > > > > it in .config()? Since the sequence is typically .config() followed by
> > > > > .enable(), setting the bit in both seems redundant. It should be enough
> > > > > to load the registers during .enable(), right?
> > > > 
> > > > Consider scenarios where .enable() can be called without calling .config().
> > > > Example I just need to stop the pwm signal momentarily and re-enable.
> > > > In this case, .config() need not be called. So, APWM mode bit needs to be 
> > > > set in .enable()
> > > > 
> > > > Now, considering .config() followed by .enable().
> > > > Currently in PWM driver, the CAP1 & CAP2 registers is copied to shadow 
> > > > Registers (CAP3 & CAP4) by hardwaare in .config(). This requires APWM
> > > > mode bit to be set. 
> > > > 
> > > > The same can be done in .enable() also. However, we again need to pass 
> > > > the pwm parameters (period & duty cycle values) to the .enable(). 
> > > > We don't want to duplicate this parameter passing. 
> > > > To avoid this we enable the APWM mode bit in both .config() & .enable().
> > > 
> > > That's weird. I assumed that the values written to the shadow registers
> > > would automatically be copied to the active registers on each new PWM
> > > period.
> > 
> > This is correct in case if PWM is running.
> > 
> > > If I understand correctly what you're saying, however, the eCAP
> > > requires the APWM bit to be set in order to write the shadow registers
> > > at all.
> > 
> > In APWM mode, writing to CAP1/CAP2 (active registers) will also write the
> > same value to the corresponding CAP3/CAP4 (shadow registers). This emulates
> > immediate mode. 
> > 
> > Writing directly to the shadow registers CAP3/CAP4 will invoke the
> > shadow mode.
> > 
> > If PWM is not running, cycle & duty values written to active registers, not
> > to shadow registers. To copy these value to shadow registers APWM mode to be
> > set. This way reloading from shadow registers can be ensured on next PWM
> > period/cycle.
> 
> I think this is the part I don't understand. If you wrote cycle and duty
> values to the active registers already, then the shadow registers should
> be ignored by the hardware. There should be no need to reload the active
> registers.

ECAP PWM hardware always loads active registers from shadow registers at
counter = period value (starting of next period). So on every next cycle
active registers being updated from shadow registers. So shadow registers
acting as a backup.

> 
> > If PWM is running, cycle & duty values written to shadow registers. So that
> > it won't disturb current PWM period. On the next PWM period, new values will
> > be reloaded from shadow registers to active registers.
> > 
> > So APWM mode to be set to copy shadow registers from active registers
> > (immediate mode).
> 
> I realize that I'm just talking from a general understanding of shadow
> registers and maybe you're hardware doesn't work quite that way. If this
> is really the only way that you can make the hardware work then I will
> no longer object.

Ok.

Thanks
Avinash

> 
> Thierry
> 

