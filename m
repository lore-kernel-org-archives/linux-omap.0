From: NeilBrown <neilb@suse.de>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Sat, 28 Jan 2012 11:40:12 +1100
Message-ID: <20120128114012.1bd76ca5@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
	<20120118082410.48262777@notabene.brown>
	<alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
	<20120124213705.49f042bf@notabene.brown>
	<alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com>
	<20120128093530.0a0a370a@notabene.brown>
	<alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ZZ6PQC59zyOHFCHywedbRZI"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40264 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2A1Ak1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 19:40:27 -0500
In-Reply-To: <alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/ZZ6PQC59zyOHFCHywedbRZI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jan 2012 15:58:40 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> On Sat, 28 Jan 2012, NeilBrown wrote:

> > > Here's a theory: perhaps the MPU powerdomain is hitting a low-power s=
tate=20
> > > while waiting for an HDQ interrupt.  When the MPU powerdomain is in a=
 low=20
> > > power state, so is the MPU interrupt controller, so the only way that=
 the=20
> > > MPU can wake up is if the HDQ can issue a wakeup event to the PRCM.  =
And I=20
> > > don't see any evidence that the HDQ is capable of doing this, based o=
n the=20
> > > HDQ sections of the TRM.  What a huge energy waste, if true.
> >=20
> > In the config I am testing MPU only goes to RET, never OFF. Same for CO=
RE.
>=20
> That qualifies as a low-power state for the MPU :-)
>=20
> In MPU RET, at least in theory, the MPU INTC will not be operational, and=
=20
> thus unable to respond to interrupts.
>=20
> > > Maybe try something like the following patch -- compile-tested only h=
ere.
> > >=20
> > > If this works, you might want to try dropping this patch and using th=
e pad=20
> > > mux to set a wakeup event on the 1-wire pad when the signal goes low.=
 =20
> > > That might be a more power-efficient approach.  You may still have to=
 use=20
> > > some PM QoS request there to ensure that the HDQ can wake up fast eno=
ugh=20
> > > to see the pulse, but the constraint shouldn't need to be as ludicrou=
sly=20
> > > low as it is in the following patch.
> >=20
> > Doesn't work - crashes :-(
> >=20
> > pm_qos_power_init is defined as a late_initcall, so you cannot call
> > pm_qos_update_request until after all the initcalls have run.
> > But with your patch, the probe of the bq27000 triggers a read of the re=
gisters
> > which tries to update_request - and it goes 'bang'.
>=20
> Hmm, okay.  Could you please remove the register read from the HDQ probe=
=20
> and see if that makes a difference?

Sorry, I misdiagnosed.  The problem was that the pm_qos_request structure
needs to be zeroed before pm_qos_add_request() or it complains, doesn't
initialise it, and future calls can crash.

So with 'kzalloc' in place of 'kmalloc' where hdq_data is allocated, the qos
patch does make my problem go away.  It feels a bit heavy-handed though.

>=20
> > I really think the problem is the CORE pwrdm gating a clock because no =
module
> > says it needs it - i.e. nothing to do with MPU at all.
>=20
> Until pm_runtime_put*() is called, the usecount of hdq_fck will still be=
=20
> non-zero.  So the CORE shouldn't be able to gate it or hdq_ick at that=20
> time, and thus should not be able to enter idle. Hence the question about=
=20
> where the problems occur: whether they occur in the middle of the=20
> transaction or when the HDQ clocks are disabled.
>=20
> > We want to keep CORE active when an HDQ transaction is happening, but M=
PU is
> > welcome to go to sleep.  I don't think you can express that with 'qos'.=
  I
> > think it needs some omap-specific machinery.
>=20
> The OMAP PRCM hardware should keep the CORE* clkdms active when the=20
> hdq_fck is enabled.  So it's possible there could be a PRCM silicon bug=20
> that doesn't take hdq_fck into account when determining whether the CORE_=
*=20
> clkdms are inactive.

That isn't the way I understand the TRM and the code.  I admit there is a l=
ot
that I don't understand, but I've really drilled down in this area and my
understanding aligns with what I see experimentally, so....

clkdm_allow_idle(struct clockdomain *clkdm) tells the hardware to allow that
clkdm to go idle, and it does so with no reference to whether any clk in the
clkdm is current enabled.  This seems to be called conditional only on which
IDLE state is being entered. Any state below C1 is entered with
clkdm_allow_idle in force.

When the hardware has been told that it can idle a clockdomain, it will
handshake with each module that uses the clockdomain.  i.e. it doesn't check
if the clock is enabled, it asks the module directly.

The module answers according to the SIDLE (slave idle) setting. This can be
set to
 - always say "no, don't idle, I'm busy"
 - always say "yes, force me idle, I don't care"
 - 'smartidle' where the response is based on the internal state of the
   module.

A good example of smartidle is the UART.  If it hasn't seen a character in =
or
out for about 10 (I think) character times it will say "yes, idle the clock=
",
else it will say "no".   When RX then goes low it will handshake back to say
"Hey, I'm busy all of a sudden, can I have the clock back please" which it
then gets in time to count off the start bit and then read the rest of the
incoming byte.(*)

However HDQ doesn't have SIDLE.  So the PRCM doesn't handshake with it.  It
just assumes that HDQ will say "yes, force me idle, I don't care".

The diversion about UARTs is relevant because when the UARTs have SIDLE set
to 'no' I don't see the problem (they keep the clock domain active).  It is
only when the UARTs set their SIDLE to smartidle that the problem appears.

