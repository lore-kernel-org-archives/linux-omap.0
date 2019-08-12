From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: regulator: twl6030: Add retain-on-reset property" to the regulator tree
Date: Mon, 12 Aug 2019 14:10:09 +0100 (BST)
Message-ID: <20190812131009.7FA002740CED@ypsilon.sirena.org.uk>
References: <20190725094542.16547-2-gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725094542.16547-2-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The patch

   dt-bindings: regulator: twl6030: Add retain-on-reset property

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 906c4d5c939b4d8ebe7be357121271df7b8c9582 Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 25 Jul 2019 11:45:40 +0200
Subject: [PATCH] dt-bindings: regulator: twl6030: Add retain-on-reset property

During reset the VMMC regulator doesn't reach 0V and only drops to
1.8V, furthermore the pulse width is under 200us whereas the SD
specification expect 1ms.

For this 2 reasons being able to no reset at all the VMMC during warm
reset and keep the current voltage is a good workaround. The TWL6030
allows this but needs to be aware of it and this configuration should
also be shared with the bootloader.

This is the purpose of this new property: ti,retain-on-reset

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20190725094542.16547-2-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/twl-regulator.txt        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/twl-regulator.txt b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
index 74a91c4f8530..549f80436deb 100644
--- a/Documentation/devicetree/bindings/regulator/twl-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/twl-regulator.txt
@@ -71,3 +71,10 @@ Example:
 		regulator-min-microvolt  = <1000000>;
 		regulator-max-microvolt  = <3000000>;
 	};
+
+For twl6030 regulators/LDOs:
+
+ - ti,retain-on-reset: Does not turn off the supplies during warm
+                       reset. Could be needed for VMMC, as TWL6030
+                       reset sequence for this signal does not comply
+                       with the SD specification.
-- 
2.20.1
