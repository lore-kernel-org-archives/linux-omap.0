From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 20 Jan 2012 08:05:08 +1100
Message-ID: <20120120080508.0dc0c758@notabene.brown>
References: <20120113222045.37f9b4ec@notabene.brown>
	<1326870839.1954.23.camel@deskari>
	<20120118221538.342b4782@notabene.brown>
	<1326886940.1999.5.camel@lappy>
	<20120119073032.74cc0992@notabene.brown>
	<WC20120119101721.07072A@terrafix.co.uk>
	<1326969658.1935.24.camel@deskari>
	<WC20120119112911.670749@terrafix.co.uk>
	<1326973019.7926.7.camel@lappy>
	<WC20120119122128.020787@terrafix.co.uk>
	<87y5t3trek.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/iKbQBgg2iDdA126=Sjz.s/K"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34784 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818Ab2ASVFY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 16:05:24 -0500
In-Reply-To: <87y5t3trek.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

--Sig_/iKbQBgg2iDdA126=Sjz.s/K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jan 2012 11:37:39 -0800 Kevin Hilman <khilman@ti.com> wrote:

> "Joe Woodward" <jw@terrafix.co.uk> writes:
>=20
> [...]
>=20
> > If I do (either from the console or via a button press on the screen)
> > then I never get a SYNC_LOST.
> >
> >   echo 0 > /sys/devices/omapdss/display0/enabled
> >   echo 1 > /sys/devices/omapdss/display0/enabled
> >
> > Just trying to think of some ideas that may be affecting the DSS...
> >   - Could it to be to do with the GPIO being used as a wake source (i.e=
. does the GPIO driver do runtime_pm properly?)?
> >   - Could it to be to do with the UART as it seems to fix itself whenev=
er a character is pressed?
> >   - Could it to be to do with the ordering in which drivers are resumed?
>=20
> Here's my guess/hunch as to why the UART wakeup helps and GPIO doesn't.
>=20
> The UART's are idled using timeouts, so after any activity (including a
> wakeup) the UART timeout will not alow the UARTs to idle (and thus the
> system to hit low power states) for a given timeout period.

While I agree with that, I'm wondering if there might be something else odd
relating to the UARTs that we haven't spotted yet.

I'm chasing done the different problem of HDQ not coping with CPUIDLE but I
think it is very likely to have a similar root cause, as HDQ goes wrong at
the same time that DSS goes wrong, and is a vaguely similar way.

I just tried compiling omap_hwmod.c with "#define DEBUG" and got some stran=
ge
results.

Firstly: something strange early in boot.  Here is an annotated extract from
the dmesg log:

[    0.862304] omap_hwmod: l4_wkup: enabling
[    0.866546] omap_hwmod: l4_wkup: enabling clocks
[    0.871429] omap_hwmod: l4_wkup: resetting
[    0.875732] omap_hwmod: l4_wkup: idling
[    0.879791] omap_hwmod: l4_wkup: disabling clocks
[    0.884765] omap_hwmod: mmc3: enabling
[    0.888702] omap_hwmod: mmc3: enabling clocks
[    0.893341] omap_hwmod: mmc3: resetting
[    0.897430] omap_hwmod: mmc3: resetting via OCP SOFTRESET
[    0.903106] omap_hwmod: mmc3: softreset in 0 usec
[    0.908050] omap_hwmod: mmc3: idling
[    0.911834] omap_hwmod: mmc3: disabling clocks

At this point my serial console (UART3, 19200bps) start emitting nuls rathe=
r than what
it should, so I don't see the next few lines.
154 nuls instread of 91 characters.


[    0.916534] omap_hwmod: hdq: enabling
[    0.944793] omap_hwmod: hdq: enabling clocks

Then normal text resumes for a short while:

[    0.977691] omap_hwmod: hdq: resetting
[    0.981658] omap_hwmod: hdq: resetting via OCP SOFTRESET
[    0.998413] omap_hwmod: hdq: softreset failed (waited 10000 usec)
[    1.004791] omap_hwmod: hdq: idling
[    1.008483] omap_hwmod: hdq: disabling clocks

