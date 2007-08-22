From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
	viathe clock framework
Date: Wed, 22 Aug 2007 16:25:04 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901B38ED9@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708220312320.15587@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708220312320.15587@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> From: paul@utopia.booyaka.com [mailto:paul@utopia.booyaka.com] On
Behalf
> > Like I was indicating for OMAP2/3 if the PRCM auto idle was switched
> > with the module auto-idle it would not be noise it would be
substantive.
>=20
> It sounds like one doesn't even need to switch these bits, once we
turn
> them on, correct?  Just enable *_SYSCONFIG autoidle and ICLK autoidle
at
> boot in pm.c, and then never disable them, with no ill effects.  Some
> extra latency perhaps?  Drivers that need to toggle them to work
around
> some hardware bug can just do that themselves, for the time being...

Yes.

There are some nuances which could be talked about but probably not
needed at this point.

> > 	-- One issue here is the address range for this bit is with each
> > driver in the _generic_ IP OCP (open core protocol bus interface)
> > wrapper header.  To write to this you need i+f clock on.  It still
helps
> > to set this bit even if the module is off as the clock tree can
still be
> > active and dissipating some power in the module.
>=20
> You're talking about the *_SYSCONFIG autoidle bits here, right?  So to
set
> those properly we'd need to walk the clock tree, enabling module
clocks
> and setting the *_SYSCONFIG autoidle bit, then powering the module
clocks
> back down again?

Yes.
=20
> > 	-- This is what the patch I sent out a while back was about
> > (RFC/PATCH) to just enable all of these.  It did save a lot of
power.
>=20
> I just took another look at that patch.  The only downside is latency,
> right?  Are you thinking about updating the patch for the new PRCM
access
> code?  That would make it much easier to test...

At this level the latency should be very minimal compared to the active
power savings.  At the module level it should be on the order of a few
clocks.  With many of these clocks in the MHz range its some nano
seconds.

The danger is in cascade latency if all modules are set this way and the
upper members of the tree have their auto controls set.  The big
latencies are not at the modules (except for some in OFF mode).

Actually the patch as I sent it was completely self contained it was
done that way just to be fast :)  Changing it to use the macros is no
problem.  I'd probably shy away from using the clock frame work to turn
on and off each clock via name string though.  They would result way too
much code.

> > 	** As its generic and symmetric for every IP in the OCP wrapper
I
> > personally like to stick it all in one spot inside of adding a bunch
of
> > defines to every driver.
>=20
> Since all of those registers are in SCM space, perhaps an scm.h/scm.c
file
> might be useful here.  I've been running into this with
CONTROL_DEVCONF*
> on 3430 code.  I don't think the *_SYSCONFIG powersave bits fit well
into
> the clock framework, so we should probably place it outside the
clocks.
> I do think it would make sense to specifically encode the power domain
> that each clock resides in into the struct clk, for use by PM or SCM
code.

The OCP registers are in each modules address space.  An example of what
I was talking about is GTP1.TIOCP_CFG:0x48318010.

The SCM (system control module) is something else.  It has bearing for
power in setting the right state for pins in sleep and io ring wake up.
I don't think they belong in the clock frame work either.  Though the
prcm many need to make api calls to it.

> > 	** Recently we internally were debating a bit about if an API
was
> > needed as you really in some cases do need to set the CLOCKACTIVITY
bits
> > in the OCP wrapper depending on the drivers mode of activity.
>=20
> I've been looking at these CLOCKACTIVITY bits and am not clear on the
> intended use.  They are read-only in many modules, at least according
to
> the TRM.  There is a notation about "Clock activity during wakeup mode
> period" -- could you elaborate about what that means?

Well some aspects of this are a little fuzzy to me also.  However, I
know generally how they are to be used in practice.

I think of them as how the internal clocks of the module will be handled
at idle-ack time (like when the L3/L4{interconnect} clock domains go
idle, i.e. this auto ICLK handling time stuff which was being talked
about).

Internally in the module at these times the module can choose to handle
its clocks in different ways.  If you don't need 'partial' activity
(meaning functional clock working while iclock is cut) you set it up to
allow gating of both I and F clocks.  If you want partial activity you
make sure the F clock isn't module-internal modified.

One example is say a timer.  If I target a low power idle mode I can get
the interconnects to go to clock stop (Iclocks off to CORE say) but I
can set the activity on the gp-timer such that it keeps ticking -and-
can even say generate a wake up (from clock stop) interrupt which brings
the L3/L4 out of clock stop.  On say a 2430 this will have a system at
say average of 2mA but still be ticking at a HZ=3D100 rate from a core
domain clock.  This is compared to say a 60mA idle when not hitting
clock stop. I can telnet into a system and it is still responsive but
has really very low power.  This is distinct from system wide retention
who's currents might be in the 100uA range but nothing is functional.
Only a 'wakeup' domain interrupt will start you chip going again.  Make
sure not to mix up 'chip' retention (all domains) with just say
MPU-retention which is more or less independent of the CORE.

If during this idle time I don't' care about a particular modules I and
F clocks I can set the clockactivity bits to allow internal gating of
both I and F clocks.  The F-clock tree won't stop as some other module
might need it, but my module can gate it saving power.

On OMAP3 if you are using software control methods you may need to set
these in a particular way to ensure data has cleared before shutting
down the module.  I don't expect control at this granularity makes sense
for our typical usage, but if you are doing full hardware dependency for
idling it is relevant.

> > When ICLKEN is enabled and the PRCM-auto-idle is enabled hardware
can
> > manage that clock at domain change time assuming the peripheral
> > handshakes it ok (force/no/smart).
> >
> > If the ICLKEN is disabled the setting of PRCM-auto-idle has no
effect.
>=20
> Okay, makes sense.
>=20
> > One of the big target states for big power savings is this so called
> > 'partially' active state.  In this case you do want the clock
domains
> > and the power domains states to not be in sync.  The L3/L4 can be
> > stopped, but say an F-Clock to a McBSP can still be running pushing
data
> > out to a codec.  If programmed up correctly, the codec need for data
can
> > automatically signal the prcm to re-activate the L3/L4 then allow
the
> > new data to flow.
>=20
> This is via the WKDEP/SLEEPDEP registers, correct?  or is this via
another
> mechanism?

No.  These registers are more targeted at reducing latency when OFF mode
is used.  They allow early power up of domains.  These are useful when
coming from inactive states not active or partially active ones.

One fun fact here is you can say set up a WKDEP such that the MPU is
powered on when something happens on say the DSP (MPU used to be in
retention).  However, if you don't have an interrupt routed to the MPU,
it will still be stuck in clock domain stop and just now be drawing more
power in ON state.  Some time later the OS timer fires and the MPU can
wake do its thing and then re-WFI back to retention.  The power draw due
to the mis-programming of the WKDEP caused extra consumption even though
the ARM wasn't doing work.  Now, if the ARM was in OFF mode, this early
power up could have saved some time.

> > However, other bits in the same range CLOCKACTIVTY do have a bit
more
> > need of dynamic access.  WE enable also might be conditionally set.
>=20
> Sorry, you lost me there - what is WE enable?

I was talking about XYZ_SYSCONFIG.ENWAWAKEUP bit in OCP header.

> Thanks for all of the detailed information, Richard,

Happy to, especially if it translates to better functionality.

Regards,
Richard W.
