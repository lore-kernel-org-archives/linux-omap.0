From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Tue, 10 Jan 2012 08:08:49 +1100
Message-ID: <20120110080849.5a242adf@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/kVO2naB2uB_yv/wK3XzXjc/"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54791 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab2AIVJG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 16:09:06 -0500
In-Reply-To: <WC20120109124643.880164@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org

--Sig_/kVO2naB2uB_yv/wK3XzXjc/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Jan 2012 12:46:43 +0000 "Joe Woodward" <jw@terrafix.co.uk> wrote:

> I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connec=
ted via the DPI interface (using the generic panel driver).
>=20
> Entering standby used to work just fine on 3.0, but on 3.2 I get the foll=
owing:
>=20
> # echo mem > /sys/power/state
> [   23.186279] PM: Syncing filesystems ... done.
> [   23.194244] Freezing user space processes ... (elapsed 0.01 seconds) d=
one.
> [   23.219543] Freezing remaining freezable tasks ... (elapsed 0.02 secon=
ds) done.
> [   23.251037] Suspending console(s) (use no_console_suspend to debug)
> [   23.554656] PM: suspend of devices complete after 296.417 msecs
> [   23.561859] PM: late suspend of devices complete after 6.957 msecs
> [   24.464813] Successfully put all powerdomains to target state
> [   24.466674] ------------[ cut here ]------------
> [   24.466857] WARNING: at drivers/video/omap2/dss/dss.c:713 0xc01350f8()
> [   24.467010] Modules linked in:
> [   24.467132] Backtrace:
> [   24.467254] Function entered at [<c0010c3c>] from [<c02c4a60>]
> [   24.467407]  r6:c02ffdaa r5:000002c9 r4:00000000 r3:00000000
> [   24.467651] Function entered at [<c02c4a48>] from [<c00344d0>]
> [   24.467803] Function entered at [<c003447c>] from [<c003450c>]
> [   24.467926]  r8:00000000 r7:c0390a84 r6:c00288a4 r5:c037b85c r4:ffffff=
f3
> [   24.468200] r3:00000009
> [   24.468322] Function entered at [<c00344e8>] from [<c01350f8>]
> [   24.468475] Function entered at [<c01350ac>] from [<c013595c>]
> [   24.468597]  r4:dec50208 r3:c013594c
> [   24.468780] Function entered at [<c013594c>] from [<c0182724>]
> [   24.468902]  r6:c00288a4 r5:c037b85c r4:dec50208 r3:c013594c
> [   24.469177] Function entered at [<c01826f0>] from [<c0028900>]
> [   24.469299] Function entered at [<c00288a4>] from [<c01836f4>]
> [   24.469421]  r4:dec50208 r3:00000000
> [   24.469604] Function entered at [<c0183614>] from [<c0183d20>]
> [   24.469726]  r9:c02d7044 r8:00000000 r6:dec5025c r5:00000010 r4:dec502=
08
> [   24.470031] Function entered at [<c0183c54>] from [<c0063aa4>]
> [   24.470153]  r8:c02ca888 r7:00000000 r6:00000003 r5:00000000 r4:000000=
00
> [   24.470458] Function entered at [<c006391c>] from [<c0063c60>]
> [   24.470581]  r7:00000004 r6:00000000 r5:c02ca87c r4:00000003
> [   24.471130] Function entered at [<c0063b50>] from [<c0062ad4>]
> [   24.471282]  r6:00000003 r5:00000003 r4:c6a87000 r3:0000006d
> [   24.471557] Function entered at [<c0062a2c>] from [<c0117728>]
> [   24.471679] Function entered at [<c011770c>] from [<c00e2ab0>]
> [   24.471832] Function entered at [<c00e29a0>] from [<c0098c98>]
> [   24.471954] Function entered at [<c0098be4>] from [<c0098f14>]
> [   24.472076]  r8:00000004 r7:00000000 r6:00000000 r5:000ac750 r4:d8a70d=
c0
> [   24.472412] Function entered at [<c0098ed0>] from [<c000dcc0>]
> [   24.472534]  r8:c000de44 r7:00000004 r6:000ac750 r5:00000004 r4:000a8e=
38
> [   24.472839] ---[ end trace 9f4f3053f6637dae ]---
> [   24.475006] PM: early resume of devices complete after 8.666 msecs
> [   25.040344] PM: resume of devices complete after 560.943 msecs
> [   25.277801] Restarting tasks ... done.
>=20
> At which point the screen either restarts, or sometimes flickers and I ge=
t the following:
> [   22.578796] omapdss DISPC error: SYNC_LOST on channel lcd, restarting =
the output with video overlays disabled
> [   23.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting =
the output with video overlays disabled
> [   24.391571] omapdss DISPC error: SYNC_LOST on channel lcd, restarting =
the output with video overlays disabled
>=20
> It normally recovers after doing this for a while...
>=20
> Anyone have any ideas?

I think I can help you work around the problem but I would much rather see =
it
fixed.  So the main reason I'm replying is to make this thread seem more
interesting so that more people look at it and hopefully the "right" person
sees it :-)

