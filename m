From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 05:54:34 -0500
Message-ID: <526A4DEA.3050505@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
 <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com>
 <526A4585.30403@ti.com> <526A4708.7010309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <526A4708.7010309@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/25/2013 05:25 AM, Tomi Valkeinen wrote:
> On 25/10/13 13:18, Nishanth Menon wrote:
> 
>>>  void __init omap_4430sdp_display_init_of(void)
>>>  {
>>> -	int r;
>>> -
>>> -	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
>>> -			"display_sel");
>>> -	if (r)
>>> -		pr_err("%s: Could not get display_sel GPIO\n", __func__);
>>> -
>>> -	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
>>> -		"DLP POWER ON");
>>> -	if (r)
>>> -		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
>>> -
>>>  	omap_display_init(&sdp4430_dss_data);
>>>  
>>>  	platform_device_register(&sdp4430_lcd_device);
>>>
>> would you not be depending on the weak IO pull done using mux to drive
>> these GPIO pins since the GPIO is not requested and held?
> 
> Yes. Is that not enough?

It depend on what the signal draw is and io drive strength which
varies - original intent of weak pulls were to have a non-active
default state which are overriden by GPIOs as needed. Else we would
not be having strong pulls here in pads.

Typical padmux drive strength for OMAP4460 is around 100uA, min is
around 50uA. meanwhile as Documentation/gpio.txt generically states,
the buffers driving at 1.8v on OMAP4460 could be around 6mA or upto
8mA. Again, these depend on the specific pin in discussion and Data
manual explain is larger detail

Lower current is fine if the switch is ok with it and risk for
transients are reasonably safe. However, board designs generally
assume the stronger GPIO drive strength.

>> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
>> binding to map to the right GPIO and drive it using the GPIO module?
> 
> Hmm, what do you mean?
> 
> I do mux the pins to gpios, but there's nothing in the kernel that would
> use those gpios. That's why we had the hack above, but I'd love to get
> rid of it.
> 
> Can I set the pins to GPIO mode, and set the GPIO to high/low in the .dts?
> 
> If things were perfect, we probably would have a driver for the "switch"
> part. I have no idea what kind of driver that would be, though, so at
> the moment we've just gone with the use-LCD2-by-default route.

I meant you could, in theory provide the gpio numbers and pull
directions in dts and allow the init to drive them as needed.

Something like:
drivers/i2c/busses/i2c-gpio.c as a reference and use
of_get_named_gpio/of_get_gpio to pick themup..


-- 
Regards,
Nishanth Menon
