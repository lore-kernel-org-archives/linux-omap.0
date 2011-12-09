From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP1: Set the omap1623 sram size to 16K
Date: Thu, 8 Dec 2011 17:51:22 -0800
Message-ID: <20111209015122.GM31337@atomide.com>
References: <20111128174508.GO31337@atomide.com>
 <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Now that we're always reprogramming the core clock we must make
sure SRAM works. It seems that neither omap1621 or omap1623
has 256K of SRAM. Set the SRAM size to safe value of 16K.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -141,11 +141,9 @@ static void __init omap_detect_sram(void)
 			omap_sram_size = 0x32000;	/* 200K */
 		else if (cpu_is_omap15xx())
 			omap_sram_size = 0x30000;	/* 192K */
-		else if (cpu_is_omap1610() || cpu_is_omap1621() ||
-		     cpu_is_omap1710())
+		else if (cpu_is_omap1610() || cpu_is_omap1611() ||
+				cpu_is_omap1621() || cpu_is_omap1710())
 			omap_sram_size = 0x4000;	/* 16K */
-		else if (cpu_is_omap1611())
-			omap_sram_size = SZ_256K;
 		else {
 			pr_err("Could not detect SRAM size\n");
 			omap_sram_size = 0x4000;