Here again we switch to all nuls.
7959 nuls instead of 4701 characters.

[    1.013092] omap_hwmod: timer1: enabling
[    1.043334] omap_hwmod: timer1: enabling clocks
[    1.078155] omap_hwmod: timer1: resetting
[    1.109008] omap_hwmod: timer1: resetting via OCP SOFTRESET
[    1.151702] omap_hwmod: timer1: softreset in 0 usec
[    1.189147] omap_hwmod: timer1: idling
[    1.218048] omap_hwmod: timer1: disabling clocks
[    1.253540] omap_hwmod: timer2: enabling
[    1.283752] omap_hwmod: timer2: enabling clocks
[    1.318572] omap_hwmod: timer2: resetting
[    1.349456] omap_hwmod: timer2: resetting via OCP SOFTRESET
[    1.392150] omap_hwmod: timer2: softreset in 0 usec
[    1.429565] omap_hwmod: timer2: idling
[    1.458496] omap_hwmod: timer2: disabling clocks
[    1.493957] omap_hwmod: timer3: enabling
[    1.524169] omap_hwmod: timer3: enabling clocks
[    1.558990] omap_hwmod: timer3: resetting
[    1.589874] omap_hwmod: timer3: resetting via OCP SOFTRESET
[    1.632568] omap_hwmod: timer3: softreset in 0 usec
[    1.669982] omap_hwmod: timer3: idling
[    1.698913] omap_hwmod: timer3: disabling clocks
[    1.734374] omap_hwmod: timer4: enabling
[    1.764617] omap_hwmod: timer4: enabling clocks
[    1.799438] omap_hwmod: timer4: resetting
[    1.830291] omap_hwmod: timer4: resetting via OCP SOFTRESET
[    1.872985] omap_hwmod: timer4: softreset in 0 usec
[    1.910430] omap_hwmod: timer4: idling
[    1.939331] omap_hwmod: timer4: disabling clocks
[    1.974822] omap_hwmod: timer5: enabling
[    2.005035] omap_hwmod: timer5: enabling clocks
[    2.039855] omap_hwmod: timer5: resetting
[    2.070739] omap_hwmod: timer5: resetting via OCP SOFTRESET
[    2.113403] omap_hwmod: timer5: softreset in 0 usec
[    2.150848] omap_hwmod: timer5: idling
[    2.179748] omap_hwmod: timer5: disabling clocks
[    2.215270] omap_hwmod: timer6: enabling
[    2.245483] omap_hwmod: timer6: enabling clocks
[    2.280303] omap_hwmod: timer6: resetting
[    2.311157] omap_hwmod: timer6: resetting via OCP SOFTRESET
[    2.353851] omap_hwmod: timer6: softreset in 0 usec
[    2.391296] omap_hwmod: timer6: idling
[    2.420196] omap_hwmod: timer6: disabling clocks
[    2.455688] omap_hwmod: timer7: enabling
[    2.485900] omap_hwmod: timer7: enabling clocks
[    2.520721] omap_hwmod: timer7: resetting
[    2.551605] omap_hwmod: timer7: resetting via OCP SOFTRESET
[    2.594268] omap_hwmod: timer7: softreset in 0 usec
[    2.631713] omap_hwmod: timer7: idling
[    2.660614] omap_hwmod: timer7: disabling clocks
[    2.696105] omap_hwmod: timer8: enabling
[    2.726318] omap_hwmod: timer8: enabling clocks
[    2.761138] omap_hwmod: timer8: resetting
[    2.792022] omap_hwmod: timer8: resetting via OCP SOFTRESET
[    2.834716] omap_hwmod: timer8: softreset in 0 usec
[    2.872131] omap_hwmod: timer8: idling
[    2.901062] omap_hwmod: timer8: disabling clocks
[    2.936523] omap_hwmod: timer9: enabling
[    2.966735] omap_hwmod: timer9: enabling clocks
[    3.001556] omap_hwmod: timer9: resetting
[    3.032440] omap_hwmod: timer9: resetting via OCP SOFTRESET
[    3.075134] omap_hwmod: timer9: softreset in 0 usec
[    3.112579] omap_hwmod: timer9: idling
[    3.141510] omap_hwmod: timer9: disabling clocks
[    3.176971] omap_hwmod: timer10: enabling
[    3.207855] omap_hwmod: timer10: enabling clocks
[    3.243316] omap_hwmod: timer10: resetting
[    3.274871] omap_hwmod: timer10: resetting via OCP SOFTRESET
[    3.318206] omap_hwmod: timer10: softreset in 0 usec
[    3.356292] omap_hwmod: timer10: idling
[    3.385864] omap_hwmod: timer10: disabling clocks
[    3.421997] omap_hwmod: timer11: enabling
[    3.452880] omap_hwmod: timer11: enabling clocks
[    3.488342] omap_hwmod: timer11: resetting
[    3.519866] omap_hwmod: timer11: resetting via OCP SOFTRESET
[    3.563232] omap_hwmod: timer11: softreset in 0 usec
[    3.601318] omap_hwmod: timer11: idling
[    3.630889] omap_hwmod: timer11: disabling clocks
[    3.667022] omap_hwmod: wd_timer2: enabling
[    3.699188] omap_hwmod: wd_timer2: enabling clocks
[    3.735992] omap_hwmod: wd_timer2: resetting
[    3.768829] omap_hwmod: wd_timer2: resetting via OCP SOFTRESET
[    3.813629] omap_hwmod: wd_timer2: softreset in 62 usec
[    3.853698] omap_hwmod: wd_timer2: disabling
[    3.886779] omap_hwmod: wd_timer2: disabling clocks
[    3.924224] omap_hwmod: uart1: enabling
[    3.953796] omap_hwmod: uart1: enabling clocks

