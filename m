From: Balaji T K <balajitk@ti.com>
Subject: Re: [RFC v2] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 21:15:59 +0530
Message-ID: <5241B3B7.5070701@ti.com>
References: <1380009480-4975-1-git-send-email-javier.martinez@collabora.co.uk> <20130924154048.GM2684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130924154048.GM2684@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, r.sricharan@ti.com, holler@ahsoftware.de
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 September 2013 09:10 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130924 01:06]:
>> The OMAP GPIO controller HW requires a pin to be configured in GPIO
>> input mode in order to operate as an interrupt input. Since drivers
>> should not be aware of whether an interrupt pin is also a GPIO or not,
>> the HW should be fully configured/enabled as an IRQ if a driver solely
>> uses IRQ APIs such as request_irq(), and never calls any GPIO-related
>> APIs. As such, add the missing HW setup to the OMAP GPIO controller's
>> irq_chip driver.
>>
>> Since this bypasses the GPIO subsystem we have to ensure that another
>> caller won't be able to request the same GPIO pin that is used as an
>> IRQ and set its direction as output. Requesting the GPIO and setting
>> its direction as input is allowed though.
>
> Also please mention the regression that this fixes. So far we know
> that smsc911x for tobi and igep boards in mainline, and also the

> MMC card detect for omap4 boards.
Hi Tony,

Card detect on omap4 board (sdp and panda) is not based on omap gpio,
so I think this fix is not applicable for omap4.

Card detect line for SD card goes to power IC on OMAP4 panda and SDP.
