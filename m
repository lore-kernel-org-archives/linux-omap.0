From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 09/18] ARM: davinci: da850-evm: remove dead MTD code
Date: Mon, 2 Jul 2018 09:28:47 +0200
Message-ID: <CAMpxmJW2L+nYoPgR0G63uML_bqrhVRwpNRDFEv2e=3r4Yd9NBQ@mail.gmail.com>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-10-brgl@bgdev.pl>
 <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, arm-soc <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2018-06-29 19:09 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We no longer need to register the MTD notifier to read the MAC address
>> as it's now being done in the emac address.
>
>
> I think you mean "it's now being done in the emac _driver_"

Haha yes I do. :)

Thanks,
Bart
