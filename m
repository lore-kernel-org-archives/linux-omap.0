From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Wed, 16 Jan 2013 15:28:20 +0100
Message-ID: <50F6B904.5000600@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com> <50E40336.2080008@parrot.com> <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:38332 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3APO2u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 09:28:50 -0500
In-Reply-To: <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Paul Walmsley a =E9crit :
> Hi
>=20
> On Wed, 2 Jan 2013, Matthieu CASTET wrote:

> .... which did not get merged because Tony requested that it should b=
e=20
> based on top of his cleanup work (which takes priority over adding ne=
w=20
> features):
>=20
> http://thread.gmane.org/gmane.linux.ports.arm.omap/88550/focus=3D8854=
9
>=20
> Could you please update this "omap3 nand : use NAND_BUSWIDTH_AUTO" pa=
tch=20
> on v3.8-rc2 and repost?

Do you know when this patchset will be submited to mtd ?
I think I will wait it is merged in mtd and redo my patch after that.

>=20
>> For drivers that can't support ONFI, I don't know what to do.
>> May we should be replace the WARN_ON by a printk and early return.
>=20
> That sounds like a good idea to me.  The traceback seems excessive, s=
ince=20
> the NAND was usable before this series.
>=20
I submited a patch for doing that.

Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
