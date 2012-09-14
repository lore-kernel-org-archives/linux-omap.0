From: "Maximilian Schwerin" <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Subject: USB problem on beagleboard clone
Date: Fri, 14 Sep 2012 14:26:25 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E2C8@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-Q0ZJr/P5Nwmm61Tt3b6g"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-Q0ZJr/P5Nwmm61Tt3b6g
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

we've designed two beagle board clones (two different layouts) for a =
customer. After quite some time without any problems they are now seeing =
USB problems on some of the boards. I have so far not been able to =
reproduce the problem...

The USB port of the OMAP the problems appear on is connected through a =
TPS65950 to a LAN9514 USB Hub + Ethernet Chip. Attached is the kernel =
output. I'm not even sure if this is related to our board, or if this =
might be a misbehaving device?!

If someone has an idea what this could be and what I could do to fix or =
at least further debug the problem please speak up.

Cheers and thanks,

Maximilian Schwerin.

_________________________________________________________________________=
_________________

=A0Maximilian Schwerin | maximilian.schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org

=A0Tigris Elektronik GmbH | Wikingerufer 7 | 10555 Berlin, Germany | =
http://www.tigris.de
=A0Tel: +49 (30) 301048-30 | Fax: +49 (30) 301048-59

=A0Gesch=E4ftsf=FChrer/CEO: Henry Westphal, Guido Kuhlmann
=A0Sitz der Gesellschaft/Company's registered office: Berlin
=A0Amtsgericht/Register: Berlin-Charlottenburg, HRB 71737

=A0PGP-Keys: mailto:pgp-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org
_________________________________________________________________________=
_________________

--=-Q0ZJr/P5Nwmm61Tt3b6g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBTIoAACgkQ6nqkzTWctv7bEACcCZidM/WwsM2gni2Vyz7M4EBW
3gQAoKXYmzauGGE5VuObcmiUcX6O3IZn
=FEm/
-----END PGP SIGNATURE-----

--=-Q0ZJr/P5Nwmm61Tt3b6g--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
