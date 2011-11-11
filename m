From: Felipe Balbi <balbi@ti.com>
Subject: Help with clk API
Date: Fri, 11 Nov 2011 13:32:00 +0200
Message-ID: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35369 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578Ab1KKLcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 06:32:07 -0500
Received: by faan15 with SMTP id n15so4619027faa.40
        for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 03:32:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I have a doubt about using clk API to change CLKSEL_UTMI_P1 bit for a
silicon errata (OMAP4460 i693) implementation.

According to errata, I need to switch from external to internal clock
during USB port suspend, wait 1ms and switch back from internal to
external.

How can I do that with clk API ? Is it by changing clk parent ? Any tips
would be helpful ;-) thanks

--=20
balbi

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOvQevAAoJEIaOsuA1yqREjmMP/3WAlpBNTyRhmw+BjysMGM5+
ESa4BdtO99FDF/KESyLu6CvG4QmLzy1vrbYzspORHJmoSEOLvnTWDLqpq1VaYRd1
Pk7GqkwMyAOAUZrB7rfNMMXXh4OgsLgHDixqFh/2ZGcrgdsntYGW86H1lIEZ6baE
7/POba4NfLPXHfJG/Y02Ewv/NtLXgCHWkpDXuHb9Ay9VofIPN5bQwSCEbEb4ViUA
Fv0ibzwGqBzqVPjAlTvUu+l9hUaHH3a83Q/F/RszZEPR4l8nyrWh9PbrkN99boEw
YBFhqAIknTz1p3LTQl3CLwcfCaF4aR465ALmMSgrIc+q3Phavv95T/SYubHYJOuj
nlJJGLcI9ImIvwI4BE3QX6pGXsDDbGKM8eO0dwJJvHylIqRdhJ/Zg88SyMTcT1kl
BSKpIIxzoFyM+kHX/21RRruK3bzJxKJCPdzpedJAnkmczqUcu45EqQVQQ3+Fjj3l
xz3Q2drPzvL5HHVxLBnx+gW2L2ETAzMFRC6h0wYq516RQtxL90u+6DH+msWRxfVn
a94x+U8LCFcoiEI0FbJ83+yLiDO7arklITA/6OlQuqNCt3oJTsaxYdQCtni3x5JB
fgjLRfsOVb7JLj5Xsu/UrZKuSzzfF4NV6zX+CVpSlJu5zwEUvNx62pcZpSC4d2Cp
G2HgBDebn25MiN60Q+aS
=S3eu
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--
