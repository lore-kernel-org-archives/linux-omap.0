From: ville.syrjala@nokia.com
Subject: [PATCH 1/3] OMAPFB: install omapfb.h
Date: Wed, 24 Feb 2010 00:36:25 +0200
Message-ID: <1266964587-14381-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32398 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab0BWWgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 17:36:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

omapfb has several custom ioctls so user space needs
the header in order to utilize them.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 include/linux/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 1feed71..505ff9e 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -124,6 +124,7 @@ header-y +=3D nfs2.h
 header-y +=3D nfs4_mount.h
 header-y +=3D nfs_mount.h
 header-y +=3D nl80211.h
+header-y +=3D omapfb.h
 header-y +=3D param.h
 header-y +=3D pci_regs.h
 header-y +=3D perf_event.h
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
