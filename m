From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 01/25] nvmem: add new config option
Date: Tue, 13 Nov 2018 15:01:09 +0100
Message-ID: <20181113140133.17385-2-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add nvmem support for MTD. TI DaVinci is the first platform
that will be using it, but only in non-DT mode. In order not to
introduce any new interface to supporting of which we would have to
commit - add a new config option that tells nvmem not to use the DT
node of the parent device.

This way we won't be creating nvmem devices corresponding with MTD
partitions defined in device tree. By default MTD will set this new
field to true.

Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
able to remove this option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 3 ++-
 include/linux/nvmem-provider.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..ac7971e8154e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -604,7 +604,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->priv = config->priv;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
-	nvmem->dev.of_node = config->dev->of_node;
+	if (!config->no_of_node)
+		nvmem->dev.of_node = config->dev->of_node;
 
 	if (config->id == -1 && config->name) {
 		dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 1e3283c2af77..e53545e9852b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -30,6 +30,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * @ncells:	Number of elements in cells.
  * @read_only:	Device is read-only.
  * @root_only:	Device is accessibly to root only.
+ * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
  * @size:	Device size.
@@ -53,6 +54,7 @@ struct nvmem_config {
 	int			ncells;
 	bool			read_only;
 	bool			root_only;
+	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	int	size;
-- 
2.19.1
