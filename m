From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [RFCv2 4/5] ARM: OMAP4: hwmod data: add aes2
Date: Tue, 13 Jun 2017 11:28:46 +0200
Message-ID: <20170613092847.16732-5-sebastian.reichel@collabora.co.uk>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This adds the hwmod entry for the second AES module
available on OMAP4.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Hi,

This module is currently missing from DT and the public TRM does not provide
enough information for me to add it (the memory area for the crypto cores is
"reserved"). Adding it without the DT entry results in the following error
during boot:

[    0.456085] omap_hwmod: aes2: no dt node
[    0.460205] ------------[ cut here ]------------
[    0.464996] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2359 _init.constprop.19+0x1e4/0x4cc
[    0.475036] omap_hwmod: aes2: doesn't have mpu register target base
[    0.481536] Modules linked in:
[    0.484710] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc4-00030-gcc9206ecc9d9-dirty #421
[    0.493743] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    0.499969] [<c0110260>] (unwind_backtrace) from [<c010c2dc>] (show_stack+0x10/0x14)
[    0.507995] [<c010c2dc>] (show_stack) from [<c04d20e4>] (dump_stack+0xac/0xe0)
[    0.515502] [<c04d20e4>] (dump_stack) from [<c013ab48>] (__warn+0xd8/0x104)
[    0.522735] [<c013ab48>] (__warn) from [<c013aba8>] (warn_slowpath_fmt+0x34/0x44)
[    0.530487] [<c013aba8>] (warn_slowpath_fmt) from [<c0f0cfdc>] (_init.constprop.19+0x1e4/0x4cc)
[    0.539489] [<c0f0cfdc>] (_init.constprop.19) from [<c0f0d7c8>] (__omap_hwmod_setup_all+0x3c/0x100)
[    0.548889] [<c0f0d7c8>] (__omap_hwmod_setup_all) from [<c0101874>] (do_one_initcall+0x3c/0x170)
[    0.557983] [<c0101874>] (do_one_initcall) from [<c0f00eb4>] (kernel_init_freeable+0x210/0x2dc)
[    0.567016] [<c0f00eb4>] (kernel_init_freeable) from [<c0ad6a34>] (kernel_init+0x8/0x114)
[    0.575500] [<c0ad6a34>] (kernel_init) from [<c01077d0>] (ret_from_fork+0x14/0x24)
[    0.583374] ---[ end trace 7e68b72794b10f28 ]---

-- Sebastian

---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0aff064d6469..3d58eaef387e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -992,6 +992,27 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__aes1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod omap44xx_aes2_hwmod = {
+	.name		= "aes2",
+	.class		= &omap44xx_aes_hwmod_class,
+	.clkdm_name	= "l4_secure_clkdm",
+	.main_clk	= "l3_div_ck",
+	.prcm		= {
+		.omap4	= {
+			.context_offs	= OMAP4_RM_L4SEC_AES2_CONTEXT_OFFSET,
+			.clkctrl_offs	= OMAP4_CM_L4SEC_AES2_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__aes2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_aes2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /*
  * 'fdif' class
  * face detection hw accelerator module
@@ -4834,6 +4855,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mpu__emif1,
 	&omap44xx_mpu__emif2,
 	&omap44xx_l3_main_2__aes1,
+	&omap44xx_l3_main_2__aes2,
 	NULL,
 };
 
-- 
2.11.0
