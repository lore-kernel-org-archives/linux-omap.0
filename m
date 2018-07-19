From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 10:57:27 +0200
Message-ID: <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
References: <20180719082028.26116-1-brgl@bgdev.pl> <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719084503.tfv6jllsukk2zv3f@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, arm-soc <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2018-07-19 10:48 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
> On Thu, Jul 19, 2018 at 10:20:27AM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Many non-DT platforms read the MAC address from EEPROM. Usually it's
>> either done with callbacks defined in board files or from SoC-specific
>> ethernet drivers.
>>
>> In order to generalize this, try to read the MAC from nvmem in
>> eth_platform_get_mac_address() using a standard lookup name:
>> "mac-address".
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  net/ethernet/eth.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index 39af03894598..af3b4b1b77eb 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -54,6 +54,7 @@
>>  #include <linux/if_ether.h>
>>  #include <linux/of_net.h>
>>  #include <linux/pci.h>
>> +#include <linux/nvmem-consumer.h>
>>  #include <net/dst.h>
>>  #include <net/arp.h>
>>  #include <net/sock.h>
>> @@ -527,8 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>>
>>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>  {
>> +     unsigned char addrbuf[ETH_ALEN];
>>       const unsigned char *addr;
>> +     struct nvmem_cell *nvmem;
>>       struct device_node *dp;
>> +     size_t alen;
>>
>>       if (dev_is_pci(dev))
>>               dp = pci_device_to_OF_node(to_pci_dev(dev));
>> @@ -541,6 +545,29 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>       if (!addr)
>>               addr = arch_get_platform_mac_address();
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>> +                     /* We may have a lookup registered for MAC address but
>> +                      * the corresponding nvmem provider hasn't been
>> +                      * registered yet.
>> +                      */
>> +                     return -EPROBE_DEFER;
>> +
>> +             if (!IS_ERR(nvmem)) {
>> +                     addr = nvmem_cell_read(nvmem, &alen);
>> +                     if (!IS_ERR(addr)) {
>                                     ^^^^
> Never do success handling.  Always error handling.  Otherwise the code
> is indent a lot and the error handling is far from the call.
>
>> +                             if (alen == ETH_ALEN)
>> +                                     ether_addr_copy(addrbuf, addr);
>> +
>> +                             kfree(addr);
>> +                             addr = alen == ETH_ALEN ? addrbuf : NULL;
>> +                     }
>> +
>> +                     nvmem_cell_put(nvmem);
>> +             }
>> +     }
>> +
>>       if (!addr || !is_valid_ether_addr(addr))
>                                           ^^^^
> Instead of handling the error we dereference the error pointer here.
>

True - we should add a check for IS_ERR(addr) here.

> *frowny face*
>
>>               return -ENODEV;
>>
>> --
>
> Maybe this?
>
>         if (!addr) {
>                 nvmem = nvmem_cell_get(dev, "mac-address");
>                 if (PTR_ERR(nvmem) == -EPROBE_DEFER)
>                         return -EPROBE_DEFER;
>                 if (IS_ERR(nvmem))
>                         return -ENODEV;
>                 addr = nvmem_cell_read(nvmem, &alen);
>                 if (IS_ERR(addr))
>                         return PTR_ERR(addr);
>                 if (alen != ETH_ALEN) {
>                         kfree(addr);
>                         return -ENODEV;
>                 }
>                 ether_addr_copy(addrbuf, addr);
>                 kfree(addr);
>                 addr = addrbuf;
>         }
>         if (!is_valid_ether_addr(addr))
>                 return -ENODEV;
>         ether_addr_copy(mac_addr, addr);
>         return 0;
>

I would normally go this way but here we don't want to bail out when
we encounter an error but rather continue on to the next possible
source of a MAC address. We'll get -ENODEV from nvmem_cell_get() if
the lookup fails for "mac-address" but instead of returning an error
code we should then check if we can read the MAC from MTD.

Bart
