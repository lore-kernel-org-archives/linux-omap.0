From: Andy Green <andy@warmcat.com>
Subject: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Thu, 24 Mar 2011 21:27:29 +0000
Message-ID: <20110324212729.14936.98130.stgit@otae.warmcat.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56562 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465Ab1CXV1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 17:27:33 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so456497wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 14:27:32 -0700 (PDT)
In-Reply-To: <20110324211451.14936.39750.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, nicolas.pitre@linaro.org, arnd@arndb.de, x0132446@ti.com, s-jan@ti.com, tony@atomide.com, Andy Green <andy.green@linaro.org>

Introduce a generic helper function that can set a MAC address using
data from the OMAP unique CPU ID register.

For comparison purposes this produces a MAC address of

  2e:40:70:f0:12:06

for the ethernet device on my Panda.


Note that this patch requires the fix patch for CPU ID register
indexes previously posted to linux-omap, otherwise the CPU ID is
misread on Panda by the existing function to do it.  This patch
is already on linux-omap.

"OMAP2+:Common CPU DIE ID reading code reads wrong registers for OMAP4430"
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=b235e007831dbf57710e59cd4a120e2f374eecb9

Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/mach-omap2/id.c              |   39 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/id.h |    1 +
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2537090..e46b430 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -557,3 +557,42 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 	else
 		tap_prod_id = 0x0208;
 }
+
+/*
+ * this uses the unique per-cpu info from the cpu fuses set at factory to
+ * generate a 6-byte MAC address.  Two bits in the generated code are used
+ * to elaborate the generated address into four, so it can be used on multiple
+ * network interfaces.
+ */
+
+void omap2_die_id_to_ethernet_mac(u8 *mac, int subtype)
+{
+	struct omap_die_id odi;
+	u32 tap = read_tap_reg(OMAP_TAP_IDCODE);
+
+	omap_get_die_id(&odi);
+
+	mac[0] = odi.id_2;
+	mac[1] = odi.id_2 >> 8;
+	mac[2] = odi.id_1;
+	mac[3] = odi.id_1 >> 8;
+	mac[4] = odi.id_1 >> 16;
+	mac[5] = odi.id_1 >> 24;
+
+	/* XOR other chip-specific data with ID */
+
+	tap ^= odi.id_3;
+
+	mac[0] ^= tap;
+	mac[1] ^= tap >> 8;
+	mac[2] ^= tap >> 16;
+	mac[3] ^= tap >> 24;
+
+	/* allow four MACs from this same basic data */
+
+	mac[1] = (mac[1] & ~0xc0) | ((subtype & 3) << 6);
+
+	/* mark it as not multicast and outside official 80211 MAC namespace */
+
+	mac[0] = (mac[0] & ~1) | 2;
+}
diff --git a/arch/arm/mach-omap2/include/mach/id.h b/arch/arm/mach-omap2/include/mach/id.h
index 02ed3aa..373313a 100644
--- a/arch/arm/mach-omap2/include/mach/id.h
+++ b/arch/arm/mach-omap2/include/mach/id.h
@@ -18,5 +18,6 @@ struct omap_die_id {
 };
 
 void omap_get_die_id(struct omap_die_id *odi);
+void omap2_die_id_to_ethernet_mac(u8 *mac, int subtype);
 
 #endif

