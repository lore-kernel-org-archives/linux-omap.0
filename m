From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
Date: Tue, 21 Aug 2018 10:38:13 +0100
Message-ID: <81407b4d-a02f-4085-f333-a96102bd96ce@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <20180821005327.0d312a85@tock> <20180821074404.23aaeb6b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821074404.23aaeb6b@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Alban <albeu@free.fr>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli@gmail.com>, Ivan
List-Id: linux-omap@vger.kernel.org

Hi Boris/Bartosz,

On 21/08/18 06:44, Boris Brezillon wrote:
>>> 4/ Add a ->of_xlate() hook that would be called if present by the
>>>     framework instead of using the default parsing we have right now.
>> That is a bit cleaner, but I don't think it would be worse the
>> complexity.
> But it's way more flexible than putting everything in the nvmem
> framework. BTW, did you notice that nvmem-cells parsing does not work
> with flashes bigger than 4GB, because the framework assumes
> #address-cells and #size-cells are always 1. That's probably something
> we'll have to fix for the MTD case.
> 

I have hacked up some thing on these lines to add a custom match 
function for nvmem provider and it looks like it can work for mtd case.

This addresses concern #1 "to ignore of_node from dev pointer passed to 
nvmem_config" also provides way to do some sanity checks on nvmem cell node.
In this patch I have just added a simple mtd_nvmem_match() example which 
will be always true, however we can add checks here to see if the np is 
actually a nvmem-cells node or something on those lines to enforce the 
bindings. Please fix and remove this from nvmem-core patch incase you 
plan to use/test this.

We still have one open issue of supporting #address-cells and 
#size-cells in nvmem, which I can look at if you are happy with this 
approach!

----------------------------------->cut<---------------------------------
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Tue Aug 21 10:07:24 2018 +0100

     nvmem: core: add custom match function support

     Some nvmem providers might not have a simple DT layout, nvmem cells
     could be part of the unpartioned space or with-in partition or
     even in sub partition of the provider.

     Current matching function is expecting that the provider should be
     immediate parent of the cell, which might not be true for the above
     cases. So allow a custom match function for such devices which can
     validate and match the cell as per the provider specific bindings.

     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index a57302eaceb5..33541b18ac30 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -502,6 +502,19 @@ static int mtd_nvmem_reg_read(void *priv, unsigned 
int offset,
         return retlen == bytes ? 0 : -EIO;
  }

+static int mtd_nvmem_match(void *priv, struct device *dev,
+                          struct device_node *np)
+{
+       struct mtd_info *mtd = priv;
+
+       /*
+        * Add more checks to make sure device node is inline with
+        * binding if required
+        */
+
+       return &mtd->dev == dev->parent;
+}
+
  static int mtd_nvmem_add(struct mtd_info *mtd)
  {
         struct nvmem_config config = { };
@@ -516,6 +529,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
         config.read_only = true;
         config.root_only = true;
         config.priv = mtd;
+       config.match = mtd_nvmem_match;

         mtd->nvmem = devm_nvmem_register(&mtd->dev, &config);
         if (IS_ERR(mtd->nvmem)) {
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3a8bf832243d..32bc4e70522c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -41,6 +41,7 @@ struct nvmem_device {
         struct device           *base_dev;
         nvmem_reg_read_t        reg_read;
         nvmem_reg_write_t       reg_write;
+       nvmem_match_t           match;
         void *priv;
  };

@@ -265,6 +266,11 @@ static struct bus_type nvmem_bus_type = {

  static int of_nvmem_match(struct device *dev, void *nvmem_np)
  {
+       struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+       if (nvmem->match)
+               return nvmem->match(nvmem->priv, dev, nvmem_np);
+
         return dev->of_node == nvmem_np;
  }

@@ -482,7 +488,9 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
         nvmem->priv = config->priv;
         nvmem->reg_read = config->reg_read;
         nvmem->reg_write = config->reg_write;
-       nvmem->dev.of_node = config->dev->of_node;
+
+       if (!config->match)
+               nvmem->dev.of_node = config->dev->of_node;

         if (config->id == -1 && config->name) {
                 dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..b29059bb406e 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,6 +14,7 @@

  #include <linux/err.h>
  #include <linux/errno.h>
+#include <linux/of.h>

  struct nvmem_device;
  struct nvmem_cell_info;
@@ -21,6 +22,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned 
int offset,
                                 void *val, size_t bytes);
  typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
                                  void *val, size_t bytes);
+typedef int (*nvmem_match_t)(void *priv, struct device *dev,
+                            struct device_node *np);
+

  /**
   * struct nvmem_config - NVMEM device configuration
@@ -58,6 +62,7 @@ struct nvmem_config {
         bool                    root_only;
         nvmem_reg_read_t        reg_read;
         nvmem_reg_write_t       reg_write;
+       nvmem_match_t           match;
         int     size;
         int     word_size;
         int     stride;

----------------------------------->cut<---------------------------------

thanks,
srini
