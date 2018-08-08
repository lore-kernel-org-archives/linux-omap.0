From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
Date: Wed, 8 Aug 2018 18:27:25 +0200
Message-ID: <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808155548.s7p4xqsjywz3psrj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180808155548.s7p4xqsjywz3psrj@ninjato>
Sender: netdev-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-omap@vger.kernel.org

2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is a follow-up to the previously rejected series[1] which partially
>> removed the at24_platform_data structure. After further development and
>> taking reviews into account, this series finally removes that struct
>> completely but not without touching many different parts of the code
>> base.
>>
>> Since I took over maintainership of the at24 driver I've been working
>> towards removing at24_platform_data in favor for device properties.
>
> Wooha, nice work. I can't really comment on it but wondered how you want
> to upstream it (after reviews)? Pull request of an immutable branch for
> nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
> it. Probably same situation for arm-soc...
>

I initially wanted to merge small parts of it starting with v4.18, but
there were some voices against merging APIs without users. I'm not
sure how it should go in. There'll be a need for multiple immutable
branches most probably...

Bart
