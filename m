From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v7 4/9] drivers:input:tsc2007: add iio interface to read external ADC input and temperature
Date: Sat, 12 Nov 2016 20:22:59 +0100
Message-ID: <6219C71A-909F-4915-AACF-66E4D612016A@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com> <6c64bb0331ad05840a2886bef6c3cfa64c866cb6.1478890925.git.hns@goldelico.com> <fc901399-0bde-d936-b9e2-4c591549eb55@kernel.org> <b4d79a26-4353-9860-a884-49c751bbe617@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <b4d79a26-4353-9860-a884-49c751bbe617@kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

> Am 12.11.2016 um 15:19 schrieb Jonathan Cameron <jic23@kernel.org>:
> 
> On 12/11/16 14:04, Jonathan Cameron wrote:
>> On 11/11/16 19:02, H. Nikolaus Schaller wrote:
>>> The tsc2007 chip not only has a resistive touch screen controller but
>>> also an external AUX adc imput which can be used for an ambient
>>> light sensor, battery voltage monitoring or any general purpose.
>>> 
>>> Additionally it can measure the chip temperature.
>>> 
>>> This extension provides an iio interface for these adc channels.
>>> 
>>> Since it is not wasting much resources and is very straightforward,
>>> we simply provide all other adc channels as optional iio interfaces
>>> as weel. This can be used for debugging or special applications.
>>> 
>>> This patch also splits the tsc2007 driver in several source files:
>>> tsc2007.h -- constants, structs and stubs
>>> tsc2007_core.c -- functional parts of the original driver
>>> tsc2007_iio.c -- the optional iio stuff
>>> 
>>> Makefile magic allows to conditionally link the iio
>>> stuff if CONFIG_IIO=y in a way that it works with
>>> CONFIG_TOUCHSCREEN_TSC2007=m.
>>> 
>> 
>> I ran a quick build test and it blows up in a number of ways related to
>> the #ifdef CONFIG_IIO.
>> 
>> I'm not entirely sure why but
>> #if IS_ENABLED(CONFIG_IIO) works fine.
> Ah, I'm being sleepy today.  It's because I'm building IIO as a module
> and the symbol defined would therefore be CONFIG_IIO_MODULE.
> 
> The IS_ENABLED macro takes care of both cases.

Ah, yes. I wasn't aware that CONFIG_IIO is tristate at all.
We have it as "y" and therefore didn't notice.

I will collect this fix for V8.

>> 
>> Otherwise looks good to me
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Will add this as well.

Thanks for the detailled review!

BR,
Nikolaus


