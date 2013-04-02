From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Tue, 2 Apr 2013 18:28:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304021826310.27146@utopia.booyaka.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com> <50E40336.2080008@parrot.com> <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com>
 <50F6B904.5000600@parrot.com> <alpine.DEB.2.00.1301161713380.32170@utopia.booyaka.com> <alpine.DEB.2.00.1301220226530.25789@utopia.booyaka.com> <alpine.DEB.2.00.1302062321080.12769@utopia.booyaka.com> <5113783B.6010806@parrot.com>
 <5130B4E9.5050700@parrot.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-2069735505-1364927246=:27146"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49639 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760612Ab3DBS2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 14:28:13 -0400
In-Reply-To: <5130B4E9.5050700@parrot.com>
Content-ID: <alpine.DEB.2.00.1304021827340.27146@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, jon-hunter@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-2069735505-1364927246=:27146
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1304021827341.27146@utopia.booyaka.com>

Hi Matthieu,

On Fri, 1 Mar 2013, Matthieu CASTET wrote:

> Matthieu CASTET a =E9crit :
> > Paul Walmsley a =E9crit :
> >> On Tue, 22 Jan 2013, Paul Walmsley wrote:
> >>
> >>> Any progress on updating and resending your "omap3 nand : use=20
> >>> NAND_BUSWIDTH_AUTO" patch?  We're in danger of missing the 3.9 merge=
=20
> >>> window if it takes too much longer.
> >> Could you let us know if you're planning to update and repost this one=
?
> >>
> > Sorry for the delay I attached an updated version of the patch.
> >=20
> > I was not able to test it : with mtd tree and my configuration I have t=
o apply
> > https://patchwork.kernel.org/patch/1810441/
> > https://patchwork.kernel.org/patch/1884341/
> > http://comments.gmane.org/gmane.linux.ports.arm.omap/91096
> >=20
> > in order the kernel build.
> >=20
> > And after that the kernel doesn't seem to boot on my beagle board. Coul=
d you
> > test the patch ?
> >=20
> > I have also a problem : how should I change nand bus size. It is done b=
y
> > "gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_DEV_SIZE, ...);", but now=
 gpmc.h
> > header is not public anymore.
> >=20
> > I have to do a '#include "../gpmc.h"'.
> >=20
> >=20
> Any news on this ?

Unfortunately, I don't have the time at the moment to track this issue. =20
Could you follow up on this with Jon Hunter <jon-hunter@ti.com> ?  He's=20
been working on the GPMC code for the last few merge windows and is=20
basically the maintainer of it at this point.


- Paul
--843723315-2069735505-1364927246=:27146--
