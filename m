From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Fri, 1 Mar 2013 15:02:17 +0100
Message-ID: <5130B4E9.5050700@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com> <1354530053.30168.183.camel@sauron.fi.intel.com> <alpine.DEB.2.00.1212240023100.17282@utopia.booyaka.com> <50E40336.2080008@parrot.com> <alpine.DEB.2.00.1301031704460.8721@utopia.booyaka.com> <50F6B904.5000600@parrot.com> <alpine.DEB.2.00.1301161713380.32170@utopia.booyaka.com> <alpine.DEB.2.00.1301220226530.25789@utopia.booyaka.com> <alpine.DEB.2.00.1302062321080.12769@utopia.booyaka.com> <5113783B.6010806@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:51224 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab3CAOCV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 09:02:21 -0500
In-Reply-To: <5113783B.6010806@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Matthieu CASTET a =E9crit :
> Hi Paul,
>=20
> Paul Walmsley a =E9crit :
>> Hi Matthieu,
>>
>> On Tue, 22 Jan 2013, Paul Walmsley wrote:
>>
>>> Any progress on updating and resending your "omap3 nand : use=20
>>> NAND_BUSWIDTH_AUTO" patch?  We're in danger of missing the 3.9 merg=
e=20
>>> window if it takes too much longer.
>> Could you let us know if you're planning to update and repost this o=
ne?
>>
> Sorry for the delay I attached an updated version of the patch.
>=20
> I was not able to test it : with mtd tree and my configuration I have=
 to apply
> https://patchwork.kernel.org/patch/1810441/
> https://patchwork.kernel.org/patch/1884341/
> http://comments.gmane.org/gmane.linux.ports.arm.omap/91096
>=20
> in order the kernel build.
>=20
> And after that the kernel doesn't seem to boot on my beagle board. Co=
uld you
> test the patch ?
>=20
>=20
> I have also a problem : how should I change nand bus size. It is done=
 by
> "gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_DEV_SIZE, ...);", but n=
ow gpmc.h
> header is not public anymore.
>=20
> I have to do a '#include "../gpmc.h"'.
>=20
>=20
Any news on this ?


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
