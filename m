From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 14/17] staging: tidspbridge: simplify mgr_init()
Date: Fri,  9 Mar 2012 01:03:49 +0100
Message-ID: <c49d8da7fa01003a08ea3f19a05d7cdaa2b1a99c.1331250369.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.mundo-r.com ([212.51.32.151]:31437 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984Ab2CIAEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:04:20 -0500
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
In-Reply-To: <cover.1331250368.git.vjaquez@igalia.com>
References: <cover.1331250368.git.vjaquez@igalia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

No functional changes.

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 drivers/staging/tidspbridge/rmgr/mgr.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/mgr.c b/drivers/staging/t=
idspbridge/rmgr/mgr.c
index 938eea5..8a1e928 100644
--- a/drivers/staging/tidspbridge/rmgr/mgr.c
+++ b/drivers/staging/tidspbridge/rmgr/mgr.c
@@ -319,14 +319,9 @@ int mgr_get_dcd_handle(struct mgr_object *mgr_hand=
le,
 bool mgr_init(void)
 {
 	bool ret =3D true;
-	bool init_dcd =3D false;
=20
-	if (refs =3D=3D 0) {
-		init_dcd =3D dcd_init();	/*  DCD Module */
-
-		if (!init_dcd)
-			ret =3D false;
-	}
+	if (refs =3D=3D 0)
+		ret =3D dcd_init();	/*  DCD Module */
=20
 	if (ret)
 		refs++;
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
