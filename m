From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 2/3] OMAP4: Keyboard Board Support
Date: Thu, 15 Apr 2010 17:59:04 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DA67660@dlee03.ent.ti.com>
References: <Acrbb1c3f6VIFUq3RumCrtM3k0PWuQ==>
 <27F9C60D11D683428E133F85D2BB4A53043D9EE7F6@dlee03.ent.ti.com>
 <s2xce9ab5791004132219q528e6c7cyb709d78f8dc177ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45841 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab0DOW7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 18:59:07 -0400
In-Reply-To: <s2xce9ab5791004132219q528e6c7cyb709d78f8dc177ee@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks Vimal,

> > Signed-off-by: Abraham Arce <x0066660@ti.com>
> > ---
>=20
> 'Form: Syed Rafiuddin', but not 'Signed-off-by:'... is it correct?

Yes, it is missing, added it in 02 && 03 patches...

<snip>

> >
> > - =A0 =A0 =A0 KEY(7, 0, KEY_UNKNOWN),
> > + =A0 =A0 =A0 KEY(7, 0, KEY_LEFTSHIFT),
> > =A0 =A0 =A0 =A0KEY(7, 1, KEY_ENTER),
> > =A0 =A0 =A0 =A0KEY(7, 2, KEY_CAPSLOCK),
> > =A0 =A0 =A0 =A0KEY(7, 3, KEY_SPACE),
> > @@ -119,31 +116,23 @@ static int omap_keymap[] =3D {
> > =A0 =A0 =A0 =A00,
> > =A0};
>=20
> Are you aware of that interpretation of 'row' and 'col' get reversed
> in matrix keymap framework.

I forgot, changed now...

> Also last element '0' should be removed.
>=20

Removed...

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
