From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 08/14] usb: otg: add OTG/dual-role core
Date: Fri, 10 Jun 2016 14:02:36 +0300
Message-ID: <87ziqt5msz.fsf@linux.intel.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com> <1465376626-30122-9-git-send-email-rogerq@ti.com> <57592060.6060801@ti.com> <2522343c-422f-79e1-af40-eb953bde42f6@cogentembedded.com> <575A9430.6070508@ti.com> <a559997c-2107-1850-1b22-c4532350d665@cogentembedded.com> <575A9C7C.7020902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575A9C7C.7020902-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> What is wrong with calling it gadget controller?
>>=20
>>    It's not a controller, it's a piece of software AFAIU. Or is my Engli=
sh just too weak? :-)
>
> Everything at this point is a piece of software :).
>
> struct usb_gadget, represents the gadget controller device not the
> driver (or software).
>
> struct usb_gadget_driver represents the gadget function driver.
> struct usb_gadget_ops represents the UDC driver ops.

right, and usb_udc was added just to have a way of linking usb_gadget
with usb_gadget_driver so we could have more than one peripheral port in
a system.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWp5MAAoJEIaOsuA1yqRETMgQAJwNmqvZ2Sdy7ofvMXesTjDP
BWi9467w5ZBX6pEUcr26YVDIpAvAzEtacP3jk9K6I/4HcunIfOsjGLUP4JU8cOoV
GdLRUrKRn4j8BZMNmQ5bizbIj3VzwS7SdDKnhTbYyaEhdFNp/NIHAqyoeNJDyMqm
tQt1xOU45OwA+C0uPw2lpsrja2TBcmwuOsNAthR8jWahf0z4bMDjJjZOFJ+oTqE7
2GAo5v1bxN36Hg2RZ35jdXgAPa9zKNYQQOXjj8/8gghT8YV+M4gDaRn/smcp3UJd
CRRZ2TcSbBCzGlSigcunfOynct7io7DBh9s8HAahgfMUxyfcewN8zWhpnWqG6s3w
QihcFwOQLx5zBfK0HLQd0QF7B4N9Q0gc95fXS2nzEoaVyOETKcb7s/UkvGUPAfrw
ukPWaWJVyrzf/VDivv84tSPel8NNaz7x6+PFuWwdApZsjSRWzBcHKj0c09TXFaT7
W2wPIweM1YvloB+NOA/phYsN2dSFwcvD3XaLzVDSGunUcTYSaj0eoPF68CASfHPP
JXyu4V9IGDMpRlLsS9wrNZc4dCbeHMrSzkC21scEpQzL+khg5ZCguTr5AAZsJqUq
iLw2tDS0tDmklFpgxFD3vP3XSLnvYADOh8kCq/oDilDD3+iRA2jWHBOT0w9ldTAO
Jf5RL0OGc9pPG5gYWmae
=rNro
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
