From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 4 Feb 2013 19:15:41 +0100
Message-ID: <CABxcv=nmTwVcG+ucYeMrtU8YgyYYQz3vYF+bKpQ__KDTwXhY=g@mail.gmail.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
	<1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
	<CABxcv=k_gwB3ExQYUeappDZ6FE4L7x8Acer4ZQpDH09BL6LG0Q@mail.gmail.com>
	<510F8F49.9020800@epfl.ch>
	<CABxcv==7KiBbkTyr7VLVw82F=9vVWRftpbyZWub_CVp3pQW0tQ@mail.gmail.com>
	<20130204173252.GN22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61381 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab3BDSPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Feb 2013 13:15:43 -0500
Received: by mail-wi0-f178.google.com with SMTP id o1so3285877wic.17
        for <linux-omap@vger.kernel.org>; Mon, 04 Feb 2013 10:15:41 -0800 (PST)
In-Reply-To: <20130204173252.GN22517@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: florian.vaussard@epfl.ch, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 4, 2013 at 6:32 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [130204 04:00]:
>> On Mon, Feb 4, 2013 at 11:36 AM, Florian Vaussard
>> > Great, the smsc911x was on my TODO list, I can cross it out :) BTW,
>> > do you have a public git for this, so I can test your work on my setup?
>> >
>>
>> Yes, it is the gpmc-smsc911x-wip branch on my github linux tree [1]
>>
>> That branch is Linus master tree + linux-omap/omap-for-v3.9/gpmc +
>> linux-omap-dt/for_3.9/dts
>>
>> plus these patches:
>>
>> Javier Martinez Canillas (4):
>>       ARM: OMAP: gpmc-smsc911x: add DT dev node init function
>>       ARM: OMAP: gpmc: add support for gpmc-smsc911x child nodes
>>       ARM: dts: OMAP: Add an GPMC node for OMAP3
>>       ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
>>
>> You can browse these patches here [2].
>>
>> With these patches I have ethernet working on my IGEPv2 but this board
>> uses an OMAP GPIO pin as the smsc911x IRQ line, so it needs to set a
>> mux pin (mcspi1_cs2.gpio_176 INPUT | MODE4) or it will fallback on
>> poll mode.
>
> Great, that's good news :)
>

it's a start at least :-)

>> For some reasons I still couldn't figure out (I'm still learning about
>> Device Trees) adding:
>>
>>        pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>
>> to the gpmc-smsc911x child node parse function (gpmc_smsc911x_init_dt)
>> didn't have a functional effect and I had to initialize the defined
>> pinctrl-single pins for the smsc911x in the omap3_pmx_core device node
>> instead of pmc_smsc911x@0 as I do for other devices (mmc, uarts, etc).
>
> Maybe this is related to the initcall ordering..
>

I don't think so since I added the gpmc@6e000000 device node as the
last child node for ocp in omap3.dtsi. So, is way after omap3_pmx_core
child node is defined.

Btw, there is a way to specify the initialization order or the
dependencies between device nodes (e.g: gpmc depends on
omap3_pmx_core) or is just because of the position inside the DT?

>> So I just removed the devm_pinctrl_get_select_default() call in
>> gpmc_smsc911x_init_dt() in for this RFC.
>>
>> I don't know if this is because arch/arm/mach-omap2/gpmc-smsc911x.c is
>> not a real platform driver (is just a wrapper/helper function) and
>> doesn't have a probe function.
>
> ..that function just initializes the pdata for smsc911x driver, and
> should not be a driver. You need to add devm_pinctrl_get_select_default()
> to the probe of smsc911x or the GPMC probe.
>

Yes, that's what I meant. In that case I would have something like
this on my board dts:

&gpmc {
	pinctrl-names = "default";
	pinctrl-0 = <&smsc911x_pins>;
	gpmc_smsc911x@0 {
		gpmc,cs = <5>; /* IGEP2_SMSC911X_CS */
		gpmc,gpio_irq = <176>; /* IGEP2_SMSC911X_GPIO */
		gpmc,flags = <18>; /* SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS */
		vmmc-supply = <&vddvario>;
		vmmc_aux-supply = <&vdd33a>;
      };
};

Are you ok with tha approach?

Certainly is better than initializing in omap3_pmx_core node but still
is not consistent with other devices where the pinctrl pins are
defined inside the node of the device that requires them.

>> Which brings me to the question if my approach of adding a binding for
>> gpmc-smsc911x is correct or if we should extend/use the binding that
>> already exist for smsc911x
>> (Documentation/devicetree/bindings/net/smsc911x.txt).
>
> We should use the existing smsc911x binding, then have a separate GPMC
> binding for the GPMC driver.
>

You mean a binding for GPMC or a binding for gpmc-smsc911x?

I don't think that we can use the smsc911x binding directly since
gpmc_smsc911x_init() not only initializes the platform data but also
does some setup such as requesting a memory range for a specific chip
select (gpmc_cs_request), claiming a GPIO and configuring as input
(gpio_request_one), etc.

You can't just calculate the I/O space address for the GPMC cs your
peripheral is connected to and set it on the reg property of the
current smsc911x binding, right?. The same can be said for the nic
IRQ.

Or did I get wrong?

> Regards,
>
> Tony
>

Thanks a lot and best regards,
Javier
