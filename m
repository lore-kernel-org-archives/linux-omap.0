From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: Buildfailure for omap3_defconfig due to patch OMAP: RX51: Add
 LCD Panel support
Date: Thu, 13 May 2010 10:35:02 +0300
Message-ID: <4BEBABA6.6040907@nokia.com>
References: <201005122331.51347.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38933 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0EMHsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 03:48:36 -0400
In-Reply-To: <201005122331.51347.PeterHuewe@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?ext_Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "jpihet@mvista.com" <jpihet@mvista.com>, "kalle.valo@iki.fi" <kalle.valo@iki.fi>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Peter,

ext Peter H=FCwe wrote:
> Hi Roger,
>=20
> I just wanted to inform you that your Patch
> OMAP: RX51: Add LCD Panel support (b499d77834ae292465f8d06bb0a88f1a64=
7dfa1a)=20
> introduces a build failure for the omap3_defconfig.
>=20
> You can see the error message here:
> http://kisskb.ellerman.id.au/kisskb/buildresult/2601981/
>=20
> This is due to the fact that omap3_defconfig has
> CONFIG_MACH_NOKIA_RX51=3Dy
> set which enables the compilation of arch/arm/mach-omap2/board-rx51.c
>=20
> board-rx51.c calls rx51_video_mem_init in arch/arm/mach-omap2/board-r=
x51-
> video.c which is guarded by=20
> #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
>=20
> Unfortunately none if them is set in the omap3_defconfig.
>=20
> Would be nice if you could fix this :)
>=20
Thanks for pointing this out. Kevin Hilman had already informed me of t=
his earlier.

The patch with the fix is here
https://patchwork.kernel.org/patch/98092/

Tomi has picked up the fixed patch in his tree in the for-next branch
http://gitorious.org/linux-omap-dss2/linux/commit/9585a7e56c51d224830ad=
b29b1843310a87cd034

regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
