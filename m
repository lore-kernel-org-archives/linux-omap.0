From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 4/5] net: add support for nvmem to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 23:24:37 +0200
Message-ID: <CAMRc=MfYp8Q4KNUMhLqf5jgd+C-_bWnfHworTbaCj0CZgRqMeA@mail.gmail.com>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-5-brgl@bgdev.pl>
 <20180719174728.GK6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719174728.GK6920@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-07-19 19:47 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
>> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>                       from = "arch callback";
>>       }
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>
> This is way too verbose.  To quote Al Viro from earlier today:
>
> <viro> sigh...
> <viro>         if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
> <viro> what the hell is wrong with if (link == ERR_PTR(-EEXIST))?
>
> I wonder why so many people haven't heard of pointer comparison... ;)
>
> IS_ERR(ERR_PTR(-EPROBE_DEFER)) is always true - if it wasn't, then
> we'd be in for problems.
>
> So, if you're asserting that nvmem is ERR_PTR(-EPROBE_DEFER) then
> there's no need to do the IS_ERR(nvmem) must also be true.  Hence, a
> simple pointer comparison is sufficient:
>
>                 if (nvmem == ERR_PTR(-EPROBE_DEFER))
>                         return -EPROBE_DEFER;
>

Hi Russell,

this issue is gone now in v3 but thanks for the example - I somehow
never thought about it.

Bart
