From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Recent additions to omap2 clock.c
Date: Wed, 1 Nov 2006 14:33:22 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508693948@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Thanks for reviewing the changes, and sorry for the late reply -- I
was
> out-of-office for two weeks.
>=20
> Woodruff, Richard wrote:
> > Juha,
> >
> > I was looking to do some merging and I see you added the following:
> > 	1: Force APLL always on control
> > 	2: Enable/Disable for osc_clk
> > 	3: addition delays: clk_wait_ready, wmb
> >
> > For 1 and 2:
> > Aren't these more functions of idle control? I was looking at
porting
> > over some of the omap1 idle api's and I though that associating the
auto
> > idle's of APLLs and the like would map to this. Is there any reason
you
> > didn't take this route also?
>=20
> It looks like the idle control of the APLLs by hardware is pretty
> efficient, so we didn't see any reason to manually control their
usage.
>   Can you think of a use case?

It's a clock attribute which seems most naturally expressed as part of
the clock node structure.

2nd thought was latency.  I was thinking about embedding a latency field
into the clock nodes.  This can help determine if the stack up of
latencies.  L1-latency of local clock gating, L2-interconnect gating
latency, L3-clock domain, L4-APLL relock time,
L5-external-oscillator-relock time.  A parallel level of latencies might
be also summed up via the voltage frame work.  Each regulator/LDO/DCDC
will have a ramp/fall time, and each power domain has some latency
associated with its possible states.

There was a latency patch proposed for the kernel for use with some
Intel wireless driver.  My general feeling was drivers could publish
determined latencies, then some policy piece could possible walk the
clock tree to get latency of a path.  You don't want to have unexpected
domain transitions which hurt device QOS.

I kind of think this could be a reasonable direction.  The
implementation time line and details are another issue.  For OMAP3 the
use of DPS (dynamic power switching of power domains) and more
aggressive SLM (static leakage management) is the current guidance.  We
will need to provide more support for these techniques.

> osc_clk is a different story.  It's an external clock, and other
> peripherals besides OMAP might be using it.  The external oscillator
> control might be controlled by only OMAP, however.  In my opinion, if
> the driver says clk_enable to a clock, it should be guaranteed that
the
> clock remains active until a matching clk_disable is called.

Not allowing the stopping the osc_clk can cause you ?1.5mA or so in low
power states.  I think if you have a driver which needs it, it should
just make sure the idle attribute can't be set.

Right now the OMAP2 tree has not yet adopted the idle APIs.  I think it
needs to and the more symmetrically the clocks are handled the better.


> > For 3:
> > the original clock code had a clk_safe() api which was called after
> > clock enables to synchronize and let the caller know if all was ok.
You
> > might find when the functional clock was slow (32KHz) it might take
a
> > cycle for the peripheral to be accessible, generally after a wake
up. If
> > you are talking about a timer, you must also watch posting vs.
> > non-posting and the interconnect ratio during DVFS.
>=20
> I believe that clk_enable() should make sure the clock is indeed
active
> and usable, and not return before it is so.

Perhaps.  Defiantly this is an attribute which needs to be known.  In
our Symbian base port clock resources carry a synchronous or
asynchronous identifier and the possibility for the registration of a
call back.  The clk_safe addition allowed a way to know if it was ok.

Having detailed information about the amount of time all these events
require should be a big factor in determine what is necessary.

> > Also, status isn't always as you would infer. Some blocks didn't
hook
> > up the OCP control signals so they don't consult with the module
before
> > setting status. Other combined target/initiators like DSS only tie
to
> > mstandby state for idle, so you must stop mute before access works
> properly.
>=20
> Thanks for your info.  Could you elaborate on what clocks exactly need
> special handling?

Things which use the 32KHz clock in one way or the other tend to fall
into this category.

Regards,
Richard W.
