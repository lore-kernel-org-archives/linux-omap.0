From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 17:07:40 +0200
Message-ID: <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch> <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch> <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719150138.GC9119@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-07-19 17:01 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Thu, Jul 19, 2018 at 10:14:29AM +0200, Bartosz Golaszewski wrote:
>> 2018-07-18 19:03 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> >> >> +#ifdef CONFIG_MTD
>> >> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
>> >> >> +     if (!addr) {
>> >> >> +             struct mtd_info *mtd;
>> >> >> +             int rv;
>> >> >> +
>> >> >> +             mtd = get_mtd_device_nm("MAC-Address");
>> >> >
>> >> > In order for this to go away, you need to keep backwards
>> >> > compatibility. When using nvmem, you look for a cell called
>> >> > "mac-address". Here you are looking for "MAC-Address". That is going
>> >> > to make backwards compatibility harder. How do you plan to do it?
>> >> >
>> >> >    Andrew
>> >>
>> >> I'm trying to adjust to already existing users. The only user of
>> >> get_mtd_device_nm() who calls it to read the MAC address registers a
>> >> partition called "MAC-Address". We can't change it since it's visible
>> >> from user space. In the future we'd just have to have a list of
>> >> supported string that we'd use to do the nvmem lookup.
>> >
>> > Why not have the nvmem cell called "MAC-Address"? When you add nvmem
>> > support to MTD, i assume you are going to map each MTD partition to an
>> > nvmem cell?
>>
>> Because all existing users of nvmem use "mac-address" as the name of
>> this cell already. I guess we will need to live with both in this
>> particular function.
>
> So i'm not convinced this last patch is making things better. I would
> prefer if it was dropped for the moment. Wait until MTD via nvmem is
> actually implemented and there is a concrete concept of how a MAC
> address would be looked up without having lots of ugly code.
>
>         Andrew

Unfortunately: this would effectively block me from improving the
support for older davinci boards. Having a (subjectively) ugly but
generalized way of reading the MAC address from MTD is still better
than using the MTD notifier from board files IMO.

Bart
