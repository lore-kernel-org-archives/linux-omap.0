From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS: DPI: disable vt-switch on suspend/resume.
Date: Wed, 25 Feb 2015 12:03:36 +0200
Message-ID: <54ED9DF8.8030105@ti.com>
References: <20150225203708.0eb2fa96@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="218FneOctmcdOI37OVu0GfBUDHV9FjKr9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225203708.0eb2fa96@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

--218FneOctmcdOI37OVu0GfBUDHV9FjKr9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/02/15 11:37, NeilBrown wrote:
>=20
> These devices do not need to return to non-graphic console
> for suspend, so disable that option.
> This means there is less work to do in the suspend/resume cycle,
> making it smoother and cheaper.
>=20
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> --
> Hi Tomi,
>  I wonder if you would consider this patch too.  It works for me and
> removes pointless vt switching.  I assume no-one would need or want tha=
t
> switching on suspend/resume but I guess I cannot be certain.
>=20
> Maybe a module-parameter could be used if there was any uncertainty.

I was just yesterday picking patches from TI's kernel on top of
mainline, and there's a similar one for omapfb and for omapdrm. Here's
for omapfb:

http://git.ti.com/android-sdk/kernel-video/commit/5915d8744c927307987b12b=
14bc6aa37b3bac05c?format=3Dpatch

The patch in TI's kernel claims it's needed to make resume work. You're
saying it just optimizes suspend/resume. I hadn't picked this up
earlier, because I didn't understand why pm_set_vt_switch() would be
needed to make resume work. And never had time to study it, so I still
don't know what it's about...

Looking at the drivers/tty/vt/vt_ioctl.c, it sounds to me that we should
always do pm_set_vt_switch(0), as omapdss restores everything just fine
on resume. Although it makes me wonder how it works if there are two
display controllers, one needing the switch and the other not...

Your patch does the call in a bit odd place, so I'll be queuing the
patches for omapfb and omapdrm. Or actually, maybe the call could be
done in one place in omapdss driver, as you do, but in omap_dsshw_probe()=
=2E

 Tomi



--218FneOctmcdOI37OVu0GfBUDHV9FjKr9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7Z34AAoJEPo9qoy8lh71O40P/2fV8fVL0GlWMoToM07phck+
XT7WjYmG9zwVQXBnkdrzpYQAusS1Ladr17GMZvXFikX7FQkG3y9ojtVhFdnwBKq4
io4+XpzR9gZAPe8D7GZl2M16wtty9SBlNnz9neczxn4K2PQmM/dfdDUqtcxw9hNz
hHgszjuxWovhAq/fC4md6PL56sCGJ3Y5UTYtwZK6HkfdC8CmfBagR+B585YNeDKG
W/sG/+lrsR/yTeK2P+CoYyH2N/29FdVmk71Q9XMdXq40h6/RmWtYMhsagD/VWjeC
OdCkyCVO1RWx1y5IeeVlFnVH/guDCHTmhILSolHke21pG3gC8AkhYMC+SobJC09y
UDbbfETX9jGm4MwAveMGjJ5xQi8jH9u+wMOx+6LzDj3dpGzBmOKZvkVCTeZa+gDa
XTINxXmCfUMxbR+16NxBzweBXOg6YCeAcANgu4CPbXoAINz37oxDS43M9DYYTIRs
lFpNOVe/iX42HeftsJu80N18xGI5MOu6nMc0OBIr+HY4wegluAZm0XefGf//ycvK
qrDLn/ez6A2UUssUyobUZrwFetYrHBZ2EBj5cs4T4qBh0nGBXFFGLPesRxRnK7FF
RnGE27tyZZbsHdQipgazezYiy47u13mRGGZraTOXdQHJp6XfdLWJUzW8As0KaUWh
7tqG7uUwIHLH/o7kMDTe
=2xqh
-----END PGP SIGNATURE-----

--218FneOctmcdOI37OVu0GfBUDHV9FjKr9--