It seems that when cpuidle on an omap3 tries to switch to lower power
states, various things misbehave:
 - UARTs lose characters
 - dss loses sync
 - HDQ seems to lose everything.

The first is known in the code so cpuidle is disabled if there is any UART
traffic.  At first boot it is assume thered might be uart activity and the
timeout for "there doesn't seem to be any activity" is '0' meaning 'don't
time out' (look for sleep_timeout in sysfs).

On suspend, the UARTs are allowed to go to sleep and they are not explicitly
woken at resume.  So after a suspend/resume cycle, cpuidle is more likely to
try to adjust idle states and so DSS and HDQ are more likely to fail.

You can disable cpuidle by writing '0' to all the 'sleep_timeout' fields, or
probably by
   echo 1 >  /sys/module/cpuidle/parameters/off

That should stablise the display.

It would be great if you could check if cpuidle was active in 3.0 when this
all worked.  I would check by:

  grep . /sys/devices/system/cpu/cpu?/cpuidle/state?/usage

and see if any state other than state0 is used.

If cpuidle is changing power states but the display is happy, then it would
be fantastic if you could 'git bisect' to find out when it broke, but that
would be a lot of work with uncertain gain so I wouldn't be at all surprised
if you declined.

NeilBrown

--Sig_/kVO2naB2uB_yv/wK3XzXjc/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTwtXYTnsnt1WYoG5AQLLEBAAgrdbRF/TAxoeYeXz3JpSSogkbp3RAvU7
TPiTX3d43LBSlxioJ34dW9uusnppvjCkV2dAaY52Hs4xrwJOn9P35txFgqPgmecN
ul5N/XemiR+8n54cQCEyGsnsQSR7VJMkL3Sxc0gH6xxiS3BIbcCyDou+XqOdkCrX
9NNv0w54Z2+jIkg0/+RyOsVNewhraMF+kKnTu5qCetZziB7SQTJKPubOUasTmoPK
oInmSjV+7MzN5Kk1S1CWQWcEara5OZh0l4fFDaQcI4W8MCMzlZ/aixEdx/rUqRmB
xYJ1uSptIyIq+/bgk8o84qmVqe94L9c0/8LR1LeQKcveATDJyf0mjwJqhoM77xwN
94RdXEqbl7uCAm7xT1Q+tfQya/BX1Oj3Iuv7nAnJ7xH0eok234oKswhXNbOHii5c
IeAidG2LZpa3p3Ys7s6mhMktKU7dq54qOvBKXjI/J6wmNtU6bVFLvhEXwnsFXkHn
H4XFHnCa2tNFI5YMDIm7RmfYwfMGATwA5ZDrwVBhkgN3nD5gYw79e5vd+UUOltWe
RNb0BmxJ07BLhzsD3jJjSJ+fiBPdhhaWsDfTvXo1aecfkuj7FCN2kRHqBl+vUrnh
xS8Q+jTKODful9/h+mqnE3blr7ZF6AZfxMHyjeS1rweByneSU6gzhTnmS8+PTH04
ZQdQw7PAGcI=
=LjBR
-----END PGP SIGNATURE-----

--Sig_/kVO2naB2uB_yv/wK3XzXjc/--
