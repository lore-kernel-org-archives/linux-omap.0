From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 15:37:22 +0300
Message-ID: <20180719123722.sk5fcih6pufy4wpd@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
 <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
 <20180719090929.arbysqo2bk3esoar@mwanda>
 <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 12:06:51PM +0200, Bartosz Golaszewski wrote:
> It looks simpler as long as you don't add all the new routines
> resulting from this approach. I've just tried to quickly implement
> this solution and it resulted in much bigger and duplicated code
> (checking the validity of mac_addr, copying it etc.). I would prefer
> the current approach and would like to read someone else's opinion on
> that.

It's not too bad.  There is two extra ether_addr_copy() calls and one
extra is_valid_ether_addr().  There are two extra alen declarations and
one extra addr declaration.  The functions don't share *that* much code.

regards,
dan carpenter

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index fd8faa0dfa61..8ab7289a5069 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -54,6 +54,8 @@
 #include <linux/if_ether.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/mtd/mtd.h>
 #include <net/dst.h>
 #include <net/arp.h>
 #include <net/sock.h>
@@ -525,7 +527,7 @@ unsigned char * __weak arch_get_platform_mac_address(void)
 	return NULL;
 }
 
-int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+static int of_eth_get_mac_address(struct device *dev, u8 *mac_addr)
 {
 	const unsigned char *addr;
 	struct device_node *dp;
@@ -547,4 +549,82 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 	ether_addr_copy(mac_addr, addr);
 	return 0;
 }
+
+static int nvmem_eth_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	struct nvmem_cell *nvmem;
+	unsigned char *addr;
+	size_t alen;
+	int ret = 0;
+
+	nvmem = nvmem_cell_get(dev, "mac-address");
+	if (PTR_ERR(nvmem) == -EPROBE_DEFER)
+		/* We may have a lookup registered for MAC address but the
+		 * corresponding nvmem provider hasn't been registered yet.
+		 */
+		return -EPROBE_DEFER;
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+	addr = nvmem_cell_read(nvmem, &alen);
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
+		goto put_nvmem;
+	}
+	if (alen != ETH_ALEN || !is_valid_ether_addr(addr)) {
+		ret = -EINVAL;
+		goto free_addr;
+	}
+	ether_addr_copy(mac_addr, addr);
+free_addr:
+	kfree(addr);
+put_nvmem:
+	nvmem_cell_put(nvmem);
+	return ret;
+}
+
+static int mtd_eth_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	struct mtd_info *mtd;
+	u8 addrbuf[ETH_ALEN];
+	size_t alen;
+	int ret;
+
+	/* This function should go away as soon as MTD gets nvmem support. */
+	if (!IS_ENABLED(CONFIG_MTD))
+		return -ENODEV;
+
+	mtd = get_mtd_device_nm("MAC-Address");
+	if (IS_ERR(mtd))
+		return PTR_ERR(mtd);
+	ret = mtd_read(mtd, 0, ETH_ALEN, &alen, addrbuf);
+	if (ret)
+		goto put_mtd;
+	if (!is_valid_ether_addr(addrbuf)) {
+		ret = -EINVAL;
+		goto put_mtd;
+	}
+	ether_addr_copy(mac_addr, addrbuf);
+put_mtd:
+	put_mtd_device(mtd);
+	return ret;
+}
+
+int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
+{
+	int ret;
+
+	ret = of_eth_get_mac_address(dev, mac_addr);
+	if (!ret)
+		return 0;
+	ret = nvmem_eth_get_mac_address(dev, mac_addr);
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!ret)
+		return 0;
+	ret = mtd_eth_get_mac_address(dev, mac_addr);
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
 EXPORT_SYMBOL(eth_platform_get_mac_address);
