From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 17:35:04 +0200
Message-ID: <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch> <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch> <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch> <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
 <20180719152712.GE9119@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719152712.GE9119@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-07-19 17:27 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> Unfortunately: this would effectively block me from improving the
>> support for older davinci boards.
>
> Is there something blocking you from converting the board to device
> tree? This is something i did with a lot of the Marvell boards a few
> years ago. For a while, we had both DT and board setup files. After a
> couple of cycles, we killed off the setup files.
>
>        Andrew

Actually some board are supported both in DT and board files
(da850-evm) right now, but Sekhar wants to keep the support via board
files in the kernel so that's a no go.

Bart
