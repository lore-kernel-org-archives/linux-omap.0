From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 4/5] net: add support for nvmem to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 17:25:02 +0200
Message-ID: <CAMpxmJWXLi5XbhJ0a_DcLJcAQK4bjMmKjam4NAn6QW-7nJ0MFA@mail.gmail.com>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-5-brgl@bgdev.pl>
 <20180719152222.GD9119@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719152222.GD9119@lunn.ch>
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2018-07-19 17:22 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
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
>>  net/ethernet/eth.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index 6b64586fd2af..adf5bd03851f 100644
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
>> @@ -530,7 +531,10 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>       struct device_node *dp = dev_is_pci(dev) ?
>>                       pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
>>       const unsigned char *addr = NULL;
>> +     unsigned char addrbuf[ETH_ALEN];
>> +     struct nvmem_cell *nvmem;
>>       const char *from = NULL;
>> +     size_t alen;
>>
>>       if (dp) {
>>               addr = of_get_mac_address(dp);
>> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>                       from = "arch callback";
>>       }
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>
> How does EPROBE_DEFER work here? You say the use case is
> Non-DT. Without having DT, how do you know the cell should exist, but
> does not yet exist? I might be looking at old code, but i only see
> -EPROBE_DEFER inside the if (np) case.
>
>> +                     /* We may have a lookup registered for MAC address but
>> +                      * the corresponding nvmem provider hasn't been
>> +                      * registered yet.
>> +                      */
>> +                     return -EPROBE_DEFER;
>
> You really should return real errors. If i'm reading
> __nvmem_device_get() right, it will return a NULL pointer when the
> cell does not exist. NULL is not an error, so IS_ERR() will return
> false. So you should return all errors from nvmem_cell_get().
>
>        Andrew

We have a patch queued for nvmem for 4.19 which adds a notion of nvmem
cell lookups similar to gpio lookups:
https://patchwork.kernel.org/patch/10496045/

This will work fine with probe deferral.

Bart
