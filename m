From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
Date: Mon, 25 Jun 2018 19:46:51 +0200
Message-ID: <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174024.GB17417@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-06-25 19:40 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Mon, Jun 25, 2018 at 05:50:11PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Since I took over maintainership of the at24 driver I've been working
>> towards removing at24_platform_data in favor for device properties.
>>
>> DaVinci is the only platform that's still using it - all other users
>> have already been converted.
>>
>> One of the obstacles in case of DaVinci is removing the setup() callback
>> from the pdata struct, the only user of which are some davinci boards.
>
> Hi Bartosz
>
> Nice code.
>
> I've got a platform i want to add sometime soon using the at24. I
> noticed you doing the cleanup, so i avoided the setup() call. But
> using it would of helped...
>
> My platform is x86 based, so no device tree. I instantiate a number of
> AT24 devices from a platform driver, and then add nvmem cells so i can
> access data in these eeproms. This new code will make this simpler.
>
>> The only board that's still using this callback is now mityomapl138.
>> Unfortunately it stores more info in EEPROM than just the MAC address
>> and will require some more work. Unfortunately I don't have access
>> to this board so I can't test any actual solutions on a live hardware.
>
> Depending on what i find in the EEPROM, i need to instantiate other
> i2c devices. So i have the problem of knowing when the EEPROM has
> actually probed and i can use the nvmem API to retrieve the contents.
>
> What i have done so far, is registers a bus notifier on i2c_bus_type,
> and look for BUS_NOTIFY_BOUND_DRIVER. I can then check if the i2c
> client in the notifier is the at24 client. But when i then add more
> i2c clients from inside the notifier i get lockdep splats. They are
> false positives, but it does suggest it is not a good idea to do this.
>
> So it would be good to have some sort of recommended alternative to
> the setup() callback. Ideally it would be specific to a particular
> at24, and safe to call other i2c functions from.
>
> Do you have any ideas?
>
>    Andrew

With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
the nvmem provider is not yet registered. Will that help in your case?

Bart
