From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for
 3.5-rc
Date: Fri, 8 Jun 2012 16:30:55 +0300
Message-ID: <1339162255.2091.56.camel@sokoban>
References: <20120607060901.25532.68354.stgit@dusk>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37763 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230Ab2FHNbB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 09:31:01 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>

Hi Paul,

Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
core retention / dev-off patches. There are a couple of minor issues,
like the bug in patch 5, and the fact that counter_32k hwmod data is
broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
this is not done, device off does not work:

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 66da92d..6ad64c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -397,8 +397,7 @@ static struct omap_hwmod_class_sysconfig
omap44xx_counter_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0004,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 


-Tero



