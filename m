From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 02/11] OMAP: SDRC: Add several new register definitions
Date: Tue, 18 Aug 2009 14:56:23 +0300
Message-ID: <20090818115621.14171.78574.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Add missing SDRC register offset macros.

Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
[paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org: added commit message]
Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/plat-omap/include/mach/sdrc.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 0be18e4..8fff90a 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -21,19 +21,28 @@
 /* SDRC register offsets - read/write with sdrc_{read,write}_reg() */
 
 #define SDRC_SYSCONFIG		0x010
+#define SDRC_CS_CFG		0x040
+#define SDRC_SHARING		0x044
+#define SDRC_ERR_TYPE		0x04C
 #define SDRC_DLLA_CTRL		0x060
 #define SDRC_DLLA_STATUS	0x064
 #define SDRC_DLLB_CTRL		0x068
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
+#define SDRC_MCFG_0		0x080
 #define SDRC_MR_0		0x084
+#define SDRC_EMR2_0		0x08c
 #define SDRC_ACTIM_CTRL_A_0	0x09c
 #define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
+#define SDRC_MANUAL_0		0x0a8
+#define SDRC_MCFG_1		0x0B0
 #define SDRC_MR_1		0x0B4
+#define SDRC_EMR2_1		0x0BC
 #define SDRC_ACTIM_CTRL_A_1	0x0C4
 #define SDRC_ACTIM_CTRL_B_1	0x0C8
 #define SDRC_RFR_CTRL_1		0x0D4
+#define SDRC_MANUAL_1		0x0D8
 
 /*
  * These values represent the number of memory clock cycles between


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
