From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 27/29] ARM: davinci: mityomapl138: use nvmem notifiers
Date: Fri, 10 Aug 2018 10:05:24 +0200
Message-ID: <20180810080526.27207-28-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Stop using the at24_platform_data setup callback in favor of nvmem
notifiers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 35b2b6068a7a..dacc5292f9bd 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,8 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/notifier.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
@@ -116,10 +118,15 @@ static void mityomapl138_cpufreq_init(const char *partnum)
 static void mityomapl138_cpufreq_init(const char *partnum) { }
 #endif
 
-static void read_factory_config(struct nvmem_device *nvmem, void *context)
+static int read_factory_config(struct notifier_block *nb,
+			       unsigned long event, void *data)
 {
 	int ret;
 	const char *partnum = NULL;
+	struct nvmem_device *nvmem = data;
+
+	if (strcmp(nvmem_dev_name(nvmem), "1-00500") != 0)
+		return NOTIFY_DONE;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -151,8 +158,14 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 bad_config:
 	/* default maximum speed is valid for all platforms */
 	mityomapl138_cpufreq_init(partnum);
+
+	return NOTIFY_STOP;
 }
 
+static struct notifier_block mityomapl138_nvmem_notifier = {
+	.notifier_call = read_factory_config,
+};
+
 static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
 	{
 		.info = {
@@ -176,8 +189,6 @@ static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
 	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
-	.setup		= read_factory_config,
-	.context	= NULL,
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -546,6 +557,7 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_register_notifier(&mityomapl138_nvmem_notifier);
 	nvmem_add_lookup_table(mityomapl138_nvmem_cells,
 			       ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
-- 
2.18.0
