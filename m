From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
Date: Tue, 26 Jun 2018 09:44:19 +0200
Message-ID: <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
References: <20180625155025.12567-1-brgl@bgdev.pl> <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com> <20180625180237.GC17417@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625180237.GC17417@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-06-25 20:02 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> With my patch 1/14 you'll get -EPROBE_DEFER from nvmem_cell_get() if
>> the nvmem provider is not yet registered. Will that help in your case?
>
> I don't think so. My driver instantiates the AT24 device. So if i get
> -EPROBE_DEFER, i need to cleanup the probe, and return -EPROBDE_DEFER
> to the code. Which means i need to remove the AT24 device...
>
>        Andrew

Are you sure this is the correct approach? I understand that you want
to use something like board files for your machine? Wouldn't it be
better to register a platform device for at24, register a cell lookup
and then depend on that cell from your driver?

Would you mind describing your platform in detail a bit more?

Best regards,
Bartosz
