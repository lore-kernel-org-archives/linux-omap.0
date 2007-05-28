From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: write memory barrier
Date: Mon, 28 May 2007 08:47:35 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290115849C@dlee13.ent.ti.com>
References: <1180304111.3430.31.camel@Dogbert.NOE.nokia.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901158463@dlee13.ent.ti.com>
	<1180334172.18692.34.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1180334172.18692.34.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: Linux OMAP ml <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


> > Generally, the commit of a divider change should happen in SRAM.
>=20
> Or from icache, after an appropriate pre-fetch of the critical section
> of code that cannot be executed from sdram, right?

Yep.

> > Some clocks do have some side effects of changes, but it might be
> > unlikely you access them quickly enough to see the effect.  M/N
changes
> > take a while.  Depending on I to F clock ratios and
posted/non-posted
> > timers might take a bit.
>=20
>=20
> Here, if i've understood correctly, you are also referring to hw
timing,
> which certainly have to be considered, but I was thinking about
> out-of-order execution and the compiler potentially reshuffling the
> configuration i'm doing.

Yes, ok.

> I'm changing the settings of CM_CLKSEL_* and my understanding is that
> afterward, to have the changes applied, I have to write 1 to
> PRCM_CLKCFG_CTRL[VALID_CONFIG]
>=20
> My concern is that the write order is changed and
> PRCM_CLKCFG_CTRL[VALID_CONFIG] gets written _before_ proper settings
> have been programmed into CM_CLKSEL_* thus effectively leadinig to
> either:
> -invalid configuration and changes not been applied at all, which is
> somehow preferrable to
> -valid, but different from the expected, configuration, with some of
the
> new values applied and some of fthe old ones retained

Couple of thoughts:=20

-1- the clock code usage was set up all the dividers in C code, then
jump into assembly in SRAM to do the final commit.  In that case the
compiler would not have moved anything after the commit.

-2- Yes ARMv6 can complete out of order.  However, the ARMv6 memory
model defines things such that you can enforce ordering.  Internal
memory accesses are currently marked as no-cache-strongly-ordered.  I
think this access in itself serializes instructions around it.

If you just mark things as 'non-cached' then they can be done
out-of-order.  If you mark things as 'device'  Then they will happen
in-order but might be posted through the bus below.

> So i guess my question (at the moment) boils down to:
> do i have to insert a wmb (or maybe barrier, if the compiler is the
only
> entity that can change the order of execution) between the programming
> of CM_CLKSEL_* and writing 1 to PRCM_CLKCFG_CTRL[VALID_CONFIG]?

If its happening in-line in some code somewhere I wouldn't hurt, incase
the compiler doesn't see any dependency.  Below the access should be
volatile which should have clobbered optimizations, but an explicit
barrier is probably better.  I don't think however, with current
mappings the hardware would re-order it on you.

-- One tip of the day is you can save some power by setting
module-level-auto-idle of some devices even if that device is switched
off at I and F clock.  Security peripherals are an example which at run
time does save like 6-9mA.  For security ones, you must be careful
around sleep though, as the idle-ack is slow and if you access it (say
rng) then wfi before it finishes it can draw an extra 600uA in sleep.
Others had reported some of this before, but I've only recently played
with the same.  For things which have a shared F-Clock, shutting off the
local F-Clock result in a hardware usecount dropping, but not necessary
a gating of the effect of that clock in the module (unless auto-idle is
set).

Regards,
Richard W.
