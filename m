From: Felipe Balbi <balbi@ti.com>
Subject: Re: omap_device prints
Date: Thu, 21 Jul 2011 12:58:34 +0300
Message-ID: <20110721095833.GQ23253@legolas.emea.dhcp.ti.com>
References: <20110721095109.GC28942@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aX6oBa4COn3eIhlv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:52292 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720Ab1GUJ6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 05:58:39 -0400
Received: by ewy4 with SMTP id 4so1626742ewy.33
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 02:58:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110721095109.GC28942@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--aX6oBa4COn3eIhlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 10:51:09AM +0100, Russell King - ARM Linux wrote:
> I spotted this while booting the OMAP4430 SDP:
>=20
> omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035
>=20
> and found that it came from here:
>=20
>         pr_debug("omap_device: %s: activating\n", od->pdev.name);
>=20
>                 pr_debug("omap_device: %s: pm_lat %d: activate: elapsed t=
ime "
>                          "%llu nsec\n", od->pdev.name, od->pm_lat_level,
>                          act_lat);
>=20
>                                 pr_warning("omap_device: %s.%d: new worst=
 case "
>                                            "activate latency %d: %llu\n",
>                                            od->pdev.name, od->pdev.id,
>                                            od->pm_lat_level, act_lat);
>                                 pr_warning("omap_device: %s.%d: activate "
>                                            "latency %d higher than exptec=
ted. "
>                                            "(%llu > %d)\n",
>                                            od->pdev.name, od->pdev.id,
>                                            od->pm_lat_level, act_lat,
>                                            odpl->activate_lat);
>=20
> Is there something wrong with dev_name(&od->pdev.dev) so that we have
> consistent naming of devices, rather than poking about inside the
> platform_device accessing the name initializers directly ?

or dev_*() macros, instead ?

dev_dbg(&od->pdev.dev, "activating\n");

--=20
balbi

--aX6oBa4COn3eIhlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJ/hJAAoJEAv8Txj19kN1oXcH/Rmnji/R/KZ/2n89Tl3h/F8Q
CFpCv1jh2fK3lkfUNu8x49Nx0iKrDuj9hwn9875jhusGI/Ttdh9dYGwvZctr56GI
uSilQarGS9hf/7h05ba5CmYBLGxxp4geIfPsy4YDPs4aoDlnte5famxl2sCGsUY1
1jMUosU1dIWO59zFjW4ynN50WvqlcSAwzuj+rmMEK1BH+t55PX1bWnbBPCoWbSE0
+MXX3Pm8rgzDiWmpmlqnWSEq+2sCHSxEN7rUOBrrdKan+6Fn6RnRzhkY99EJTGm7
v7LEZ4dBRoOg70lh2GMH5bgvrIHgnAbJ6BC1ReoxJklCLv7NDVCAm3/Zul4F2Wc=
=+9fU
-----END PGP SIGNATURE-----

--aX6oBa4COn3eIhlv--
