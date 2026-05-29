Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44313A9D8B;
	Fri, 29 May 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085989; cv=none; b=lDgNUHUxC4o919pWqHV48B+W8XQGIJLTJClHoSHBYPh4edpyTgsLHr9iP7rUleHOxvIGn7OoAKZC+yNXwbXgRNOkG19DrTdO2guEdNpeBlRZ6wKtEmjHFoP2sMEaZsgi16Cp87q/Cdzsa2L4xRi2GZjTqJ5turhcn2RJjOx7P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085989; c=relaxed/simple;
	bh=dHNqL0eGJFAiEMt+7eKYnWmJpESFfmV9/XNPkjMC0oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQicL0I7Tbz0BQhMnwsI+E5bTBVSUX7mDHvWxEj3JF7Otw6spSQ4z2RqW4wUSpakYRwwVEGdFEUQwt2Z5ipECvaBsK3C+VwARqWkXXxTouTiHb6vjk9ZJophcpHwBJemnU+l/LXgjh05BgrfyeEpnHCfT8TFLD+1WTc6Sn6BgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAZ3O6MJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAZ3O6MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90C51F00893;
	Fri, 29 May 2026 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780085988;
	bh=2Wc41D9OvCbWexi5nL+2XFDqm9GHqqY1BGAs17SzVDI=;
	h=From:Date:Subject:To:Cc;
	b=dAZ3O6MJuxT/2HCwzklBtGozWiqt8nlCPYPjOCs6E+eK3YHn397VwTbwvoNDrV7S2
	 vslHeeNWpFJzAx8ATInrG6zpHqSSCJxZCnm0OlkmyFakD7aZbxvjvwGp2ZUv7/1F64
	 YYAwOjFiqJVbcxJYburHOMtW838Ayi6W8s6g1ws3QXk9/JbTt5V0YeZ1GBacoH2L/9
	 XruXgcnDt7/1v3m9fuJWHYU7IM+IQK3bNPOvpqVmDI5HCcjQuhkhjoc/JoZY9UhhCR
	 5GoYkYIJ5qRQtpJG/XOW+C547LnedFnzJDkdLw5YkXGHq/byy0Eiw+TKU8Nxefjzgs
	 PKel7FaWXDwPw==
From: akemnade@kernel.org
Date: Fri, 29 May 2026 22:19:33 +0200
Subject: [PATCH v2] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-vm-upstr-v2-1-24c30671719f@kernel.org>
X-B4-Tracking: v=1; b=H4sIANT0GWoC/23MQQ7CIBCF4as0sxZTaEuxK+9huhAcWqJCM1Sia
 bi72LXL/+Xl2yAiOYwwVBsQJhdd8CXEoQIzX/2EzN1Kg6iFrDuhWHqy1xJXYkZhL5sWte0klPt
 CaN17py5j6dnFNdBnlxP/rX+QxBlnVp8atMpobPvzHcnj4xhogjHn/AUPgPOJoQAAAA==
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=l2sReNzwjlH32twN/ktwI1ALAm5nnpRCKj6uWBcTpFY=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmSXx5k5rAfXvWx1WH/0tdRN+p+1zW15D5fpruV9fXmC
 fuOKqT+7yhlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAiySGMDAv0K26yntRxPKv0
 eI72s6a5Uuf9XkZ9SLDbIXhukqCbxVOG/7W3TIsubZv8/f0pnUsr3nnNVLnY9LPF2twtMkwrYrF
 OIgcA
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Andreas Kemnade <andreas@kemnade.info>

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
relevant part wos the bta sync to acually force low power mode.

Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.

Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> # droid4
---
This has now been also tested with command mode display on droid4.

Qouting: Ivo:  "you may add my Tested-by"
---
Changes in v2:
- fix commandmode update, need bta sync there
- do not wait on short packets
- Link to v1: https://patch.msgid.link/20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 55 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2c..6391203f6d25 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2194,28 +2194,42 @@ static int dsi_vc_send_null(struct dsi_data *dsi, int vc, int channel)
 static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 			       const struct mipi_dsi_msg *msg)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 	int r;
 
 	if (mipi_dsi_packet_format_is_short(msg->type))
-		r = dsi_vc_send_short(dsi, vc, msg);
+		return dsi_vc_send_short(dsi, vc, msg);
 	else
 		r = dsi_vc_send_long(dsi, vc, msg);
 
 	if (r < 0)
 		return r;
 
-	/*
-	 * TODO: we do not always have to do the BTA sync, for example
-	 * we can improve performance by setting the update window
-	 * information without sending BTA sync between the commands.
-	 * In that case we can return early.
-	 */
+	/* wait for IRQ for long packet transmission confirmation */
+	r = dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
+			&completion, DSI_VC_IRQ_PACKET_SENT);
+	if (r)
+		return r;
 
-	r = dsi_vc_send_bta_sync(dssdev, vc);
-	if (r) {
-		DSSERR("bta sync failed\n");
+	if (wait_for_completion_timeout(&completion,
+			msecs_to_jiffies(500)) == 0)
+		r = -EIO;
+
+	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
+			      &completion, DSI_VC_IRQ_PACKET_SENT);
+
+	if (r)
 		return r;
+
+	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
+
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
+		r = dsi_vc_send_bta_sync(dssdev, vc);
+		if (r) {
+			DSSERR("bta sync failed\n");
+			return r;
+		}
 	}
 
 	/* RX_FIFO_NOT_EMPTY */
@@ -3233,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)
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
@@ -3268,13 +3267,13 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
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
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260528-vm-upstr-c8e7634ebf56

Best regards,
--  
Andreas Kemnade <akemnade@kernel.org>

