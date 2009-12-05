From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3/4 v5a] OMAP: McBSP: Introduce caching in register write operations
Date: Sat, 5 Dec 2009 14:46:46 +0100
Message-ID: <200912051446.47828.jkrzyszt@tis.icnet.pl>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl> <4B19074B.1000606@tis.icnet.pl> <20091204191745.GH24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49160 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZLENqx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Dec 2009 08:46:53 -0500
In-Reply-To: <20091204191745.GH24013@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Reserve space inside omap_mcbsp structure for storing cached copies of McBSP
register values.
Modify the MCBSP_WRITE() macro to update the cache with every register write
operation.
Introduce a new macro that reads from the cache instead of hardware.

Applies on top of patch 2 from this series:
[PATCH v3 2/4] OMAP: McBSP: Prepare register read/write macros API for caching

Tested on OMAP1510 based Amstrad Delta using linux-omap for-next,
commit 4421752e331cfb1d942b47ffdb26e451a8da58a0.
Compile-tested with omap_3430sdp_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---

Tony,

Since I was not sure what your primary concern was, I've prepared two
alternative versions of patch 3/4.
Please take this one as a base for further discussion if your primary concern
was potentially dangerous #else clause. I've replaced it with #elif, that
should be more future proof.
Otherwise, have a look the other one (v5b).

Thanks,
Janusz

--- git/arch/arm/plat-omap/include/plat/mcbsp.h.orig	2009-11-27 11:53:45.000000000 +0100
+++ git/arch/arm/plat-omap/include/plat/mcbsp.h	2009-12-05 03:37:21.000000000 +0100
@@ -415,6 +415,13 @@ struct omap_mcbsp {
 	u16 max_tx_thres;
 	u16 max_rx_thres;
 #endif
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || \
+		defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	u16 reg_cache[OMAP_MCBSP_REG_XCERH / sizeof(u16) + 1];
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+		defined(CONFIG_ARCH_OMAP4)
+	u32 reg_cache[OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1];
+#endif
 };
 extern struct omap_mcbsp **mcbsp_ptr;
 extern int omap_mcbsp_count;
--- git/arch/arm/plat-omap/mcbsp.c.orig	2009-12-01 03:19:56.000000000 +0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-01 03:37:21.000000000 +0100
@@ -49,7 +49,12 @@ int omap_mcbsp_read(void __iomem *io_bas
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
 #define MCBSP_WRITE(mcbsp, reg, val) \
-		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
+		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
+		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
+				 sizeof(*mcbsp->reg_cache)] = val)
+#define MCBSP_READ_CACHE(mcbsp, reg) \
+		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / \
+				  sizeof(*mcbsp->reg_cache)])
 
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
