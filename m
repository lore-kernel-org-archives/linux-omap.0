From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
 disabled
Date: Thu, 25 Nov 2010 10:35:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com> <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-253803172-1290705808=:20215"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34593 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0KYRfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 12:35:18 -0500
In-Reply-To: <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1011251024100.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-253803172-1290705808=:20215
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1011251024101.20215@utopia.booyaka.com>

Hello Jean

On Thu, 25 Nov 2010, Jean Pihet wrote:

> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > The console semaphore must be held while the OMAP UART devices are
> > disabled, lest a console write cause an ARM abort (and a kernel crash)
> > when the underlying console device is inaccessible. =A0These crashes
> > only occur when the console is on one of the OMAP internal serial
> > ports.
> This does not fix the issue for me on Beagle (console on ttyO2).
>=20
> Doing:
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
> and waiting 5 seconds hangs the console.

If this is without sleep_while_idle enabled, then you're seeing an=20
unrelated bug that is not related to this patch.  That's because, when=20
/debug/pm_debug/sleep_while_idle is 0, the pm34xx.c code that this patch=20
touches won't be reached.

By the way, you write that the above situation "hangs the console."  Is it=
=20
just the case that the console dies and the rest of the system is still=20
alive, or does the whole system crash?

> However enabling sleep_while_idle before configuring the UART2 timeout
> makes it work ok:
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
>   / # echo 1 > /debug/pm_debug/sleep_while_idle
>   / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
>=20
> This result is similar to what I tested on a recent l-o master w/o the fi=
x.
> Am I missing something?

It may depend on your loglevel settings.  If warning messages aren't=20
emitted to the console, then you won't see this crash.

Whether the system crashes also depends on whether you happen to get a new=
=20
worst-case deactivation latency from your console serial port during PM=20
idle.  If not, and there are no other console writes after the UART is=20
disabled, then this patch won't affect anything.

Just FYI, without this patch, Tony's N810 crashed reliably upon entering=20
dynamic idle.=20

> One more remark. With OFF mode enabled I noticed that PER can go OFF
> without CORE going OFF, which could trigger the errata i582. I think
> this is another latent problem.

This appears to be unrelated to the patch under discussion.  Maybe you=20
should start a separate list thread on this issue?  We do not appear to=20
have the suggested workaround sequence in the TRM in the current code. =20
This workaround is quite complex.  Someone from TI should definitely put=20
together some patches to implement it.


- Paul
--155748971-253803172-1290705808=:20215--
