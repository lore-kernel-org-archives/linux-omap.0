Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA8385D92;
	Sat, 25 Jul 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000235; cv=none; b=Br+eipdH3UodavkkEvKjd3GLPCUleg+U9TdLUEamepSktq3/cjPoRENpFjTwe2oTRHi0Xm1lrWmRZEzCqvDo+3dGsXBN8RhbBLnIzrl536klspkZ8WdyDn95w6P0coo185ilYla9RzGL+l+R/ekekCwC7OYYS5i7/bdRRcWJcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000235; c=relaxed/simple;
	bh=K1DMtGD9MUtJwFgRwIAnpdFdX7iFtgWWkPJKnyqe7U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unt5ijtyFD5I+YXoeAbYy0Ev4V7ANFtdmJUufyiUW+TEE3J4g/BeK4fJQWKm2PUtdTojoydoENTjQF5VUWNQUJ0b7iPHXk9fvZjt/P+Ki0sn2zw/+q9K97CjLF9M8/tNGqCSRq0ZXuvL4liuSIwMcdMVkfUISkTAyqtszKd6ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=8aYbf9K4; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="8aYbf9K4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:Cc:To:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3+NgSSdrOhB6UFHgLNLSjHNgLPH+3NA85R641+myIjY=; t=1785000234; x=1786209834; 
	b=8aYbf9K4da7SH5CcqVQu0PyTyOup4yCI4n21AklhN4maITUM3eN6XNsfsRqrr+8M38/wykrED34
	oCpbtKo0/vSc9CUS1KsqPFhnk0Pa/5YsSmImecE7OtYDG25VaazM3GBrEKIlU+KeKYDEmjW7fF5VQ
	y4vrQmnTfGe0l5jsggpYSG2TRmfVesKwJDykp0h51hXQpDPwMamyrD9ZHROwO6pkjeke3L8YbmCGZ
	1O5SNKUWwwUGhtqPAsfwKvgebFl43IyjK7R9SKwBaHj9flt5l7pkB5SQdZNG15cV995jpPB4IkrAi
	5vhDHyTsQTi++G3l6Z6cZ6tCe4/UtvI2/pwQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>,
	Marek Vasut <marex@denx.de>,
	hns@goldelico.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5] drm/omap: dsi: avoid sending bta sync all the time in writes
Date: Sat, 25 Jul 2026 18:59:09 +0200
Message-ID: <20260725165909.508612-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v5:
- send bta sync on VC_CMD again

Changes in v4:
- wait on completition on all packets (was limited to long packets only,
  because I had the wrong impression that there is no confirmation on
  these)
- Link to v3: https://patch.msgid.link/20260628-vm-upstr-v3-1-9e9add93378b@kemnade.info

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
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 53 ++++++++++++++-----------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2cf..eb3cd0d23cae3 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2194,28 +2194,38 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
 static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 			       const struct mipi_dsi_msg *msg)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 	int r;
 
+	/* wait for IRQ for packet transmission confirmation */
+	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
+				&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		return r;
+
 	if (mipi_dsi_packet_format_is_short(msg->type))
 		r = dsi_vc_send_short(dsi, vc, msg);
 	else
 		r = dsi_vc_send_long(dsi, vc, msg);
 
-	if (r < 0)
+	if ((!r) && wait_for_completion_timeout(&completion,
+				msecs_to_jiffies(500)) == 0)
+		r = -EIO;
+
+	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
+			      &completion, DSI_VC_IRQ_PACKET_SENT);
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
@@ -3233,21 +3243,6 @@ static int _dsi_update(struct dsi_data *dsi)
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
@@ -3268,13 +3263,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 	DSSDBG("dsi_update_channel: %d", vc);
 
 	/*
-	 * Send NOP between the frames. If we don't send something here, the
+	 * Transition to LP here. If we don't send something here, the
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r = _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
 	if (r < 0) {
-		DSSWARN("failed to send nop between frames: %d\n", r);
+		DSSWARN("failed to send bta sync between frames: %d\n", r);
 		goto err;
 	}
 
-- 
2.47.3

