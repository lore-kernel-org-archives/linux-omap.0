From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Fri, 12 Jul 2013 10:24:42 -0700
Message-ID: <20130712172441.GB9620@dhcp-172-17-186-34.nvidia.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51DEEE15.7040801@wwwdotorg.org>
 <3211864.2dENa1E110@avalon>
 <51E01547.4030204@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:44533 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3GLRYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jul 2013 13:24:50 -0400
Content-Disposition: inline
In-Reply-To: <51E01547.4030204@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 08:40:07AM -0600, Stephen Warren wrote:
> On 07/12/2013 04:41 AM, Laurent Pinchart wrote:
> > Hi Stephen,
[...]
> > What about splitting it in three patches that
> >=20
> > - add the include/dt-bindings/pwm/pwm.h header, and update include/linu=
x/pwm.h=20
> > and Documentation/devicetree/bindings/pwm/pwm.txt
> >=20
> > - update the rest of the documentation
> >=20
> > - update the .dts files
>=20
> I think that sounds reasonable.

Shouldn't the addition of include/dt-bindings/pwm/pwm.h be separate from
its inclusion in include/linux/pwm.h so that it can be moved more easily
(cherry-picked) to a separate repository?

> >>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> >>>
> >>>  enum pwm_polarity {
> >>>
> >>> -	PWM_POLARITY_NORMAL,
> >>> -	PWM_POLARITY_INVERSED,
> >>> +	PWM_POLARITY_NORMAL =3D 0,
> >>> +	PWM_POLARITY_INVERSED =3D 1,
> >>>
> >>>  };
> >>
> >> Rather than manually editing that to ensure the enum matches the DT bi=
ndings
> >> header, the whole point of making a separate <dt-bindings/...> directo=
ry was
> >> that drivers could include the binding header files directly to avoid =
having
> >> to duplicate the constant definitions. Can't <linux/pwm.h> include <dt-
> >> bindings/pwm.h> and remove that enum?
> >=20
> > We could do that, but we would then need to modify all drivers to repla=
ce=20
> > enum_pwm_polarity with unsigned int. Thierry, what's your opinion on th=
is ?
>=20
> Or perhaps we could keep the enums around, but force the values to match
> the DT constants:
>=20
> enum pwm_polarity {
> 	PWM_POLARITY_NORMAL =3D PWM_POLARITY_NORMAL,
> 	PWM_POLARITY_INVERTED =3D PWM_POLARITY_INVERTED,
> };
>=20
> (although obviously you'd need to avoid the enum and DT constants having
> the same name).

I think I've seen stuff like the following done in a few header files to
keep compatibility between enums and defines.

	enum foo {
		BAR,
	#define BAR BAR
		BAZ,
	#define BAZ BAZ
	};

Which, as I understand it, won't work in this case because DTC can only
cope with plain cpp files?

> Although this brings up one point: let's say we support ACPI/.. bindings
> in the future. The enum possibly can't match the binding values from
> every different kind of binding definition (DT, ACPI, ...) so perhaps
> rather than changing the enum definition in <linux/pwm.h>, what we
> should be doing is mapping between the different name-spaces in whatever
> of_xlate function exists for the PWM flags cell. That would be more
> flexible.

I'm not quite sure what exactly you are suggesting here. Can you
elaborate?

Thierry

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR4DvZAAoJEN0jrNd/PrOhZ9kQAJzl3t7DsDVvOC//YrQZ8Bny
ag+GuEh+tJNlgs6ghLXTWfPTKp+Sj2iplkGC/nP7ornVO2Bu+tZbRUwAHlKiu0x3
u+Sk/N/XdvM+ZhEy3PKNPrPWMaB1IS2Fm3Ok7uXJFuIRSUWwiS6k/Wuem0bhw2FV
h0Pgz+m8RYefidZzGtFJWDSW/+Y1BiDeO9tGFUf/Nf+M7ekM8P5B54LO1Ln7dSdZ
7K3ZpP5v8A0KnczHu7znsLARNtLW1meWl01u4MnHMuaXzysRNvBYndi/1jg/R2Gt
ovQlIjiHwyWIqF3Ch50fSpDV+wLZelxTGFt6FslMPoOaXR1NXjymYr7PZr2H4abq
isxoHC+6gnRHTdIdegxwb2tm2fzL2Knaebhy124Q1YnkTuIzUoMrrtQ6uBvvrcO/
XaMtSzFcNgfBQOwACUI5jrsaGrJmU8LX1yV9JTDCFLHzhUpThz9YrIExA/i2TDdQ
nKahbC9jrLOe9w47peDU/Xq5kGujPa0LZ5CGv5MA20Xuhlo/aQDL7AKVMoNV77ND
ZeNhN5PLels7uR2S5LoIpvVQOfKd6Ju9FVUgifCZAXJCQDEPGRGLffF8/zMR44Sb
QjKKlj96pX3foqUPgKyMR2T93dg4nOu8irOY7SPMbH2gBEIoCns5o0vMv+0ugtGn
3sFTDcZL4LTFYPxWbbzn
=hmW5
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
