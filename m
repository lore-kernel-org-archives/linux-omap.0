From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 11:48:37 +0300
Message-ID: <20180719084503.tfv6jllsukk2zv3f@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180719082028.26116-3-brgl@bgdev.pl>
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
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Many non-DT platforms read the MAC address from EEPROM. Usually it's
> either done with callbacks defined in board files or from SoC-specific
> ethernet drivers.
> 
> In order to generalize this, try to read the MAC from nvmem in
> eth_platform_get_mac_address() using a standard lookup name:
> "mac-address".
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 39af03894598..af3b4b1b77eb 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -54,6 +54,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/of_net.h>
>  #include <linux/pci.h>
> +#include <linux/nvmem-consumer.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
>  #include <net/sock.h>
> @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> +	unsigned char addrbuf[ETH_ALEN];
>  	const unsigned char *addr;
> +	struct nvmem_cell *nvmem;
>  	struct device_node *dp;
> +	size_t alen;
>  
>  	if (dev_is_pci(dev))
>  		dp = pci_device_to_OF_node(to_pci_dev(dev));
> @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  	if (!addr)
>  		addr = arch_get_platform_mac_address();
>  
> +	if (!addr) {
> +		nvmem = nvmem_cell_get(dev, "mac-address");
> +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
> +			/* We may have a lookup registered for MAC address but
> +			 * the corresponding nvmem provider hasn't been
> +			 * registered yet.
> +			 */
> +			return -EPROBE_DEFER;
> +
> +		if (!IS_ERR(nvmem)) {
> +			addr = nvmem_cell_read(nvmem, &alen);
> +			if (!IS_ERR(addr)) {
                                    ^^^^
Never do success handling.  Always error handling.  Otherwise the code
is indent a lot and the error handling is far from the call.

> +				if (alen == ETH_ALEN)
> +					ether_addr_copy(addrbuf, addr);
> +
> +				kfree(addr);
> +				addr = alen == ETH_ALEN ? addrbuf : NULL;
> +			}
> +
> +			nvmem_cell_put(nvmem);
> +		}
> +	}
> +
>  	if (!addr || !is_valid_ether_addr(addr))
                                          ^^^^
Instead of handling the error we dereference the error pointer here.

*frowny face*

>  		return -ENODEV;
>  
> --

Maybe this?

	if (!addr) {
		nvmem = nvmem_cell_get(dev, "mac-address");
		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
			return -EPROBE_DEFER;
		if (IS_ERR(nvmem))
			return -ENODEV;
		addr = nvmem_cell_read(nvmem, &alen);
		if (IS_ERR(addr))
			return PTR_ERR(addr);
		if (alen != ETH_ALEN) {
			kfree(addr);
			return -ENODEV;
		}
		ether_addr_copy(addrbuf, addr);
		kfree(addr);
		addr = addrbuf;
	}
	if (!is_valid_ether_addr(addr))
		return -ENODEV;
	ether_addr_copy(mac_addr, addr);
	return 0;

regards,
dan carpenter
