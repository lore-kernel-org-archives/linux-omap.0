From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 03/28] nvmem: add a notifier chain
Date: Wed, 8 Aug 2018 18:30:49 +0200
Message-ID: <CAMpxmJXr60+7mRNf+AQrvSPAxW2hJXCP13rDbmtRfqouKzt3Bg@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-4-brgl@bgdev.pl>
 <20180808161353.GF7275@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180808161353.GF7275@lunn.ch>
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-omap@vger.kernel.org

2018-08-08 18:13 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 05:31:25PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add a blocking notifier chain with two events (add and remove) so that
>> users can get notified about the addition of nvmem devices they're
>> waiting for.
>>
>> We'll use this instead of the at24 setup callback in the mityomapl138
>> board file.
>
> Hi Bartosz
>
> What context is this notifier chain called in?
>
> I did something similar using the i2c notifier to try to work around
> the impending disappearing of the setup callback. But i got lockdep
> splats, because the notifier was called while some locks were being
> held, so it was not possible to register other i2c devices.
>
> The at24 setup callback is done as part of probe, so no important
> locks are held. Are any locks held when this notifier chain is called?
>
> Thanks
>         Andrew

In the case of at24 it would be called from at24_probe() ->
nvmem_register() in process context. Would you mind testing it? Would
be great to see if it works on multiple setups.

Bart
