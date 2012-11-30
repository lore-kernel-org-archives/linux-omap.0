From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] gpio: New driver for GPO emulation using PWM generators
Date: Fri, 30 Nov 2012 12:00:03 +0100
Message-ID: <50B891B3.8070400@ti.com>
References: <1353591723-25233-1-git-send-email-peter.ujfalusi@ti.com>
 <20121123075537.A14713E0A91@localhost> <50AF3E21.4000009@ti.com>
 <50AF4584.7020604@ti.com> <20121126154600.765E03E1AFD@localhost>
 <50B5D161.6010200@ti.com> <20121129161024.EEA803E0912@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121129161024.EEA803E0912@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/29/2012 05:10 PM, Grant Likely wrote:
>> 	/* Enable GPIO us of the PWMs */
>> 	gpio-controller =3D <1>;
> =

> This line should be simply (the property shouldn't have any data):
> 	gpio-controller;

Yes I know. It is like this already in my code. I just mixed up things while
hacking it together.

> =

>> 	#gpio-cells =3D <2>;
>> 	pwm,period_ns =3D <7812500>;
> =

> Nit: property names should use '-' instead of '_'.

Yes, true.

>> 	of_property_read_u32(chip->dev->of_node, "pwm,period_ns", &period_ns);
>> 	if (!period_ns) {
>> 		dev_err(chip->dev,
>> 			"period_ns is not specified for GPIO use\n");
>> 		return;
>> 	}
> =

> This property name seems ambiguous. What do you need to encode here? It
> looks like there is a specific PWM period used for the 'on' state. What
> about the 'off' state? Would different pwm outputs have different
> frequencies required for GPIO usage.
> =

> Actually, I'm a bit surprised here that a period value is needed at all.
> I would expect if a PWM is used as a GPIO then the driver would already
> know how to set it up that way.

Some PWM hw can select between different frequencies. They do that based on
the period_ns.
We can not just pass random non 0 number to them since they might fail with
the check for supported frequencies.

> Ugh, yeah this isn't the way to go. Don't register a new platform_device
> for the gpio functionality. It should be inline with the rest of the PWM
> setup and should trigger the registration of a gpio_chip directly.

We also need to take care of the non DT booted cases as well.
What we could do:
this driver with removed DT support for legacy booted systems.
GPO layer implementation within drivers/pwm/ to handle DT boot.

When we boot without DT we need to tell back to the machine driver about the
GPIO start of the gpio chip we just allocated.

Hrm, we could do this from the pwm-twl* drivers as well by adding an option=
al
callback and flag to the pwm core to register the gpio chip.
In this case we can move the whole whole gpio-pwm code under drivers/pwm, a=
dd
the 'struct gpio_chip' to struct pwm_chip{}
and register the gpio chip from within the pwm core.
We still have to provide the period_ns in same way to the PWM instance used=
 as
GPIO, probably via platform data. Not sure about it right now.

-- =

P=E9ter
