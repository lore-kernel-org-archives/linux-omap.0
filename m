From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Mon, 28 Apr 2014 13:43:57 +0300
Message-ID: <535E30ED.10903@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com> <20140418155107.GB5354@atomide.com> <5358DEEA.1000506@ti.com> <20140425235348.GH20807@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="t8imHDvSfoAr83HxPtWE4FSV2PhBWC3Sd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140425235348.GH20807-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--t8imHDvSfoAr83HxPtWE4FSV2PhBWC3Sd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/04/14 02:53, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [140424 02:53]:
>> On 18/04/14 18:51, Tony Lindgren wrote:
>>
>>>> +	gpio =3D of_get_gpio(node, 0);
>>>> +	if (gpio_is_valid(gpio) || gpio =3D=3D -ENOENT) {
>>>> +		ddata->enable_gpio =3D gpio;
>>>> +	} else {
>>>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
>>>> +		return gpio;
>>>> +	}
>>>
>>> We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
>>> gpio_backlight_probe_dt is doing.=20
>>
>> Instead of doing it with the old gpio API, and checking the 'active'
>> flag everywhere, I think we can use the new gpiod API which handles th=
e
>> polarity automatically.
>>
>> I attached prototype patches (based on -rc2) for panel dpi using that
>> approach. It's a bit messier than I'd like, because for non-DT boot we=

>> need to request the gpio using the old API, and then convert it to
>> gpio_desc. We can remove that code when all the boards use DT.
>>
>> I've compiled tested this only, as I don't have DPI panels I could use=
=2E
>> I did try similar approach for TFP410, and it seemed to work fine.
>=20
> Got these working by updating my test patch to use enable-gpios instead=

> of gpios, and had to change from GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH.
> Are we now also breaking legacy booting by reversing the polarity?

I don't think so. The GPIOs should be active-high by default, if I'm not
mistaken, so the polarities should be the same for legacy boot with or
without those patches. Of course, I don't have the boards so I have no
idea if the polarities have been correct even before.

debugfs/gpio shows the actual value of the gpio, so you could check from
there what it is.

> In any case, looks like we have some duplicate panel code.. Turns
> out most panel dpi users for omap3 board-*.c files are just
> sharp-ls037v7dw01 panels but configured in QVGA mode. At least for
> EVM and and LDP based on looking at the pictures and the configuration

Hmm, true, board-ldp.c's panel looks very much like sharp-ls037v7dw01.

Which EVM are you talking about?

> pins (using the names kernel):
>=20
> QVGA =3D lcd MO
> reset =3D lcd RESB
> ...
>=20
> Then the enable_gpio should be just a GPIO controlled 3.3V regulator
> in most cases. I suggest we move them over to ls037v7dw01 and allow
> configuring them both for VGA and QVGA depending on the orientation.

Looking at the panel spec, it has the following pins:

RESB - reset
MO - VGA/QVGA
UD - vertical scanning direction
LR - horizontal scanning direction
INI - power on control

And it needs 3.3V power.

Are you saying that on some boards the gpio used for enable_gpio is
actually used to switch on a 3.3V regulator?

> I guess you do have some device with ls037v7dw01 since you've been
> patching it?

No, I don't have any boards with that panel.

 Tomi



--t8imHDvSfoAr83HxPtWE4FSV2PhBWC3Sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTXjDxAAoJEPo9qoy8lh71K/0P/j45RpOfYpttQqnNAo8Ckrgq
I3LE9IYii2grpSxrA/JB/Ye2uOYsg2XkTnQW0rjHx2vTjCoxbwH/2RFKr2zrn21f
6FPNLJSkCpgRO8G2ZgtKwGgsMpriC3lgusltArslowewq/RXkVORIdbnGGLGtn9V
ZbsHo1luYRSMu6ik1/Fp+uHEtX9J9ujYp9gzkzIAhUhU5MqtNZ+bCTYfgXPxjbh4
de6Bq1NdgAALpLjS8tfSZo9v11hl6cvCdqG9BVrOvJYbl/3cpmN3nDYSm5K8x1Aj
VtnlFy9mEEWIPaiLxz510CGBKe7ZUF0HU7h/4aDtTF0BPqIKn1k/8eNU4wjebCdg
JuV9mCGVpC6M9iOzRFo04ElsyshPd5LmQRZ/tMXoUPrCuMnJt/tV3LFsimzwfl5G
Vjxah/LkllFbC1VYpWZyrkZGSYeugsT4onc9tBML6tYo4pXVGzY7I6ll3kcLuiub
ymA+fKT+beh+/AoI8zRqzNF4esDKiLUi+CDMUlqGsGTkgLFv8w1sbNXVZk+LU33q
JoMSbgg1VYlBPSFCLoteHN6qypSzo4NEEHMQyLhzgdoBrdSWC71xl9b3Qblo7rXI
G9QsedhAPEzFLfSOOIe2IFJxO8JLizsmfgvMgevs9y99/HY7oyh+ReLJWKk2c0YR
okoYrJUBXAYgBBYcIxSB
=L5fc
-----END PGP SIGNATURE-----

--t8imHDvSfoAr83HxPtWE4FSV2PhBWC3Sd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
