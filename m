From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] ARM: OMAP2+: Add support for RNG on DT booted N900
Date: Mon,  7 Apr 2014 14:28:46 +0200
Message-ID: <1396873726-4657-1-git-send-email-sre@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:33999 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbaDGM2x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Apr 2014 08:28:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>

Add support for OMAP3 ROM Random Number Generator via
pdata-quirks.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi Tony,

I currently see no clean way to add DTS based support for the
random number generator in the N900, so this patch initializes
it using pdata-quirks.

I think its worth adding this for now, since its one of the few
things missing to get N900 DT based boot to the same level as
platform data based boot.

I've prepared a table tracking the patch status for my N900 DT
patches targeting 3.16 at [0]. If I'm not mistaken all of the
N900's hardware supported via platform data is also supported
via DT after these patches are merged. The overall status (incl.
hardware, which is also not supported by platform data) can
be seen on [1].

[0] http://elinux.org/N900/Changelog#Kernel_3.16_.28planned.29
[1] http://elinux.org/N900#Kernel_Status

-- Sebastian
---
 arch/arm/mach-omap2/pdata-quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index b04c5f0..5baad1e 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -227,6 +227,14 @@ static void __init am3517_evm_legacy_init(void)
 	am35xx_emac_reset();
 }
 
+static struct platform_device omap3_rom_rng_device = {
+	.name		= "omap3-rom-rng",
+	.id		= -1,
+	.dev	= {
+		.platform_data	= rx51_secure_rng_call,
+	},
+};
+
 static void __init nokia_n900_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
@@ -240,6 +248,10 @@ static void __init nokia_n900_legacy_init(void)
 			pr_warning("RX-51: Not enabling ARM errata 430973 workaround\n");
 			pr_warning("Thumb binaries may crash randomly without this workaround\n");
 		}
+
+		pr_info("RX-51: Registring OMAP3 HWRNG device\n");
+		platform_device_register(&omap3_rom_rng_device);
+
 	}
 }
 #endif /* CONFIG_ARCH_OMAP3 */
-- 
1.9.1

