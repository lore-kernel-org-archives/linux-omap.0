From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: [PATCH] [PATCH] remove pcm049 from Makefile
Date: Mon, 29 Oct 2012 19:30:22 +0100
Message-ID: <1351535422-4644-1-git-send-email-holzmayr@rsi-elektrotechnik.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9361 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125Ab2J2Sad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 14:30:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>

---
 arch/arm/mach-omap2/Makefile |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index fe40d9e..d1155be 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,8 +236,6 @@ obj-$(CONFIG_MACH_TOUCHBOOK)		+=3D board-omap3touch=
book.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+=3D board-4430sdp.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+=3D board-omap4panda.o
=20
-obj-$(CONFIG_MACH_PCM049)		+=3D board-omap4pcm049.o
-
 obj-$(CONFIG_MACH_OMAP3517EVM)		+=3D board-am3517evm.o
=20
 obj-$(CONFIG_MACH_CRANEBOARD)		+=3D board-am3517crane.o
--=20
1.7.9.5


--=20
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
=46on: +49 8444 9204-0
=46ax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch=E4ftsf=FChrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
