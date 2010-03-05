From: ville.syrjala@nokia.com
Subject: [PATCH 4/4] DSS2: clear spurious SYNC_LOST_DIGIT interrupts
Date: Fri,  5 Mar 2010 15:26:22 +0200
Message-ID: <1267795582-21004-4-git-send-email-ville.syrjala@nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19904 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0CEN1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 08:27:20 -0500
In-Reply-To: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

When DSS transitions from off mode to on VENC may generate a spurious
SYNC_LOST_DIGIT error. Just ack it when restoring the context. Also
restore IRQENABLE last to avoid triggering interrupts before the
context is fully restored.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/dss/dispc.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
index e777e35..b8c1603 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -335,7 +335,7 @@ void dispc_save_context(void)
 void dispc_restore_context(void)
 {
 	RR(SYSCONFIG);
-	RR(IRQENABLE);
+	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
 	RR(DEFAULT_COLOR0);
@@ -472,6 +472,15 @@ void dispc_restore_context(void)
=20
 	/* enable last, because LCD & DIGIT enable are here */
 	RR(CONTROL);
+
+	/* clear spurious SYNC_LOST_DIGIT interrupts */
+	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
+
+	/*
+	 * enable last so IRQs won't trigger before
+	 * the context is fully restored
+	 */
+	RR(IRQENABLE);
 }
=20
 #undef SR
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
