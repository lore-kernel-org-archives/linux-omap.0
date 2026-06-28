Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9651EA65;
	Sun, 28 Jun 2026 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782656214; cv=none; b=BUOVoQuNrnM1M1B5yWgik0/IB51eMYhuQ2XVgk+0dO1LWiHntZlYdTZThdCkTaEJql/c7yAMuTWokL5ez7cRV2zeHFo4yTjmvcx1sSVD75xbzobSd6Nyr98EP7punAPSfXU4E+Ge2cR8E5LNWvnBoaHLLpqkxVS97s3mzQBgwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782656214; c=relaxed/simple;
	bh=RUlJx3JA0zDW1LfL4HqiD3vvHyS050Bh0nT2EHug2iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vr99ceuHMSSedLjHCsx4TvhcVvSHyXwyizElvxntCRFk/wIiyLPq5e4ZH6jjILiN17z7gYGi58TNAK5+YXk1PX6shUF8fgwBlteXiG8vu2i7hbefcuVagEPCPmfHN7wlqCv+ieluTJ1BbHSVB1+Ak4E8gTmQ49m9JgGe9lmtZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=umKHsAJa; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="umKHsAJa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3f5NEG9RavdWSJbEuTWYtJ83mR/jubZCS3vaj2euV+0=; t=1782656213; x=1783865813; 
	b=umKHsAJaAVEBUhPeuzYO8DqMnO/aFyPOuDCetdhIAYs8xrVMnThs/8tDKRvLeR7D1YhYhvo67O3
	mcBp+bSIay/szXcpFPM0KcpNZO3R7hdW5MawylmDWueb88fxcFjzOwMjKI/U+q9htf4tvrcmKBMB/
	yAacv1MJ5JgAn+40scMgyZQAJKYfRJfl7rs/YUYZ4crGxCx83nNtA67JmqzrFZEcExqAXoWg5Tkkn
	m3EyHEeHRtdpuEQ2z/ueyq7urI3iRAKA3Zgq/TETfXYKwL4loedAxShEMCAczorqqQq99AEzqOo1f
	7zoIh8DFciHZh5VzVtZpC0lBIQKff7r16Owg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Sun, 28 Jun 2026 16:15:28 +0200
Subject: [PATCH v3] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAIAsQWoC/22MwQ6CMBAFf4Xs2RraQguc/A/jQeoWGrWQLTYaw
 r9bOGHicV7ezAwByWGAJpuBMLrgBp9AHjIw/dV3yNwtMYhcqLwUFYtP9hrDRMxUqJUssLWlgnQ
 fCa17b6nzJXHvwjTQZytHvq5/IpEzzmxbS7SVabHQpzuSx8dxoA7WShR7s96ZIpmiMDJXmmte2
 x9zWZYvrONibdsAAAA=
X-Change-ID: 20260528-vm-upstr-c8e7634ebf56
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, 
 "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5670; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=RUlJx3JA0zDW1LfL4HqiD3vvHyS050Bh0nT2EHug2iU=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmOOh0OgpatcXsqN+vofmSU37HjcoVb47mnh0TkZ0VfZ
 5J261zRUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwERO5DL8Zv+aanT1eMtEtgsP
 9KoCjvxQzFme0h2rwDDBgLudc7OzECPD9oSwp/5zPDzuXPi0RvThV7bktAM8O/hOigsv4jkl0N3
 HDAA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Some chips need configuration commands to be sent first, before they can
send data. TC358762 for example needs PPI_LPTXTIMECNT configured
and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
configure such chips, do not send bta sync during writes if no acks are
requested. Instead just wait for the packet to be sent to avoid FIFO
overflows. There might be more to do about acks, but there seem to be
virtually no users of that flag.

This came to light when fiddling with the Epson Moverio BT-200 display
which consists of 2 TC358762 bridges with SPI funneled through
to the unknown display chip. With that patch the bridge can be accessed,
Reading back registers works, when the above-mentioned registers are set.

In Command-Mode update, there was a nop sent, apparently the most
relevant part was the bta sync to actually force low power mode.

Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.

Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> # droid4
---
This has now been also tested with command mode display on droid4.

Qouting: Ivo:  "you may add my Tested-by"
---
Changes in v3:

- Link to v2: https://patch.msgid.link/20260529-vm-upstr-v2-1-24c30671719f@kernel.org
- fix things mentioned by claude here:
  https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch1-20260529-vm-upstr-v2-1-24c30671719f@kernel.org/
  - fix typos
  - register ISR before sending packet
  - check for RX_FIFO_NOT_EMPTY also in for short packets

Changes in v2:
- fix commandmode update, need bta sync there
- do not wait on short packets
- Link to v1: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org

To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 56 ++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2cf..f7079a49e824e 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2194,28 +2194,39 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
 static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 			       const struct mipi_dsi_msg *msg)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 	int r;
 
 	if (mipi_dsi_packet_format_is_short(msg->type))
 		r = dsi_vc_send_short(dsi, vc, msg);
-	else
+	else {
+		/* wait for IRQ for long packet transmission confirmation */
+		r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
+					&completion, DSI_VC_IRQ_PACKET_SENT);
+		if (r)
+			return r;
+
 		r = dsi_vc_send_long(dsi, vc, msg);
 
-	if (r < 0)
+		if ((!r) && wait_for_completion_timeout(&completion,
+					msecs_to_jiffies(500)) == 0)
+			r = -EIO;
+
+		dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
+				      &completion, DSI_VC_IRQ_PACKET_SENT);
+	}
+	if (r)
 		return r;
 
-	/*
-	 * TODO: we do not always have to do the BTA sync, for example
-	 * we can improve performance by setting the update window
-	 * information without sending BTA sync between the commands.
-	 * In that case we can return early.
-	 */
+	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
 
-	r = dsi_vc_send_bta_sync(dssdev, vc);
-	if (r) {
-		DSSERR("bta sync failed\n");
-		return r;
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
+		r = dsi_vc_send_bta_sync(dssdev, vc);
+		if (r) {
+			DSSERR("bta sync failed\n");
+			return r;
+		}
 	}
 
 	/* RX_FIFO_NOT_EMPTY */
@@ -3233,21 +3244,6 @@ static int _dsi_update(struct dsi_data *dsi)
 	return 0;
 }
 
-static int _dsi_send_nop(struct dsi_data *dsi, int vc, int channel)
-{
-	const u8 payload[] = { MIPI_DCS_NOP };
-	const struct mipi_dsi_msg msg = {
-		.channel = channel,
-		.type = MIPI_DSI_DCS_SHORT_WRITE,
-		.tx_len = 1,
-		.tx_buf = payload,
-	};
-
-	WARN_ON(!dsi_bus_is_locked(dsi));
-
-	return _omap_dsi_host_transfer(dsi, vc, &msg);
-}
-
 static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 {
 	struct dsi_data *dsi = to_dsi_data(dssdev);
@@ -3268,13 +3264,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 	DSSDBG("dsi_update_channel: %d", vc);
 
 	/*
-	 * Send NOP between the frames. If we don't send something here, the
+	 * Transition to LP here. If we don't send something here, the
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+	r = dsi_vc_send_bta_sync(dssdev, vc);
 	if (r < 0) {
-		DSSWARN("failed to send nop between frames: %d\n", r);
+		DSSWARN("failed to send bta sync between frames: %d\n", r);
 		goto err;
 	}
 

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260528-vm-upstr-c8e7634ebf56

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

