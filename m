From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/14] OMAPDSS: DSI: simplify dsi configuration
Date: Wed, 20 Mar 2013 13:44:47 +0200
Message-ID: <5149A12F.2050101@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com> <1362743569-10289-4-git-send-email-tomi.valkeinen@ti.com> <51499C73.3060802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EC2ECED6B419F2C6A283B20"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40067 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab3CTLou (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 07:44:50 -0400
In-Reply-To: <51499C73.3060802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig7EC2ECED6B419F2C6A283B20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-20 13:24, Archit Taneja wrote:
> On Friday 08 March 2013 05:22 PM, Tomi Valkeinen wrote:
>> We have a bunch of dsi functions that are used to do the basic
>> configuration for DSI. To simplify things, and to make sure we have al=
l
>> the necessary information, create a single dsi config function, which
>> does the basic configuration.
>=20
> I had split these funcs in the manner so that they could be converted
> into generic output ops or something equivalent to what we anticipated
> CDF to represent encoders. Hence, we may have to split this into smalle=
r
> funcs again later :p

Well, it was from the CDF discussions that this change arose. Everybody
wanted a simpler way than n+1 functions.

And I think it makes sense. It makes it possible to manage the
configuration as one "whole", instead of small bits that may have
interdependencies. E.g the size of the output affects video mode
calculations, so one had to make the calls in certain order. Now we have
all the needed information in one piece.

We could, perhaps, have common parts between different video busses, but
I'm not sure if configuration is one of those common parts.

> Also, set_size and set_timings were 2 different ops for command and
> video mode panels respectively. omapdss_dsi_set_size() also came in use=

> when we supported rotation in Taal. We have an equivalent func for rfbi=
=2E

Yep. I felt it's a bit confusing, so I just combined them. Even for
command mode some timing information is good (well, pixel clock), to
calculate proper DSI bus speed.

I think this also works in case of panel rotation. From DSS's point of
view (and that's what we're talking about when setting the timings)
there's no rotation. It's the panel's internal thing.

 Tomi



--------------enig7EC2ECED6B419F2C6A283B20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSaEvAAoJEPo9qoy8lh718c4P/2vpBNVX4bLiUCKUauphB8Fq
O3kBIsQNjbATjVWrAqb8OOcQTqDvYMTacDxXJmaanO59jt/nyJZUQUG7gM0Zn+VK
p4Fx+0rF7dRYlNNkESIlPPPLdf+1jioO1xIm4BsdwE/9zLvrh5pxDrNeDdQp7zMr
p67Qs/i8B0YhcDZTezVdGTN8ehpwP4KJccycGlbk7Iuro9WIK751rRzGZL8UBuWi
8wpoMgEkvjsLzqSSLDYglAlBU8Gf9oqKoRKG6QPmirZoxuZHsgymtIPZTPOmgrYJ
aSNlEa/VZVoeyF9zfq5PBK+c+I3JQHmOq0ttsVYbUKPuxbrHp22ZhZjy+ZgGp4z3
tUbwUgFKXLyZ+0erjtCO/MOnZKysVZNA/vUB4MSLLHqxuC2qQy/KXOqosvenEo6k
83/dedQaFv68TA7Y1/gpTJ9N+vSxURjqW+8swvCPpyfv5COuSb8FZ7vSevDmJNAC
lBgxOOWHCHkyVEpFNSmVSN5rKO9BE6RjnbW9W2Dm4pQbrQXfvqQcbwWOZqDLSFSa
72NS7NUDb/VuzE9REuFHRcfpGrpzhKhNyyC4mZMI4LnhXBlw6kffTSrOutntK57I
ijHmR3YBgD/1vbKHyAusisghFW7XkQWBDvblHyz4urAJGET2R7z2he0uDlFJdSqD
HKeyLeYOR8SBb6l898kj
=dlDW
-----END PGP SIGNATURE-----

--------------enig7EC2ECED6B419F2C6A283B20--
