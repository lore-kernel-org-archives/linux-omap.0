From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 28/28] eeprom: at24: kill at24_platform_data
Date: Thu, 9 Aug 2018 13:35:12 +0200
Message-ID: <CAMpxmJU83V_2m+_iipJXGFvj1wgjRp3KHQtZooUc4Ctu1Hw4MA@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-29-brgl@bgdev.pl>
 <CAHp75Veiop-0xAbs7MtdhOrX_vzDz7v=xAUSDnEhTYVfMovFQA@mail.gmail.com> <CAMRc=MdTgr-CTia55cRS-Ob8eOVBQom-nXB670nxjf89U_ZEvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MdTgr-CTia55cRS-Ob8eOVBQom-nXB670nxjf89U_ZEvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunne>
List-Id: linux-omap@vger.kernel.org

2018-08-09 13:33 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-08-08 20:03 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> There are no more users of at24_platform_data. Remove the relevant
>>> header and modify the driver code to not use it anymore.
>>>
>>
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> If you want me to test this on Intel Galileo Gen 2 board, give me a
>> public tree from where I can pull.
>> Thanks.
>>
>
> Yes, you can pull from git@github.com:brgl/linux.git
> davinci-remove-at24-platform-data
>

The branch is topic/davinci-remove-at24-platform-data

> Bart
