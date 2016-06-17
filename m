From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 00/14] USB OTG/dual-role framework
Date: Fri, 17 Jun 2016 10:17:51 +0300
Message-ID: <87a8ikz3kw.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <5762887A.4060606@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5762887A.4060606-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Roger,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>> This series centralizes OTG/Dual-role functionality in the kernel.
>> As of now I've got Dual-role functionality working pretty reliably on
>> dra7-evm and am437x-gp-evm.
>
> Do you have any comments on this series? If yes I can include them
> before sending v11 with Acks from Peter and Alan. Thanks.

I'll need some more time to look at this, have been real busy with some
internal tasks. Frankly, though, I still think this is way more complex
than what it needs to be and that's actually quite scary IMO.

I'll try to dedicate some time today to review these patches, hopefully
I'll find a few minutes. I know that I also owe you a look at the IRQ
cleanup for dwc3, I'll see if I can get to that as well.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXY6QfAAoJEIaOsuA1yqREDzsP/20f0zzThBcB2ybCkG7naERd
JLkqKUTB8u0tZh3l41z1kSU/Wk/r/BlRealmw6bszuTDLMGWV0MTEqSxHLwmGPhq
ZtDBYSlhmh5o0HxNPEWzOhQ3YucifJFh5y1ksQY2UekbBaJXOK8eCgOSFSZthyvL
dGyDKZD+wYZqdr7h30W6g0OH9kqA55rlGlCJrLUYFp/uWVnGkGsBybEdU1bW8/R3
bs3ViPP0vp6k/BHZ+kxGo+hFjNbek7ZCbthBoqIu9I/7ICfIxJ36+7xP/yshX+oZ
99z1qjI/+/vUcq4dwXdWEQ0cAmP4LzmW3LGHqJTmKlEY2+OBaqYyyouVI4vi3n3Z
Ypi3THYhqE0X5TNjrBmnUbcxIeVndNc2I9LxQPXnlsATC5l7aiPMNGX0RqSbEWh2
05Zy1+RxcaF1l9Ola66s4ULLBmaweyxwKiwrlLpZ6hyoodUqTcrD4dL79wmM3SIN
ZWcwEadQWPfCVmqkcSpMRU1sMS5q1k71cBFnh6TMnPdSMmWQqChj+sM3VLluTe9B
qHs/3GCtghupGXMAGhb0ApP3z/JoPwnQ6ipKQT+Kiy3Sf01Z20UFAlIjyMrsEM83
vuuZYSTWQNHUJCjavCX7u5vrmaqFtXjFsOltU0o6pgAnPKkiOwjiRh3Ab3/rKeLe
Hntd/qGGRyaslc7UQ/pI
=yAGy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
