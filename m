From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Wed, 16 Jan 2013 17:15:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301161713380.32170@utopia.booyaka.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com> <50E40336.2080008@parrot.com> <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com>
 <50F6B904.5000600@parrot.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1778857457-1358356505=:32170"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:32891 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab3APRPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jan 2013 12:15:21 -0500
In-Reply-To: <50F6B904.5000600@parrot.com>
Content-ID: <alpine.DEB.2.00.1301161715140.32170@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1778857457-1358356505=:32170
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1301161715141.32170@utopia.booyaka.com>

Hi Matthieu,

On Wed, 16 Jan 2013, Matthieu CASTET wrote:

> Paul Walmsley a =E9crit :
> > On Wed, 2 Jan 2013, Matthieu CASTET wrote:
>=20
> > .... which did not get merged because Tony requested that it should be=
=20
> > based on top of his cleanup work (which takes priority over adding new=
=20
> > features):
> >=20
> > http://thread.gmane.org/gmane.linux.ports.arm.omap/88550/focus=3D88549
> >=20
> > Could you please update this "omap3 nand : use NAND_BUSWIDTH_AUTO" patc=
h=20
> > on v3.8-rc2 and repost?
>=20
> Do you know when this patchset will be submited to mtd ?
> I think I will wait it is merged in mtd and redo my patch after that.

As far as I know, it was merged during the v3.8 merge window.  So it's=20
already in mainline. =20

> >> For drivers that can't support ONFI, I don't know what to do.
> >> May we should be replace the WARN_ON by a printk and early return.
> >=20
> > That sounds like a good idea to me.  The traceback seems excessive, sin=
ce=20
> > the NAND was usable before this series.
> >=20
> I submited a patch for doing that.

Thanks for doing this, it's much appreciated!


- Paul
--843723315-1778857457-1358356505=:32170--
