From: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Subject: [PATCH] ARM: OMAP4: PRM: Correct wrong instance usage for reading reset sources
Date: Wed, 19 Dec 2012 12:06:27 +0200
Message-ID: <1355911588-21977-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355911588-21977-1-git-send-email-ivan.khoronzhuk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
List-Id: linux-omap@vger.kernel.org

To read reset sources registers we have to use PRM_DEVICE_INST

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7498bc7..0b61b8d 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -333,7 +333,7 @@ static u32 omap44xx_prm_read_reset_sources(void)
 	u32 r = 0;
 	u32 v;
 
-	v = omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
 				    OMAP4_RM_RSTST);
 
 	p = omap44xx_prm_reset_src_map;
-- 
1.7.9.5
