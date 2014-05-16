From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 16 May 2014 08:50:11 +0300
Message-ID: <5375A713.7030409@ti.com>
References: <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com> <20140509153008.GC17814@atomide.com> <20140513212639.GA18001@atomide.com> <53747DD5.2030406@ti.com> <20140515182548.GD23659@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OtEFf5Xf3D9RHhIriCehHQNKnwEOwHMxk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbaEPFuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 01:50:37 -0400
In-Reply-To: <20140515182548.GD23659@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--OtEFf5Xf3D9RHhIriCehHQNKnwEOwHMxk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/05/14 21:25, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 01:42]:
>> On 14/05/14 00:26, Tony Lindgren wrote:
>>
>>> +	/* lcd MO */
>>> +	ddata->mo_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
>>> +	if (PTR_ERR(ddata->mo_gpio) =3D=3D -EPROBE_DEFER)
>>> +		return -EPROBE_DEFER;
>>> +
>>> +	if (!IS_ERR(ddata->mo_gpio))
>>> +		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
>>> +			ddata->flags |=3D SHARP_LS_QVGA;
>>
>> Shouldn't there be an explicit flag in the DT data for this? If the
>> panel's MO pin is hardwired to, say, pull up, then the mode-gpios won'=
t
>> have MO gpio, right? So something like:
>>
>>
>> mode-gpios =3D <0					/* high, lcd MO */
>> 	      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
>> 	      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
>>
>> vga-mode;	/* MO hardwired high */
> =20
> Yeah holes there are just fine. I figured let's keep the custom
> vga-mode property out of the way until we actually run into a panel
> that's not using a GPIO for mode.

Ok, I'm fine with that, but in that case I think we have to use all the
panels in the same mode, i.e. the driver either sets the MO gpio always
low and uses VGA mode, or sets the MO always high and uses QVGA mode.

In your omap3-evm.dts patch, you set the MO gpio ACTIVE_LOW in order to
change the mode, even if it really should be ACTIVE_HIGH. But if you do
that, and we later add the support to the panel driver to manage the MO
gpio dynamically (i.e. the user can select VGA/QVGA at runtime), then
the panel won't work as the driver uses wrong polarity for the pin.

 Tomi



--OtEFf5Xf3D9RHhIriCehHQNKnwEOwHMxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdacTAAoJEPo9qoy8lh71AyEQAJHLsOGh2wbSls3E25AVclfi
GbruEh1sghk6v3Cri/rP5kEUiwyQqx3m50PK7kgwi4T3/46vxdtCaZs3F8rm4xd8
eyi9pgJnEEz8/vEDA+ur9mD6YBAbYG+zuD95LQv4cQb2fViLP4hgNUd03dQDcZfj
1dnyad29x30VqnqHfkXZD+tdo9IA+wOZehfAdG1ebquY4bCAgvD8/1jyhsxUEUdv
KO+JGl8BelpK34BI1vZB5NyXJp3mCMwpgf04wR5VYZLjj94AeA4X4CpqEOpCONtq
jmMN4wodvo3U0R1lO3wft6oi6FH7bZ1nlHqJdVkpsU+uszjJxsuICuzkhW+oQEeT
xcRNlZuPfb5Bxn4m4DiIZXtLTTuVUplBntMHvMpho2HG+tLWfBHE0GC2VcIVwXiZ
Xo/HBCDI1iygcbL03GNCE28M+bdgmbXKMicjEO+wHeD3Fngd4uz7oaBmVi/AlqtQ
C7QDrMOioSteLfSQbd4CbgiFmSroLD6fnoYldfAohitwbB9wuAomyxuAkOWlg4sZ
xEZzP2VtbhZgIU1lXFYpQovgTB+22kowDFWZsP9mm3eCAJ06Gf3u3OjWhgQJuF3k
CEq/3Y5fzJhT4J6KMQf2VMle+WnRWzkY4UrjwHHHZdl5sSg9NuQN0u0XCPQUfU0b
O9ofRR5bv4UwmbCdBxSi
=rkM+
-----END PGP SIGNATURE-----

--OtEFf5Xf3D9RHhIriCehHQNKnwEOwHMxk--