Here the serial port starts working again and I get the right text.

[    3.988006] omap_hwmod: uart2: enabling
[    3.992065] omap_hwmod: uart2: enabling clocks
[    3.996765] omap_hwmod: uart3: enabling
[    4.000793] omap_hwmod: uart3: enabling clocks
[    4.005523] omap_hwmod: dss_dispc: enabling
[    4.009948] omap_hwmod: dss_dispc: enabling clocks
[    4.014984] omap_hwmod: dss_dispc: resetting
[    4.019500] omap_hwmod: dss_dispc: resetting via OCP SOFTRESET
[    4.025634] omap_hwmod: dss_dispc: softreset in 0 usec
[    4.031005] omap_hwmod: dss_dispc: idling
[    4.035247] omap_hwmod: dss_dispc: disabling clocks


This is quite repeatable.
It seems to me that there might be something odd going on with clocks.
Maybe there is some dependency that isn't encoded properly or something?

The fact that UART3 has problems while the HDQ is originally being reset is
certainly very strange.

The other thing I discovered is that when I set the uart 'sleep_timeout' to=
 5
(all uarts) so that CPUIDLE can let CORE enter the lower power states, I get
a fairly steady stream of:

[ 1168.490478] omap_hwmod: uart1: enabling
[ 1168.490509] omap_hwmod: uart1: enabling clocks
[ 1168.490539] omap_hwmod: uart2: enabling
[ 1168.490539] omap_hwmod: uart2: enabling clocks
[ 1168.490631] omap_hwmod: uart3: enabling
[ 1168.490661] omap_hwmod: uart3: enabling clocks
[ 1168.490661] omap_hwmod: uart4: enabling
[ 1168.490692] omap_hwmod: uart4: enabling clocks
[ 1168.578796] omap_hwmod: uart3: idling
[ 1168.578796] omap_hwmod: uart3: disabling clocks
[ 1168.578826] omap_hwmod: uart4: idling
[ 1168.578826] omap_hwmod: uart4: disabling clocks
[ 1168.578857] omap_hwmod: uart1: idling
[ 1168.578857] omap_hwmod: uart1: disabling clocks
[ 1168.578887] omap_hwmod: uart2: idling
[ 1168.578887] omap_hwmod: uart2: disabling clocks
[ 1168.714263] omap_hwmod: uart1: enabling
[ 1168.714294] omap_hwmod: uart1: enabling clocks
[ 1168.714324] omap_hwmod: uart2: enabling
[ 1168.714324] omap_hwmod: uart2: enabling clocks
[ 1168.714416] omap_hwmod: uart3: enabling
[ 1168.714447] omap_hwmod: uart3: enabling clocks
[ 1168.714447] omap_hwmod: uart4: enabling
[ 1168.714477] omap_hwmod: uart4: enabling clocks
[ 1168.803344] omap_hwmod: uart3: idling
[ 1168.803344] omap_hwmod: uart3: disabling clocks
[ 1168.803375] omap_hwmod: uart4: idling
[ 1168.803375] omap_hwmod: uart4: disabling clocks
[ 1168.851257] omap_hwmod: uart3: enabling
[ 1168.851287] omap_hwmod: uart3: enabling clocks
[ 1168.851318] omap_hwmod: uart4: enabling
[ 1168.851318] omap_hwmod: uart4: enabling clocks
[ 1168.885955] omap_hwmod: uart3: idling
[ 1168.885986] omap_hwmod: uart3: disabling clocks
[ 1168.885986] omap_hwmod: uart4: idling
[ 1168.886016] omap_hwmod: uart4: disabling clocks
[ 1168.886383] omap_hwmod: uart3: enabling
[ 1168.886383] omap_hwmod: uart3: enabling clocks
[ 1168.886383] omap_hwmod: uart4: enabling
[ 1168.886413] omap_hwmod: uart4: enabling clocks
[ 1168.944885] omap_hwmod: uart3: idling
[ 1168.944915] omap_hwmod: uart3: disabling clocks


