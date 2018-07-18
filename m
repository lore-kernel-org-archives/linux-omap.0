From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:31:58 +0200
Message-ID: <CAMRc=Mfsty0Yd5X=MkyxzG=_QGwXQbGinrFhO-3tnXcf76gc1A@mail.gmail.com>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-2-brgl@bgdev.pl>
 <20180718162849.GA12477@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718162849.GA12477@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-07-18 18:28 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:31PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Initialize the variables with proper values so that we save a few
>> lines of code before we extend this function in the follow-up patches.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  net/ethernet/eth.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index ee28440f57c5..da8530879e1e 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>>
>>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>  {
>> -     const unsigned char *addr;
>> -     struct device_node *dp;
>> +     struct device_node *dp = dev_is_pci(dev) ?
>> +                     pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
>> +     const unsigned char *addr = NULL;
>
> Hi Bartosz
>
> You are now in the net subsystem, which has its own set of additional
> coding styles. One of them is reverse Christmas tree.
>
> You might want to read Documentation/networking/netdev-FAQ.txt.
>
>     Andrew

Hi Andrew,

it's still reverse Christmas tree in this patch except that now we're
taking the length of the variable + initializer into account. I'm not
sure if this is the right approach though.

Bart
