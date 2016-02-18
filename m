From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Bunch of machines are not booting in next again, GPIO regression?
Date: Thu, 18 Feb 2016 19:55:17 +0100
Message-ID: <CACRpkdY2=mYVDU2BXzN1rY7=mP_iyG3UEaCNVom4HFJDf61+0Q@mail.gmail.com>
References: <20160217192755.GC21202@atomide.com>
	<20160217195543.GA871@jcartwri.amer.corp.natinst.com>
	<20160217201259.GA16028@deathstar>
	<20160217202224.GD21202@atomide.com>
	<20160217224415.GA3866@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160217224415.GA3866@jcartwri.amer.corp.natinst.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Welling <mwelling@ieee.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 17, 2016 at 11:44 PM, Josh Cartwright <joshc@ni.com> wrote:

> Here's a properly cooked patch.  Otherwise, feel free to squash it in=
 if
> it's easier for you.
>
> -- 8< --
> Subject: [PATCH] gpio: use kzalloc to allocate gpio_device

Patch applied, of course.

Big hugs and thanks for fixing my stupid mistake!

N=C3=B3ras,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
