From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
 disabled
Date: Thu, 25 Nov 2010 11:15:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011251103480.20215@utopia.booyaka.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com> <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-747078943-1290708548=:20215"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60399 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab0KYSPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 13:15:25 -0500
In-Reply-To: <AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1011251114530.20215@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tom.leiming@gmail.com, pramod.gurav@ti.com, thomas.petazzoni@free-electrons.com, govindraj.raja@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-747078943-1290708548=:20215
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1011251114531.20215@utopia.booyaka.com>

Hi

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

By the way, I just tried this on a Beagle 35xx rev C2, with Tony's commit=
=20
063d907edaf3fbf9776c189c3e02f2c7a129d18c, and did not see any hang.   Are=
=20
you using a linux-omap kernel?


- Paul
--155748971-747078943-1290708548=:20215--
