From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in plat
 data
Date: Fri, 14 Jun 2013 11:17:05 +0300
Message-ID: <51BAD181.3020902@ti.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com> <51A43E0A.8090201@ti.com> <51B9C3B6.1080707@ti.com> <51BAABB0.5060107@ti.com> <20130614054720.GL8164@atomide.com> <51BAB9EA.5090805@ti.com> <20130614073314.GA20992@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2HNHPTJIVANKBMVEBWGEE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130614073314.GA20992-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

------enig2HNHPTJIVANKBMVEBWGEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/06/13 10:33, Tony Lindgren wrote:

> If we want to fix something this late in the merge window, the patches
> must have a clear description what caused the regression and what happe=
ns
> without the patches. These patches don't have that. And they are marked=

> RFC also. So actually I'm not applying any of them before the regressio=
n
> descriptions are there and the patches have been reposted without RFC
> and have sufficient acks from people.

No disagreement there.

Kishon, I tested the patches on top of v3.10-rc5, booting with nfs root
via usb gadget eth:

Overo: works
Beagle: works, but I need to reconnect the usb cable after kernel is up
Beagle-xm: doesn't work. The cable is detected correctly, though
Panda: works

The problems with Beagles are there even without these patches, so they
do make things better (fix Overo).

 Tomi



------enig2HNHPTJIVANKBMVEBWGEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRutGBAAoJEPo9qoy8lh710rIQAJH7MGB/33pOFZXA+xWhWZiI
u2EBcMjobB6R5PSvuQVZtE39fPDf8Z+p0D2E+2/FKTS4uzrFFVmXw2NgVSfcO/Ny
GFWTlgls8K9j/BZJ0AaM9YywDUthc/xrb946YHCORKkPH9AaqIJWlqHQIDWx20Cb
dK6bKmqbuCtq+ci9IV8rBfOpbV3N7PzyajNyZxLhsc+6qVrWkjnLYB8skuP2KaGE
71V3Tghvgtw+ZlENQXE1+/VO54XNNljuzQ7nOfhflHDBg0phwEd5DiHFlBa+9c6B
wh9/8kC7iMiMCMTMWLEbHZFw8wroh57PckFjOvbRgH78BqNSaaKMFvAwppjoCFn8
Ih6D1JfuT8h7tue7mMzEhirabXqmEj1XNGYjT8bMSqAHDkviE+VjrqG3mm06PBCk
sdSvvZjw+ZJeVKEtx8JFXTDMDGuMZQ7T+gC4wg+Vzl1J5XQy0vU3EmqENRS3bDLK
JzfUBPrCMfEqimrIc4DXnXcSRpPMsw4ajTPBHwuhGh29TXi+awDJl7yxi5gpUZDJ
S55j5vixv+36E6U3PCHpeHlaYsFXbgKoaogrd/Z54xswejRe1e1RY0S7nucWK+6d
NlQnbplCoNwG51G8lbsSbDJQhqypDkTCHP932vOV56TtXCYAbO9opaVgSDLqb3FA
4wzlDDJNUsEOn8EFKUG/
=sJcQ
-----END PGP SIGNATURE-----

------enig2HNHPTJIVANKBMVEBWGEE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
