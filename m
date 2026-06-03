Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E347DD7C
	for <linux-omap@vger.kernel.org>; Wed,  3 Jun 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491161; cv=none; b=Al8TaATGzxGF9eiKTgjtz1tZPS2L3H+uGTRns1DqV8NeG0GJ4CJT+8sfqwTR8VXFd81g7vj27A0kfDLNL78B/8oIN16QQ3fZi9OiVUaFsHdWDvzkDcN4BjbNgisaqw87bXbUZ2MRUMmOs0uY7BHforwk+Ncl1/HiIP0Z0iF3dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491161; c=relaxed/simple;
	bh=TMO6/sqqphaAw9Vzlx20Mc68hzOh871N8XG+GNNVWEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKtrght71xhJfyyGEW30ThFK1DvqrYwwjhJMS91MxcNkViBaAkNr7Ji5sKUJ916L+mGLxqd1j6oIK3Ls4630ghXwG+e9oAAvpjhnG9DcBQYn0pvJiRHaWR1Yiik9F5bj+81UVtY6kv5X6P6D1bFMzg1PR5PO1KifG4pPNdECbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUl5K-0005FN-E5; Wed, 03 Jun 2026 14:52:38 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUl5I-000umP-2J;
	Wed, 03 Jun 2026 14:52:36 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wUl5I-00000007NDc-2dr9;
	Wed, 03 Jun 2026 14:52:36 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 03 Jun 2026 14:52:34 +0200
Subject: [PATCH] mfd: twl4030-power: drop dead machine_is_*() macros
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-mfd-remove-mach-types-h-v1-1-751e119167da@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJEjIGoC/x3MTQqAIBBA4avErBuwH4y6SrTQHHMWWmhEId09a
 fkt3suQKDIlmKoMkS5OvIeCpq5gdSpshGyKoRWtFFJ06K3BSH6/CL1aHZ7PQQkdaqVH2TW9NoO
 BUh+RLN//eV7e9wN0TRisaQAAAA==
X-Change-ID: 20260603-mfd-remove-mach-types-h-bab96314bd7d
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491156; l=1458;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=TMO6/sqqphaAw9Vzlx20Mc68hzOh871N8XG+GNNVWEY=;
 b=zwqO9cgdVkRBdWMoilOdUqbB/mMtZlGtLzsWfte2tfdHGtnvibWW5lxxvxJzXnVI9FBGD+O9j
 ckGWfXIKqUwC36l/q9O2jaJYa/vwztAQUxXbipBwyCyCuq8eyRCF/fN
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org

OMAP LDP and 3430SDP are converted to dt in [1] and [2], the
corresponding machine_is_*() macros always expand to 0. Drop them and
with it the now unnecessary inclusion of mach-types.h.

[1] e92fc4f04a34a ("ARM: OMAP2+: Drop legacy board file for LDP")
[2] 1b383f44aabc8 ("ARM: OMAP2+: Drop board file for 3430sdp")

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mfd/twl4030-power.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0bca948ab6bae..b6251a2a3078c 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -30,8 +30,6 @@
 #include <linux/property.h>
 #include <linux/of.h>
 
-#include <asm/mach-types.h>
-
 static u8 twl4030_start_script_address = 0x2b;
 
 /* Register bits for P1, P2 and P3_SW_EVENTS */
@@ -294,8 +292,7 @@ twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pdata,
 	if (err)
 		goto out;
 
-	if (pdata->ac_charger_quirk || machine_is_omap_3430sdp() ||
-	    machine_is_omap_ldp()) {
+	if (pdata->ac_charger_quirk) {
 		/* Disabling AC charger effect on sleep-active transitions */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data,
 				      R_CFG_P1_TRANSITION);

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-mfd-remove-mach-types-h-bab96314bd7d

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

