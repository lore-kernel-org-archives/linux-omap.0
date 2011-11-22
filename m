From: jean.pihet@newoldbits.com
Subject: [PATCH 01/26] OMAP2+: smartreflex: use sane default values
Date: Tue, 22 Nov 2011 16:05:45 +0100
Message-ID: <1321974370-25800-2-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48485 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab1KVPGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:51 -0500
Received: by eye27 with SMTP id 27so270729eye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:49 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Use sane values for the smartreflex data from the e-fuses.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 9f43fcc..221407a 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -38,11 +38,18 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	struct omap_sr_nvalue_table *nvalue_table;
 	int i, count = 0;
 
+	sr_data->nvalue_count = 0;
+	sr_data->nvalue_table = NULL;
+
 	while (volt_data[count].volt_nominal)
 		count++;
 
 	nvalue_table = kzalloc(sizeof(struct omap_sr_nvalue_table)*count,
 			GFP_KERNEL);
+	if (!nvalue_table) {
+		pr_err("OMAP: SmartReflex: cannot allocate memory for n-value table\n");
+		return;
+	}
 
 	for (i = 0; i < count; i++) {
 		u32 v;
-- 
1.7.5.4

