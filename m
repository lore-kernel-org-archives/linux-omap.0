From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 13:23:46 +0100
Message-ID: <20180719122346.GJ6920@n2100.armlinux.org.uk>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719084503.tfv6jllsukk2zv3f@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 11:48:37AM +0300, Dan Carpenter wrote:
> On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Many non-DT platforms read the MAC address from EEPROM. Usually it's
> > either done with callbacks defined in board files or from SoC-specific
> > ethernet drivers.
> > 
> > In order to generalize this, try to read the MAC from nvmem in
> > eth_platform_get_mac_address() using a standard lookup name:
> > "mac-address".
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> > index 39af03894598..af3b4b1b77eb 100644
> > --- a/net/ethernet/eth.c
> > +++ b/net/ethernet/eth.c
> > @@ -54,6 +54,7 @@
> >  #include <linux/if_ether.h>
> >  #include <linux/of_net.h>
> >  #include <linux/pci.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <net/dst.h>
> >  #include <net/arp.h>
> >  #include <net/sock.h>
> > @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
> >  
> >  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> >  {
> > +	unsigned char addrbuf[ETH_ALEN];
> >  	const unsigned char *addr;
> > +	struct nvmem_cell *nvmem;
> >  	struct device_node *dp;
> > +	size_t alen;
> >  
> >  	if (dev_is_pci(dev))
> >  		dp = pci_device_to_OF_node(to_pci_dev(dev));
> > @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
> >  	if (!addr)
> >  		addr = arch_get_platform_mac_address();
> >  
> > +	if (!addr) {
> > +		nvmem = nvmem_cell_get(dev, "mac-address");
> > +		if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
> > +			/* We may have a lookup registered for MAC address but
> > +			 * the corresponding nvmem provider hasn't been
> > +			 * registered yet.
> > +			 */
> > +			return -EPROBE_DEFER;
> > +
> > +		if (!IS_ERR(nvmem)) {
> > +			addr = nvmem_cell_read(nvmem, &alen);
> > +			if (!IS_ERR(addr)) {
>                                     ^^^^
> Never do success handling.  Always error handling.  Otherwise the code
> is indent a lot and the error handling is far from the call.
> 
> > +				if (alen == ETH_ALEN)
> > +					ether_addr_copy(addrbuf, addr);
> > +
> > +				kfree(addr);
> > +				addr = alen == ETH_ALEN ? addrbuf : NULL;
> > +			}
> > +
> > +			nvmem_cell_put(nvmem);
> > +		}
> > +	}
> > +
> >  	if (!addr || !is_valid_ether_addr(addr))
>                                           ^^^^
> Instead of handling the error we dereference the error pointer here.
> 
> *frowny face*
> 
> >  		return -ENODEV;
> >  
> > --
> 
> Maybe this?
> 
> 	if (!addr) {
> 		nvmem = nvmem_cell_get(dev, "mac-address");
> 		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
> 			return -EPROBE_DEFER;
> 		if (IS_ERR(nvmem))
> 			return -ENODEV;
> 		addr = nvmem_cell_read(nvmem, &alen);
> 		if (IS_ERR(addr))
> 			return PTR_ERR(addr);

The problem with doing it this way is... error handling is Hard(tm).
You missed the call to nvmem_cell_put() here.

> 		if (alen != ETH_ALEN) {
> 			kfree(addr);

and again here.

> 			return -ENODEV;
> 		}
> 		ether_addr_copy(addrbuf, addr);
> 		kfree(addr);
> 		addr = addrbuf;

and here.

> 	}
> 	if (!is_valid_ether_addr(addr))
> 		return -ENODEV;
> 	ether_addr_copy(mac_addr, addr);
> 	return 0;

Without checking the semantics, a possible solution to that could be:

	if (!addr) {
		nvmem = nvmem_cell_get(dev, "mac-address");
		if (PTR_ERR(nvmem) == -EPROBE_DEFER)
			return -EPROBE_DEFER;
		if (IS_ERR(nvmem))
			return -ENODEV;
		addr = nvmem_cell_read(nvmem, &alen);
+		nvmem_cell_put(nvmem);
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

A potential better solution would be to put this code in a separate
function, and then do:

	if (!addr)
		addr = eth_platform_get_nvmem_mac_address(dev, addrbuf);

which returns either NULL or addrbuf depending on whether it failed or
succeeded, which would probably end up with cleaner code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
