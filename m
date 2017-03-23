From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Thu, 23 Mar 2017 09:08:18 +0200
Message-ID: <b4666cd6-9925-6143-41c3-591e68c48456@ti.com>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
 <20170319012927.kmyqngprpip7le4m@earth> <20170319161030.GA20572@atomide.com>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
 <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c@ti.com>
 <20170323063109.qhwxj74pbfztgopt@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="WvjSVUhpbv6Ooa6iixwDRvGbN5fUncnKR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170323063109.qhwxj74pbfztgopt@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--WvjSVUhpbv6Ooa6iixwDRvGbN5fUncnKR
Content-Type: multipart/mixed; boundary="lAFFuphKTUL4P4neW7a2RsQOav0vUgivK";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>,
 Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Message-ID: <b4666cd6-9925-6143-41c3-591e68c48456-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
References: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170305054359.8293-7-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170319012927.kmyqngprpip7le4m@earth> <20170319161030.GA20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
 <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c-l0cyMroinI0@public.gmane.org>
 <20170323063109.qhwxj74pbfztgopt@earth>
In-Reply-To: <20170323063109.qhwxj74pbfztgopt@earth>

--lAFFuphKTUL4P4neW7a2RsQOav0vUgivK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/03/17 08:31, Sebastian Reichel wrote:

>> It shouldn't matter when omapdrm is initialized. omapdrm should wait
>> until it has all the displays.
>=20
> I tried to trace this. I assume, that your "should wait until it has
> all the displays" refers to the code in "omap_connect_dssdevs()".
> Unfortunately that code does not work correctly:

Indeed, sorry about the confusion. Apparently I was talking about TI's
kernel, which has fixes for this.

I have actually posted the patches, along with a lot of other stuff,
last Nov. See "[PATCH 00/36] drm/omap: miscallaneous improvements"
series. The patches 23-25 should fix this particular issue.

 Tomi


--lAFFuphKTUL4P4neW7a2RsQOav0vUgivK--

--WvjSVUhpbv6Ooa6iixwDRvGbN5fUncnKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY03RjAAoJEPo9qoy8lh71k9YP/ic5y4aySB5zkyuu3vGUOFYt
1nh3hYrE3XB8deRPvIzMayYrvVJhnBdk8DYXtXYXPK5JVssVqG0+9w/Oof3S1WOM
udmR/lw0GEO7AGysSTRN38hcYWj0vLwoBntPoPNWoDR7VxdkFvOSmPU99zLq11mQ
OfIj4rGMcQiRENvoKKEDjkf3BAyTdp2A+9EKsSA7fxUhttWCjbiiroMYg6V524Lo
UBUdjTO6ZJxNJvy687hxXscazdVYCch5r4R//1+lKJbKux6s7p5IEVqIJkufDN7Z
pgmUQN3Y1e3L93r3UFzXUUk2+q8uZXh8V6ibmriRnPJE0XnaoL7sBWa7lVDisJoP
4DEtpEKDaUBa6xrs8WYg3SrPmBkuzu5hhWHrbleLG7QP0NWMuBGRzPPf8w18MyRP
D5RqYtZrtU2MENggdUr8R/U2UQ1B6RGprLsVyF2u1JnkkFw0kwQpt0vJcY8c5Bie
5tjDBGm4Y81Pia1jzT8YvgWSrRxH8wqbU/3CYAxROPr8VfL1/bW9ECo5Y+tI1nUn
rojVAZRmhq/hTs6Qz1Z8p6suYgAkNtsSi6AFuRvnEU6NVxSNAd0Jb+5R9YVvof2J
I5VJiWUI/1ueli2riUhPXX9HPP8D/yhuWdZqLnRW06xAb+fVnpCVYaUePOroxq3s
cls+/vnzE/H7EijUYSJc
=+fiF
-----END PGP SIGNATURE-----

--WvjSVUhpbv6Ooa6iixwDRvGbN5fUncnKR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
