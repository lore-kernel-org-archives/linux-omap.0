From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 06:14:20 -0500
Message-ID: <526A528C.2020204@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54257 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab3JYLOn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 07:14:43 -0400
In-Reply-To: <526A4DEA.3050505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org

On 10/25/2013 05:54 AM, Nishanth Menon wrote:
> On 10/25/2013 05:25 AM, Tomi Valkeinen wrote:
>> On 25/10/13 13:18, Nishanth Menon wrote:
>>
>>>>  void __init omap_4430sdp_display_init_of(void)
>>>>  {
>>>> -	int r;
>>>> -
>>>> -	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
>>>> -			"display_sel");
>>>> -	if (r)
>>>> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>>>> -
>>>> -	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
>>>> -		"DLP POWER ON");
>>>> -	if (r)
>>>> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
>>>> -
>>>>  	omap_display_init(&sdp4430_dss_data);
>>>>  
>>>>  	platform_device_register(&sdp4430_lcd_device);
>>>>
>>> would you not be depending on the weak IO pull done using mux to drive
>>> these GPIO pins since the GPIO is not requested and held?
>>
>> Yes. Is that not enough?
> 
> It depend on what the signal draw is and io drive strength which
> varies - original intent of weak pulls were to have a non-active
> default state which are overriden by GPIOs as needed. Else we would
> not be having strong pulls here in pads.
> 
> Typical padmux drive strength for OMAP4460 is around 100uA, min is
> around 50uA. meanwhile as Documentation/gpio.txt generically states,
> the buffers driving at 1.8v on OMAP4460 could be around 6mA or upto
> 8mA. Again, these depend on the specific pin in discussion and Data
> manual explain is larger detail
> 
> Lower current is fine if the switch is ok with it and risk for
> transients are reasonably safe. However, board designs generally
> assume the stronger GPIO drive strength.
> 

one additional angle before I forget - this is something we do as part
of power optimization - to identify pins which are programmed for a
pull in non-functional scenario as it has direct impact on idle power
numbers.

For example patch #3 in this series
&omap4_pmx_core {
pinctrl-0
...
	&lcd2_pins
..
}
&lcd2_pins

lcd2_pins: pinmux_lcd2_pins {
+		pinctrl-single,pins = <
+			0x20 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_40 */
+			0x46 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_59 */
+			0x56 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* gpio_104 */
+		>;

3 pins are driven around 300uA at boot, even with display OFF -> which
means wasted current that could have been optimized by hooking the pin
to the dts node corresponding to the device and used by the driver
appropriately.

Unfortunately, folks feel simplifying the driver is traditionally a
better alternative but with a 400 odd pins on a typical SoC of today,
these defaults add up and end user tends to suffer with bad overall
power numbers :(..

-- 
Regards,
Nishanth Menon
