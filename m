From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] gpio: New driver for GPO emulation using PWM generators
Date: Thu, 29 Nov 2012 13:18:11 +0100
Message-ID: <50B75283.6010207@ti.com>
References: <1353591723-25233-1-git-send-email-peter.ujfalusi@ti.com> <20121123075537.A14713E0A91@localhost> <50AF3E21.4000009@ti.com> <50AF4584.7020604@ti.com> <20121126154600.765E03E1AFD@localhost> <50B5D161.6010200@ti.com> <20121128193006.GB23444@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121128193006.GB23444@avionic-0098.adnet.avionic-design.de>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/28/2012 08:30 PM, Thierry Reding wrote:
> I must say I'm not terribly thrilled to integrate something like this
> into the PWM subsystem.

I agree. I would not really want to add my name to something like this =
either...

> I wish hardware engineers wouldn't come up with such designs.

I have checked and rechecked the schematics and datasheets. Still can n=
ot
understand how anyone would come to this HW solution (when the twl4030 =
have at
least 4 unused GPIO line left unconnected).

> But since this seems to be a real use-case, if we want to
> support it we should try and find the "right" solution.
>=20
> Reading the above sounds overly complicated. Couldn't we, instead of
> instantiating an extra driver, just register a GPIO chip if a chip wa=
nts
> to support this functionality? Where the GPIO chip's request callback
> requests the given PWM so that it cannot be used elsewhere? The
> direction_input callback would need to always fail and the set callba=
ck
> can configure the PWM either to 0% or 100% duty-cycle depending on th=
e
> desired output value.

The original driver was doing exactly this. Basically I have added a GP=
O chip
(which was just a translator from PWM to GPO). In DT it looked like thi=
s:

twl_pwm: pwm {
	compatible =3D "ti,twl4030-pwmled";
	#pwm-cells =3D <2>;
};

pwm_gpo1: gpo1 {
	compatible =3D "pwm-gpo";
	#gpio-cells =3D <1>;
	gpio-controller;
	pwms =3D <&twl_pwm 0 7812500>;
	pwm-names =3D "nUSBHOST_PWR_EN";
};

user@1 {
	compatible =3D "example,testuser";
	gpios =3D <&pwm_gpo1 0>;
};

When we boot with DT the pwm_get() needs pwms phandle from the device y=
ou are
calling it in order to find the PWM in question. If we do not have DT e=
ntry
for the GPO driver, we need to build up a pwm_lookup table to ensure th=
at the
pwm_get() will find the PWM we want to handle.

We could implement the GPIO related code under for example
drivers/pwm/pwm-as-gpo.c
But then I should merge the code from drivers/gpio/gpio-pwm.c inside.
This is not nice either since we will have a GPIO driver living under p=
wm/
directory and I'm not sure how this would use the pwm API when the GPO
functionality is requested.

--=20
P=E9ter
