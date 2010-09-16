From: Yanick Saugy <yanick.saugy@heig-vd.ch>
Subject: Re: LCD on Zoom2 dev board with DSS
Date: Thu, 16 Sep 2010 14:56:53 +0200
Message-ID: <1284641813.1798.589.camel@A05BPC17>
References: <1284381807.1801.38.camel@A05BPC17>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.infomaniak.ch ([84.16.68.89]:38228 "EHLO
	smtp1.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0IPM4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 08:56:51 -0400
Received: from [10.192.51.75] (pub1.heig-vd.ch [193.134.216.2])
	(authenticated bits=0)
	by smtp1.infomaniak.ch (8.14.2/8.14.2) with ESMTP id o8GCumUR032200
	for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 14:56:49 +0200
In-Reply-To: <1284381807.1801.38.camel@A05BPC17>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I solved my problem. It appeared the PIN which controls LCD's reset
signal (VGA_nRESET/h_GPIO_96) was not configured as a GPIO, and the
driver tries to use it as GPIO, so the logical value was 0. We had to
modify the OMAP MUX, and select this PIN (CAM_XCLKA) as an output GPIO
(OMAP_MUX_MODE4).

Be aware of changing this PIN will probably disable the camera, because
it was previously configured as a clock.

There is the patch for the LCD (diff -Naur):

--- a/arch/arm/mach-omap2/board-zoom2.c	2010-09-15 15:27:05.148399721
+0200
+++ b/arch/arm/mach-omap2/board-zoom2.c	2010-09-15 14:46:09.792900019
+0200
@@ -71,6 +71,7 @@
=20
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata =3D {
+	OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	{ .reg_offset =3D OMAP_MUX_TERMINATOR },
 };
 #else



Le lundi 13 septembre 2010 =C3=A0 14:43 +0200, Yanick Saugy a =C3=A9cri=
t :
> Hi all,=20
>=20
> I'm working on a zoom2 dev board (omap34x-II MDP). There is my actual=
 config :
>=20
> I've built kernel 2.6.35 from git://git.kernel.org/pub/scm/linux/kern=
el/git/tmlind/linux-omap-2.6.git
> and then applied the following patchs :
> [PATCH 1/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom=
 boards <http://marc.info/?l=3Dlinux-omap&m=3D127445506720934&w=3D2>
> [PATCH 2/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for zoom=
 boards <http://marc.info/?l=3Dlinux-omap&m=3D127445522921326&w=3D2>
> [PATCH V6] OMAP: DSS: Add NEC NL8048HL11-01B display panel <http://ma=
rc.info/?l=3Dlinux-omap&m=3D127445535621669&w=3D2>
>=20
> Finally I've enabled DSS and lcd NEC_NL8048HL11 in kernel config file=
=2E
>=20
> At this time the kernel boots well, and my LCD backlight turns on but=
 I can't see TUX while booting, and I can't draw anything after logging=
 in.
> I've checked, the framebuffer device is present and configured with s=
ize of 800x480.
>=20
> I've played with sys filesystem like on this wiki, but nothing happen=
ed:
> <http://www.omappedia.org/wiki/Bootargs_for_enabling_display>
>=20
> To enable DSS at boot time, I passed following boot options:
> vram=3D10M omapdss.def_disp=3Dlcd
>=20
>=20
> Perhaps I've missed something?
>=20
> Thank you in advance.
>=20
> ---
> Yanick
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
