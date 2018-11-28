From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: omap-mcpdm: Update
	documentation for pdmclk" to the asoc tree
Date: Wed, 28 Nov 2018 16:05:22 +0000 (GMT)
Message-ID: <20181128160523.035E5112521B@debutante.sirena.org.uk>
References: <20181114124631.4586-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114124631.4586-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   dt-bindings: sound: omap-mcpdm: Update documentation for pdmclk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 22cc062c4dfb16330fe18e8d7e155d733fd59e61 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 14 Nov 2018 14:46:30 +0200
Subject: [PATCH] dt-bindings: sound: omap-mcpdm: Update documentation for
 pdmclk

McPDM module receives it's functional clock from external source. This
clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
available all register accesses to McPDM fails and the module is not
operational.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/omap-mcpdm.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
index 5f4e68ca228c..ff98a0cb5b3f 100644
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
@@ -7,6 +7,8 @@ Required properties:
        <L3 interconnect address, size>;
 - interrupts: Interrupt number for McPDM
 - ti,hwmods: Name of the hwmod associated to the McPDM
+- clocks:  phandle for the pdmclk provider, likely <&twl6040>
+- clock-names: Must be "pdmclk"
 
 Example:
 
@@ -18,3 +20,11 @@ mcpdm: mcpdm@40132000 {
 	interrupt-parent = <&gic>;
 	ti,hwmods = "mcpdm";
 };
+
+In board DTS file the pdmclk needs to be added:
+
+&mcpdm {
+	clocks = <&twl6040>;
+	clock-names = "pdmclk";
+	status = "okay";
+};
-- 
2.19.0.rc2
