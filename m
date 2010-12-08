From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
 files
Date: Tue, 7 Dec 2010 23:47:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012072340250.13430@utopia.booyaka.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain> <20101207012514.3708.87532.stgit@twilight.localdomain> <4CFDEBB7.8040309@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1643858675-1291790692=:13430"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0LHGr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:47:29 -0500
In-Reply-To: <4CFDEBB7.8040309@ti.com>
Content-ID: <alpine.DEB.2.00.1012072345200.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1643858675-1291790692=:13430
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1012072345201.13430@utopia.booyaka.com>

Salut Beno=EEt,=20

On Tue, 7 Dec 2010, Cousson, Benoit wrote:

> Salut Paul,
>=20
> On 12/7/2010 2:25 AM, Paul Walmsley wrote:
> > Split the existing cm44xx.h file into cm1_44xx.h and cm2_44xx.h files
> > so they match their underlying OMAP hardware modules.  Add clockdomain
> > offset information.
> >=20
> > Add header files for the MPU local PRCM, prcm_mpu44xx.h, and for the
> > SCRM, scrm44xx.h.  SCRM register offsets still need to be added; TI
> > should do this.
>=20
> And we did it :-)

Even better :-)

> I sent it last week along with clock data series:
> https://patchwork.kernel.org/patch/373751/
>=20
> OK, I've just realized that it was a little bit hidden in the clock data
> patch, and maybe we should have been sent two patches.
> Sorry for that. Do you want to take it in that series, or should I re-sen=
t the
> clock data one?

I guess it's better done in the clock series; that should avoid a branch
dependency between the PRCM patchsets and the clock patch sets.

One thing that would be nice on the scrm44xx.h file is to keep the _OFFSET=
=20
macros.  It would be nice in the long run to get rid of the absolute=20
addressing macros in case someone decides to shuffle around the IP block=20
addresses again... can you update your clock series with that change? =20
Getting the clock patchsets put together for 2.6.38 is one of the next=20
big projects here.


- Paul
--155748971-1643858675-1291790692=:13430--
