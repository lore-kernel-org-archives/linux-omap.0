From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: linux-next: origin tree build failure
Date: Tue, 15 Dec 2009 15:01:27 +0200
Message-ID: <200912151501.27582.peter.ujfalusi@nokia.com>
References: <20091215164108.45c9d766.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53111 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbZLONBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:01:43 -0500
In-Reply-To: <20091215164108.45c9d766.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Tuesday 15 December 2009 07:41:08 ext Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next build (powerpc allyesconfig) failed like this:
>=20
> drivers/mfd/twl4030-codec.c:29:31: error: linux/i2c/twl4030.h: No suc=
h file
>  or directory
>=20
> (there were more, but I assume that they all stem form this one).
>=20
> Caused by commit 0b83ddebc6e884dc0221358cf68c461520fbdd8e ("MFD: twl4=
030:
> add twl4030_codec MFD as a new child to the core") from Linus' tree
> interacting with commit b07682b6056eb6701f8cb86aa5800e6f2ea7919b ("mf=
d:
> Rename twl4030* driver files to enable re-use") also from Linus' tree=
=2E
> This file seems to have been missed in the renaming.

Yes, the twl4030-codec MFD driver went in earlier than the twl4030 rena=
me patch,=20
which does not taken care of the twl4030-codec MFD driver for some reas=
ons.

The patch looks good, I might also align the twl4030-codec MFD driver w=
ith the=20
renamed twl core soon.
I have to check the feasibility of this first, since the renaming was d=
one to=20
facilitate the addition of twl6030 (OMAP4 companion chip), and I don't =
have yet=20
access to the documentation.

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
