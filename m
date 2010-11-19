From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/8] OMAP2+: hwmod: rename omap_hwmod_mutex to
 _hwmod_list_mutex
Date: Thu, 18 Nov 2010 22:29:20 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011182225480.7544@utopia.booyaka.com>
References: <20101116101615.22777.49212.stgit@twilight.localdomain> <20101116101808.22777.52852.stgit@twilight.localdomain> <4CE2C01D.8010703@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-586682693-1290144560=:7544"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60777 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0KSF3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 00:29:22 -0500
In-Reply-To: <4CE2C01D.8010703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-586682693-1290144560=:7544
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=C3=AEt,

On Tue, 16 Nov 2010, Cousson, Benoit wrote:

> Funny, I was about to send you a RFC to get rid of that mutex :-)
>=20
> Today that mutex is preventing us to be re-entrant during hwmod lookup an=
d
> for_each_by_class iteration, and we'd like to in order to manage link bet=
ween
> 2 hwmods.
>=20
> The context is the link between mcbsp and sidetone on OMAP3. Since this m=
odule
> are tightly coupled, I was suggesting to Kishon to add the sidetone refer=
ence
> directly in the mcbsp hwmod in order to create a omap_device that will ha=
ndle
> the 2 hwmods at the same time.
>=20
> Since we are using the iteration to get all the hwmod that belongs to the
> mcbsp class we cannot call the lookup function to get the sidetone hwmod =
at
> that time.
> For the moment we need to do 2 iteration and use intermediate storage to
> workaround that.
>=20
> After checking the purpose of the mutex, I was wondering if this is usefu=
l.
> For the moment the creation of the hwmod list is done only at init time, =
and
> nothing is supposed to change that at runtime except the unregister funct=
ion.
>=20
> So I've started to get rid of this function, then of the mutex and I adde=
d the
> __init to all these registration functions to avoid the usage at runtime.=
 It
> will save a little bit of memory as well.
>=20
> Thanks to that we can now use the omap_hwmod_lookup inside the
> omap_hwmod_for_each_by_class.
>=20
> Does that make sense to you?
> I can send you the patches if you want.

Yep, that sounds fine to me.  I'll plan to drop the mutex rename patch=20
once you send your patch to avoid the noise.  I guess that=20
omap_hwmod_register() can become static also, and can be renamed to=20
_register(), and we'll just use omap_hwmod_init() as the entry point to=20
register hwmods.


- Paul
--155748971-586682693-1290144560=:7544--
