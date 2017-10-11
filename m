From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Wed, 11 Oct 2017 18:54:04 +0300
Message-ID: <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929223411.9691-6-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 09/30/2017 01:34 AM, Tony Lindgren wrote:
> On omap4 we are missing dts nodes for several interconnect target
> modules that we are idling on init. This currently works with the
> legacy platform data still around.
>=20
> To fix this, let's add the interconnect target modules so we can
> idle the unused interconnect target module on init.
>=20
> Also note that adding the interconnect target module node does not
> necessarily mean that there is a driver available for the child IP
> block, or that the child IP block is even functional.
>=20
> In the SGX case, the PowerVR driver is closed source. And McASP on
> omap4 has at least the TX path disabled and is not supported by the
> davinci-mcasp driver.

RX path is disabled, TX is supposed to work.

...

> +		target-module@40128000 {
> +			compatible =3D "ti,sysc-mcasp";
> +			ti,hwmods =3D "mcasp";
> +			reg =3D <0x40128004 0x4>;
> +			reg-names =3D "sysc";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges =3D <0x00000000 0x40128000 0x1000>, /* MPU */
> +				 <0x49028000 0x49028000 0x1000>; /* L3 */
> +
> +			/*
> +			 * Child device unsupported by davinci-mcasp. At least
> +			 * TX path is disabled for omap4, and only DIT mode

s/TX/RX

> +			 * works with no I2S. See also old Android kernel
> +			 * omap-mcasp driver for more information.

I'll look at the schema of PandaBoard to see if I can route out the McASP
lines to somewhere then I can add support for this revision to davinci-mcas=
p
driver.

--=20
P=C3=A9ter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
