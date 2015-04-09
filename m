From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCHv7] media: i2c/adp1653: fix includes
Date: Thu, 9 Apr 2015 14:43:59 +0200
Message-ID: <CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
References: <20150403202624.GA4308@amd>
	<20150403213655.GO20756@valkosipuli.retiisi.org.uk>
	<20150404074337.GA31064@amd>
	<20150404102435.GR20756@valkosipuli.retiisi.org.uk>
	<20150404171116.GA15025@Nokia-N900>
	<20150404200307.GS20756@valkosipuli.retiisi.org.uk>
	<20150409074238.GA22603@amd>
	<20150409091017.GA4526@earth>
	<20150409112943.GA31173@amd>
	<20150409121913.GB18713@earth>
	<20150409123155.GB9563@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150409123155.GB9563@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mchehab@osg.samsung.com, hverkuil@xs4all.nl
List-Id: linux-omap@vger.kernel.org

Hello Pavel,

On Thu, Apr 9, 2015 at 2:31 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Fix includes according to Sebastian.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> ---
>
> On Thu 2015-04-09 14:19:14, Sebastian Reichel wrote:
>> On Thu, Apr 09, 2015 at 01:29:43PM +0200, Pavel Machek wrote:
>> > On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
>> > > On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
>> > > > [...]
>> > > > +#include <linux/of_gpio.h>
>> > > > +#include <linux/gpio.h>
>> > > > [...]
>> > >
>> > > This should probably be
>> > >
>> > > #include <linux/of.h>
>> > > #include <linux/gpio/consumer.h>
>> >
>> > And I thought people would only bikesched paint on the
>> > Documentation. Sakari, feel free to change that, but
>>
>> > a) I don't see why Sebastian's version is better
>>
>> You neither use <linux/of_gpio.h> nor <linux/gpio.h>.
>>
>> Well "include/linux/gpio.h" describes the old gpio API. The new
>> gpiod gpiod API is described in "include/linux/gpio/consumer.h" and
>> you use it, so the include should be included ;)
>>
>> You don't use anything from "include/linux/of_gpio.h", but it
>> includes "include/linux/of.h", which you are using. So you should
>> include <linux/of.h> instead ;)
>
> diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
> index d703636..7107ac2 100644
> --- a/drivers/media/i2c/adp1653.c
> +++ b/drivers/media/i2c/adp1653.c
> @@ -35,8 +35,8 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> -#include <linux/of_gpio.h>
> -#include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/gpio/consumer.h>
>  #include <media/adp1653.h>
>  #include <media/v4l2-device.h>
>

Please re-spin your previous patch and submit it properly.

Best regards,
Javier
