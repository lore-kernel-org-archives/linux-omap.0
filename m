From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/25] OMAPDSS: create custom pdevs for DSS omap_devices
Date: Fri, 04 May 2012 12:00:06 +0300
Message-ID: <1336122006.2701.19.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <1336053481-25433-12-git-send-email-tomi.valkeinen@ti.com>
	 <4FA39091.8010007@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HZpuBy07sl+6HhvG9iM9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:53613 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061Ab2EDJAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 05:00:12 -0400
Received: by lahj13 with SMTP id j13so1852458lah.19
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 02:00:08 -0700 (PDT)
In-Reply-To: <4FA39091.8010007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-HZpuBy07sl+6HhvG9iM9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 13:47 +0530, Archit Taneja wrote:
> On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:

> > @@ -221,22 +279,24 @@ int __init omap_display_init(struct omap_dss_boar=
d_info *board_data)
> >   		oh_count =3D ARRAY_SIZE(omap4_dss_hwmod_data);
> >   	}
> >
> > -	for (i =3D 0; i<  oh_count; i++) {
> > -		oh =3D omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
> > -		if (!oh) {
> > -			pr_err("Could not look up %s\n",
> > -				curr_dss_hwmod[i].oh_name);
> > -			return -ENODEV;
> > -		}
> > +	dss_pdev =3D NULL;
> >
> > -		pdev =3D omap_device_build(curr_dss_hwmod[i].dev_name,
> > -				curr_dss_hwmod[i].id, oh,
> > +	for (i =3D 0; i<  oh_count; i++) {
> > +		pdev =3D create_dss_pdev(curr_dss_hwmod[i].dev_name,
> > +				curr_dss_hwmod[i].id,
> > +				curr_dss_hwmod[i].oh_name,
> >   				NULL, 0,
> > -				NULL, 0, 0);
> > +				dss_pdev);
> > +
> > +		if (IS_ERR(pdev)) {
> > +			pr_err("Could not build omap_device for %s\n",
> > +					curr_dss_hwmod[i].oh_name);
> > +
> > +			return PTR_ERR(pdev);
> > +		}
> >
> > -		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
> > -				curr_dss_hwmod[i].oh_name))
> > -			return -ENODEV;
> > +		if (i =3D=3D 0)
> > +			dss_pdev =3D pdev;
>=20
> The above line is a bit tricky to understand, maybe something like this=
=20
> may explain the parent-child setting better:
>=20
> 		if (!strcmp(curr_dss_hwmod[i].oh_name, "dss_core"))
> 			dss_pdev =3D pdev;

I agree that it's a bit confusing. But your suggestion is not very good
either, as the code does not work properly if the dss_core is not the
first one created. I'll look into it. Perhaps I can separate the code
into a small function, and then I can more easily do something like:

dss_pdev =3D create_the_device();

for () {
	// create the rest of the devices
	create_the_device();
}

and that would clarify what's going on.

> I had another general question about the parent-child series. What is=20
> the use of the platform device omap_display_device (with the name=20
> "omapdss"). Is it just a way to get the board data?

Originally, before hwmods, we had only omapdss device, which contained
all the dss code. Then came hwmods, and the omapdss was split into
smaller devices, but omapdss was still there.

As I see it, omapdss is currently a "virtual" higher level device
(virtual in the sense that it doesn't correspond directly to any HW),
and the code for omapdss is more or less in the core.c file. It's used
to pass the board data, but also has some generic dss stuff that all dss
subdevices can use.

I think in the long run we should remove omapdss device, and probably
handle the generic stuff in dss_core (dss.c), which, as a parent to
other subdevices, should fit fine for the role.

For the time being we can't remove it. It's the only simple way to pass
callbacks from the arch code with device tree.

 Tomi


--=-HZpuBy07sl+6HhvG9iM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo5qWAAoJEPo9qoy8lh71lD0P/0KJ+5BfRRPoATcmRT2tPJ54
BHN8qk4FPaPFJ6SQ7wkHJBfjmpjCpZEV6+pF+gAzkPAPlKMLwX/LKpekl/VlYfnK
Byoces47TyCFBbS0HMlc05KsRuxClwTLtD0j1WKGzLaT/9+y3U01RY2IMwsdWhtX
7mS4/0nYxmWai/Dms0LHbwm6aiFxXIRelIJ15iN9LhrE0hQHXyFKlY3BqFw9XCDY
fOuc2zpB1hs9yjMYHU0Eo32mChbvOdlrhvBWuEcoF88DLAlN5rHldRmjmjPPk80p
Yuz61tdGqr/Nh6USVte/7Zjv/0B9B/FaHVSmEpc+0OZu4B+UYZW3+NtQOC9bpB7o
sFLz70TkJFVXhqk9Iqi4wnVzfnFTLdeXJdEhBmPLiNu6Jl7WRUHnS95UzVm8n4hC
9D2M3qrzEMeHzmRXHX51eZPf+Qi0IfqopFCesPCfp/JeTl99/fQcLmIm9DYNP1pd
Y83kwPfO0ww/PbW47/tyMumSvHDXPz08fu9pewF1/fU1c3jYINIBGoo+9toaaOJs
dnkp5wUDLXbuijHFqUz1kjMUuwjnb8zYXDnJ+G7gNdSV5h0YgmBZ4eagJm55ZRV6
03Bb9ICIDrrxRH+1LiS7tTNoir/JAapp9ta2VDXWDQ3SQVFSyy0rUF7gOF9ApTtg
wbrbbPQsCZ3GhIXkUK5k
=krrB
-----END PGP SIGNATURE-----

--=-HZpuBy07sl+6HhvG9iM9--