It seems to mostly be uart3 and uart4.
If there is any interaction between the uart clock and the hdq clock, this
could explain why the HDQ gets confused when all this is happening.

And if there is a connection there, then there could also be a connection
with a DSS clock which could be confusing it.

I admit this is largely surmise and hypothesis - but there is definitely
something odd here!

Thanks,
NeilBrown

--Sig_/iKbQBgg2iDdA126=Sjz.s/K
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxiFhDnsnt1WYoG5AQIfoBAArYgQmxhSCNV9z4IktxDsiQtwoYdxikcO
djGyLKRFKOdhUXdylYnAobBiFfncmrQ7gjwxC/+MKBRaaB1icCwBpg3x71iMs2so
oOgIAtrkypTfyY9AsoGYVyY96HCdo+3iQeki1Z1Br02yBg5gwletaSk7nf6M+kDB
xaP0zBNBnk8C932EdkZFda0XFLTXC0wMYohhbdVIgUgCMcPtYy8W4ikE+Nzwrz3T
OdzC5Hyrq1d7GPchoDZzEkwk2zN+AFWc0u3Rhwx4zBcsw15f8ZVLoig/5eblTXSr
r0+agqd80McsSicMS0fatPmL6E8LEq3F/8MQ/9bqEDIf3fjbt8aYspsGE5uVMCuL
exDN/Qe1l+ECeiSLw4/rcI2Dda9oErT6iH5qVhLX4IBCBLzWL06mUMzI1JL9qERc
DlL79aD9xw599Ub92ajpQ0GlZxxfYsIV64Yo9SC+fbUXkrcg3/eZAbF5WnunVlWb
kfsiDQUepRJcmJJA1t1qSCUs+PJA48/F/FaMBvptj43ZeEguJKfb1X96ub8oQfeQ
ol0oor5ooUT/tHs+/WSqAQVLakGkAaYa7cywQLor8bT3NC/yy9pz3bZ9NEYh6QVM
xikkpbsete2kE7qYx3IY46bkzBswUNze73t1ABGKAvXq/lZsIcMQvzHzhg1XHKFZ
HfSACeGp6hc=
=D1tq
-----END PGP SIGNATURE-----

--Sig_/iKbQBgg2iDdA126=Sjz.s/K--
