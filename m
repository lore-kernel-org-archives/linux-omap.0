From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCHv3 7/9] ARM: OMAP: omap_device: Add APIs to enable and idle hwmods
Date: Tue, 6 Aug 2013 12:49:34 -0500
Message-ID: <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57904 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab3HFRub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 13:50:31 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

Needed to let the AM335x PM handle the IPs which need forced
standby transition during every suspend-resume cycle when
the corresponding driver is not compiled into the kernel.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |    8 ++++++++
 arch/arm/mach-omap2/omap_device.h |    2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 5cc9287..8cf63f6 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -219,6 +219,10 @@ static int _omap_device_enable_hwmods(struct omap_device *od)
 	return 0;
 }
 
+int omap_device_enable_hwmods(struct omap_device *od)
+{
+	return _omap_device_enable_hwmods(od);
+}
 /**
  * _omap_device_idle_hwmods - call omap_hwmod_idle() on all hwmods
  * @od: struct omap_device *od
@@ -236,6 +240,10 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
 	return 0;
 }
 
+int omap_device_idle_hwmods(struct omap_device *od)
+{
+	return _omap_device_idle_hwmods(od);
+}
 /* Public functions for use by core code */
 
 /**
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 17ca1ae..655ec35 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -87,6 +87,8 @@ struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
 /* OMAP PM interface */
 int omap_device_get_context_loss_count(struct platform_device *pdev);
+int omap_device_enable_hwmods(struct omap_device *od);
+int omap_device_idle_hwmods(struct omap_device *od);
 
 /* Other */
 
-- 
1.7.9.5

