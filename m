From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-omap2-mcspi.c: Add dts for slave device
	configuration.
Date: Tue, 26 Mar 2013 00:00:15 +0100
Message-ID: <1364252415-3613-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

TI omap2 mcspi allows the slave devices to configure the behavior of
the SPI master. This patch adds device tree support to the existing
options.

Signed-off-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt | 23 ++++++++++++
 drivers/spi/spi-omap2-mcspi.c                      | 41 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 938809c..fef16bf 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -10,8 +10,20 @@ Required properties:
 			  input. The default is D0 as input and
 			  D1 as output.
 
+SPI Controller specific data in SPI slave nodes:
+
+- The spi slave nodes can provide the following information which is used
+  by the spi controller.
+
+- ti,spi-cs-per-word: Set chipselect to be toggled on every word send.
+
+- ti,spi-turbo-mode: Set turbo mode for this device.
+
+
 Example:
 
+- SoC Specific Portion:
+
 mcspi1: mcspi@1 {
     #address-cells = <1>;
     #size-cells = <0>;
@@ -20,3 +32,14 @@ mcspi1: mcspi@1 {
     ti,spi-num-cs = <4>;
 };
 
+- Board Specific Portion:
+
+	spi-device@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		controller-data {
+			ti,spi-cs-per-word = <1>;
+			ti,spi-turbo-mode = <0>;
+		};
+	};
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 893c3d7..1ae5009 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -731,11 +731,47 @@ static u32 omap2_mcspi_calc_divisor(u32 speed_hz)
 	return 15;
 }
 
+static struct omap2_mcspi_device_config *omap2_mcspi_get_slave_ctrldata(
+			struct spi_device *spi)
+{
+	struct omap2_mcspi_device_config *cd;
+	struct device_node *slave_np, *data_np = NULL;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_err(&spi->dev, "device node not found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	data_np = of_get_child_by_name(slave_np, "controller-data");
+	if (!data_np) {
+		dev_err(&spi->dev, "child node 'controller-data' not found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd) {
+		dev_err(&spi->dev, "could not allocate memory for controller data\n");
+		of_node_put(data_np);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (of_get_property(data_np, "ti,spi-cs-per-word", NULL))
+		cd->cs_per_word = 1;
+
+	if (of_get_property(data_np, "ti,spi-turbo-mode", NULL))
+		cd->turbo_mode = 1;
+
+	of_node_put(data_np);
+	return cd;
+}
+
 /* called only when no transfer is active to this device */
 static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
+	struct omap2_mcspi_device_config *cd = spi->controller_data;
 	struct omap2_mcspi *mcspi;
 	struct spi_master *spi_cntrl;
 	u32 l = 0, div = 0;
@@ -745,6 +781,11 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	mcspi = spi_master_get_devdata(spi->master);
 	spi_cntrl = mcspi->master;
 
+	if (!cd && spi->dev.of_node) {
+		cd = omap2_mcspi_get_slave_ctrldata(spi);
+		spi->controller_data = cd;
+	}
+
 	if (t != NULL && t->bits_per_word)
 		word_len = t->bits_per_word;
 
-- 
1.7.11.7


------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