So: if the HDQ driver wants the clkdm to stay on it has to explicitly arran=
ge
it in software by appropriate clkdm_deny_idle() calls.

=46rom the "System Power Management and Wakeup" section of the HDQ chapter of
the TRM:


     As part of the system-wide power-management scheme, the HDQ/1-Wire mod=
ule
     can go into idle state at the request of the PRCM module (for more inf=
ormation,
     see Chapter 3, Power, Reset, and Clock Management). However, the HDQ/1=
-Wire module
     does not support  handshake protocol with the PRCM.

and=20

     Software must ensure correct clock management.

It also mentions the AUTO_HDQ bit of PRCM.CM_AUTOIDLE1_CORE.  This had me
confused for a while, but I think it only affects the iclk.  I don't think =
the
iclk is the problem.  It is the fclk that is disappearing because the clkdm
that feeds it is being turned off.


>=20
> > I can 'fix' the problem simply by making sure
> >=20
> > 		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
> >=20
> > runs in omap3_enter_idle whenever HDQ is active.
>=20
> Hmm, that does suggest that it's not wakeup related.
>=20
> > One of the reasons that I think it is a clock problem rather than just=
=20
> > missing a wakeup event is that once the problem starts happening I=20
> > cannot recovery without rebooting. i.e. even if I tell the UARTs to kee=
p=20
> > the clocks on permanently and keep the CPUIDLE state at 0, the HDQ=20
> > doesn't start working again.  It has clearly become confused. The HDQ=20
> > doco makes a point of saying that you shouldn't issue any commands=20
> > (except 'enable clock') when the clock is disabled.  I think we end up=
=20
> > doing that and it gets confused and cannot recover.
> >=20
> > I note that there is an ad-hoc dependency between the camera and variou=
s=20
> > power states as well.  Maybe we need a little bit of infrastructure so=
=20
> > that camera can say "Keep CORE and MPU on" (or whatever it needs) and=20
> > HDQ can say "Keep CORE on".  ???
>=20
> I'm not familiar with the camera problems, but in the HDQ case, this=20
> should only be needed if a silicon bug exists.  Which is certainly=20
> possible; we've seen this problem with one other IP block in the past.=20
> Based on a quick glance at the errata, I don't see anything related to th=
e=20
> HDQ, but that doesn't really mean anything.
>=20
> In any case, we should be able to work around this via the hwmod layer an=
d=20
> a special flag, if the problem really is a PRCM bug.  This will depend on=
=20
> the functional powerstate conversion. =20

My idea of a fix would be a secondary reference count on each clkdm.
When a clk that doesn't have an associated SIDLE setting is activated we
increase this reference count (and decrease it when the clk is deactivated).

While the count is non-zero we deny_idle for that clkdm.

Or something like that.


Thanks for listening :-)

NeilBrown


>=20
> Thanks for the detailed test reports.
>=20
> - Paul


(*) Another note about UARTs.
  In 3.2 (haven't checked 3.3) the driver not only sets SMARTIDLE but also
  stops the clocks when things are idle.
  So when RX goes low and the UART wakes us up it doesn't get a clock
  straight away but we have to wait for code to enable the clock.
  In my experiments, this is fast enough to stay in-sync for speeds up to
  38400 (I think).  Above there we miss the first bit and get corrupt
  characters.
  I think that if the UART is expecting data it should not disable the clock
  but should use SMARTIDLE to let it turn off, and then turn back on again
  quickly.... but maybe 3.3 gets that right.

  NB

--Sig_/ZZ6PQC59zyOHFCHywedbRZI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyND7Dnsnt1WYoG5AQI1qxAAwkbXqpX1ddrIMX46e0hzrApJLzPRSFTB
B1Xxhf7iQIhFIfq5vl1S9Me9VyuGbmRxdWo5swcOUsjrXM1x8Cjg2Vse6tEcoca4
0vAkCuHL3VDLjUBMX+iQpd3LDWEGBJCjl9GrZ27/YdJMQ2WgtM2KmxokOzhFkD3p
ADmUJhmV+7PJRbNl/OaN0S1cYBUoSZEgJvruCMTU++ecVsW/PhAqR/a7H3jzgYgz
23gcRVJYHWEB1W+ZZpcNolOvaZjYtrdrxf+O/b6Dk0mXPv6h6Xks0YLtYjdrB2DQ
Ny1bOfLsggktJn7zvkryCtfYSYx/q4gAGYrg2N+1PraC5cgf/INEa/QMIxsoGii3
mNB/edWGajDbbHSxy7Q0UmRxGDolVF+haEnWlqja6IHVPPWROvHgAE4s+3fek81d
U8i9nQuwKoIwWpbrneoXsY8CWfef60ND1J7L6C5K1yafk99dWkv0YCqgLX1OVEvp
gBFMvgXx0wmkMW1TkTgEaKICwlrEm4R25c8RLUrt/ziI8qxgPuoAQ9OttGhABHc+
iLhFXZfPbl2R0G6rN0F3CnITnqHus5RsdNyogYt0bDSTfOOKXnH9R2U3+pcqHuWl
S59D65cZpL8XcAKy+3pu0POX1D0hV41ucQ9SXazFMljtpqGlUJu92YltE3QL0ApF
uvnvlkBJkdo=
=ei4r
-----END PGP SIGNATURE-----

--Sig_/ZZ6PQC59zyOHFCHywedbRZI--
