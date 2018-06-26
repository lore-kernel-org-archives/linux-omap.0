From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
Date: Tue, 26 Jun 2018 15:38:14 +0200
Message-ID: <CAMRc=McCk6fz5x5vJmjYkYx-i6XfGPAZPm9ctg2fuCCfkvKpLQ@mail.gmail.com>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch> <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch> <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
 <20180626132154.GA5064@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626132154.GA5064@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-06-26 15:21 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> I see. I see it this way: the setup callback comes from the time when
>> we didn't have nvmem and should go away. I will protest loud whenever
>> someone will try to use it again and will work towards removing it as
>> soon as possible.
>
> The setup() callback could be moved into the nvmem framework, rather
> than in the at24 driver. Make the call when the cells have been
> connected to the backing store.
>

This would at least make it more generic. And maybe I could also get
rid of the setup callback from the mityomapl138 board file.

Bart

>> I will give your problem a thought and will try to get back with some
>> proposals - maybe we should, as you suggested, extend nvmem even
>> further to allow to remove nvmem info entries etc.
>
> That does not help me too much. I have the same problem with i2c and
> MDIO. So i actually prefer to keep this the same as all others.
>
>         Andrew
