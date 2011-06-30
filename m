From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Wed, 29 Jun 2011 20:44:43 -0700
Message-ID: <1309405483-6876-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61081 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab1F3DpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 23:45:07 -0400
Received: by iyb12 with SMTP id 12so1578173iyb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 20:45:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>

Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 drivers/video/omap2/dss/dsi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/ds=
i.c
index c16b933..6975645 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -206,6 +206,7 @@ struct dsi_reg { u16 idx; };
 #define DSI_DT_DCS_LONG_WRITE		0x39
=20
 #define DSI_DT_RX_ACK_WITH_ERR		0x02
+#define DSI_DT_RX_LONG_READ		0x1a
 #define DSI_DT_RX_DCS_LONG_READ		0x1c
 #define DSI_DT_RX_SHORT_READ_1		0x21
 #define DSI_DT_RX_SHORT_READ_2		0x22
@@ -2943,6 +2944,10 @@ static u16 dsi_vc_flush_receive_data(struct plat=
form_device *dsidev,
 		} else if (dt =3D=3D DSI_DT_RX_SHORT_READ_2) {
 			DSSERR("\tDCS short response, 2 byte: %#x\n",
 					FLD_GET(val, 23, 8));
+		} else if (dt =3D=3D DSI_DT_RX_LONG_READ) {
+			DSSERR("\tlong response, len %d\n",
+					FLD_GET(val, 23, 8));
+			dsi_vc_flush_long_data(dsidev, channel);
 		} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ) {
 			DSSERR("\tDCS long response, len %d\n",
 					FLD_GET(val, 23, 8));
@@ -3287,7 +3292,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssde=
v, int channel, u8 dcs_cmd,
 		buf[1] =3D (data >> 8) & 0xff;
=20
 		return 2;
-	} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ) {
+	} else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ || dt =3D=3D DSI_DT_RX_L=
ONG_READ) {
 		int w;
 		int len =3D FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
--=20
1.7.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
