From: Alan Ott <alan@signal11.us>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Thu, 21 Apr 2011 21:10:38 -0400
Message-ID: <4DB0D58E.4030508@signal11.us>
References: <20110411093214.GA18215@rainbow> <4DA3350E.2060400@gmail.com> <BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com> <112ef82aebc719ef25cde126f2014ebc@mail.gmail.com> <20110412040420.GB25239@rainbow> <bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF99B7D0629AC0D232F4FA9B1"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Steve Sakoman <sakoman@gmail.com>, Steve Calfee <stevecalfee@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF99B7D0629AC0D232F4FA9B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/12/2011 12:20 PM, Keshava Munegowda wrote:
>> Ah, so EHCI/OHCI common code was moved into drivers/mfd... Good.
>> But seems regulators support was lost somewhere during transition - th=
e
>> only mentioning about regulators in omap-usb-host.c is "#include" :
>>
>> mad@macmini:~/kernel-hack/linux-2.6(master)$ grep -i regulator
> drivers/mfd/omap-usb-host.c
> Thanks ! I will add some time next week!

I have confirmed this on my BeagleBoard-xM. 2.6.38 works, but the
2.6.39-rc4+ head from yesterday did not. It seems that the regulator
does not turn the power on for the USB hub which the ethernet is
attached to.

I connected this issue to bug 33092 in bugzilla[1].

Alan.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D33092


--------------enigF99B7D0629AC0D232F4FA9B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJNsNWOAAoJEFZEOVT5235i0EQH/0qbMsJAw7TEM0g+QbnZhfHd
jWykJ/rreihk8HiERHbygawgmy+z+j6Uiw9QuWlclXQDEinZvv76dUQFGD2Zh+0J
Puv7/BEj7VNvjwBwZvOaDXZuQUjv2SB7bScWPDnMqogaXADd2541pTQpdbqSP3zR
w3C6ULq5OJI89Vc7l90FJpcJBm+4xh5MRyUB9IsWxz2iekYpmKlfnesn6OzOk2v2
AoBPCS9KhTzCmhLLgUliyovpcHujIUA6fJ7g/Tjzs18VPFjjVQl6Ul1111AjDaUJ
y/6COTIE47q6vVULjwVHl5vSSUrXo32K+MsX+ku5JqeUFsM3xkAngIms0CtsjR4=
=LZoa
-----END PGP SIGNATURE-----

--------------enigF99B7D0629AC0D232F4FA9B1--
