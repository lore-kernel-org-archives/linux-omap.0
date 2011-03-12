From: Andy Green <andy@warmcat.com>
Subject: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
Date: Sat, 12 Mar 2011 22:50:47 +0000
Message-ID: <20110312225047.27728.1835.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40480 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab1CLWuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Mar 2011 17:50:50 -0500
In-Reply-To: <20110312224440.27728.60593.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Andy Green <andy.green@linaro.org>

Introduce a generic helper function that can set a MAC address using
data from the OMAP unqiue CPU ID register.

Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/mach-omap2/id.c              |   13 +++++++++++++
 arch/arm/mach-omap2/include/mach/id.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 5f9086c..fc69ec5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -506,3 +506,16 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 	else
 		tap_prod_id = 0x0208;
 }
+
+
+void omap2_die_id_to_mac(u8 *mac, int length)
+{
+	struct omap_die_id odi;
+
+	omap_get_die_id(&odi);
+	memcpy(mac, &odi.id_0, length);
+
+	/* mark it as not multicast and outside official 80211 MAC namespace */
+
+	mac[0] = (mac[0] & ~1) | 2;
+}
diff --git a/arch/arm/mach-omap2/include/mach/id.h b/arch/arm/mach-omap2/include/mach/id.h
index 02ed3aa..72e10eb 100644
--- a/arch/arm/mach-omap2/include/mach/id.h
+++ b/arch/arm/mach-omap2/include/mach/id.h
@@ -18,5 +18,6 @@ struct omap_die_id {
 };
 
 void omap_get_die_id(struct omap_die_id *odi);
+void omap2_die_id_to_mac(u8 *mac, int length);
 
 #endif

