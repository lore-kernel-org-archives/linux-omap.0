From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Wed, 10 Aug 2011 00:08:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108092351390.12674@utopia.booyaka.com>
References: <4E40FC88.5090403@ti.com> <20110809162907.GA630@manju-WNB7PBC4801-0006> <4E4166F0.9050401@ti.com> <CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com> <20110810012958.GB23511@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-684816137-1312956508=:12674"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44348 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab1HJGI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 02:08:29 -0400
In-Reply-To: <20110810012958.GB23511@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Grant Likely <grant.likely@secretlab.ca>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-684816137-1312956508=:12674
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Aug 2011, David Gibson wrote:

> The difficulty with adding th enames to the DT itself is that it
> exposes the essentially Linux-specific names in what's supposed to be
> an OS neutral data structure.

The names are supposed to pertain to the hardware IP block, not the OS. =20
See for example [1] and [2]. =20

If there's something OS-specific about the names, then the data isn't=20
right.


- Paul

1. http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Db=
lob;f=3Darch/arm/mach-omap2/omap_hwmod_44xx_data.c;h=3D6201422c0606b5103c01=
e563f67060134658774d;hb=3D322a8b034003c0d46d39af85bf24fee27b902f48#l2359

2. Table 23-13 "HS I=B2C DMA Requests", OMAP4430 TRM version V=20
   (SWPU231V), available from=20
   http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_PUBLIC_TRM_vV.zip=20
--155748971-684816137-1312956508=:12674--
