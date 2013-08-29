From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/3] extcon: extcon-gpio-usbvid: Generic USB VBUS/ID
 detection via GPIO
Date: Thu, 29 Aug 2013 13:11:05 -0600
Message-ID: <521F9CC9.4010004@wwwdotorg.org>
References: <1377711185-31238-1-git-send-email-george.cherian@ti.com> <1377711185-31238-2-git-send-email-george.cherian@ti.com> <521EA563.4060305@samsung.com> <521EB018.3000301@ti.com> <521EE8FC.80802@samsung.com> <521EF88F.4070402@ti.com> <521F245E.8050506@samsung.com> <521F3515.7040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <521F3515.7040001@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, balbi@ti.com, myungjoo.ham@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com, davidb@codeaurora.org, arnd@arndb.de, swarren@nvidia.com, popcornmix@gmail.com
List-Id: linux-omap@vger.kernel.org

On 08/29/2013 05:48 AM, George Cherian wrote:
> On 8/29/2013 4:07 PM, Chanwoo Choi wrote:
...
>> I tested various development board based on Samsung Exynos series SoC.
>> Although some gpio of Exynos series SoC set high state(non zero, 1) as
>> default value,
>> this gpio state could mean off state, disconnected or un-powered state
>> according to gpio.
>> Of course, above explanation about specific gpio don't include all gpios.
>> This is meaning that there is possibility.
>
> okay then how about adding a flag for inverted logic too.  something
> like this
> 
> if(of_property_read_bool(np,"inverted_gpio))
>     gpio_usbvid->gpio_inv = 1;
>
> And always check on this before deciding?

Don't do this. GPIO specifiers in DT typically include a "flags" cell
that describes certain GPIO properties. One of those properties is
signal inversion. You can use of_get_named_gpio_flags() to retrieve
those flags.
