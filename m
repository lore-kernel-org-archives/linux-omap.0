From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Sun, 13 Dec 2015 21:15:01 +0100
Message-ID: <CACRpkdZxGYaRJ_LY0jjHkb67j70Aws53ec2DtwrOzdBfEOj5gQ@mail.gmail.com>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
	<20151209230852.GB28304@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151209230852.GB28304@deathstar>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>, "arm@kernel.org" <arm@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Vladimir Zapolskiy <vl>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2015 at 12:08 AM, Michael Welling <mwelling@ieee.org> wrote:
> On Wed, Dec 09, 2015 at 02:12:40PM +0100, Linus Walleij wrote:
> ...
>> -     ret = gpiochip_add(&bgc->gc);
>> +     ret = gpiochip_add_data(gc, NULL);
>>       if (ret) {
>
> gpiochip_add is still mentioned in the dev_err below.

I explicitly left text string updates aside, I am anyways going to have to go
over all drivers for a second refactoring with gpiodev_alloc() etc.

Yours,
Linus Walleij
