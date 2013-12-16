From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Mon, 16 Dec 2013 12:49:03 +0200
Message-ID: <52AEDA9F.2020609@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <2364383.8GWpsWSoJu@avalon> <52A9760A.3000801@ti.com> <14299863.f0rzOyPfdL@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="x4f8H0SFmJbh3XrFVwTb5coGIuOSDQfaL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab3LPKtJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 05:49:09 -0500
In-Reply-To: <14299863.f0rzOyPfdL@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

--x4f8H0SFmJbh3XrFVwTb5coGIuOSDQfaL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 05:24, Laurent Pinchart wrote:

>> Then DPI, which I think is mostly just level shifters. It's really jus=
t
>> a port, as you say.
>>
>> SDI is a bit unclear to me. The registers for it are in the dss_core.
>> There's only a few registers, but it does have a PHY and a PLL. But I
>> guess it's also more of a port than a separate module.
>=20
> After a quick look at the documentation I would say so. I would be temp=
ted to=20
> consider RFBI as part of the DSS core, but that's less clear.

I had a look at this, mainly the DPI side so far. There's one extra
complication, which actually affects all other outputs also (and CDF):
pinctrl.

In the current series, I just have pinctrl for each device, with
"default" name, which ends up being used by default without any code on
my part.

However, if DPI is no longer a device, it can't have pinctrl entry. But
this is a wider issue, as the pinctrl should really be per endpoint, not
per device. When an endpoint is selected to be used, a particular
pinmuxing should be taken into use.

I'm not sure what would be the cleanest solution to this. I currently
have this working:

&dss {
	pinctrl-names =3D "default-0-0";
	pinctrl-0 =3D <&dss_dpi_pins>;

	port@0 {
		dpi_out: endpoint {
			remote-endpoint =3D <&tfp410_in>;
			data-lines =3D <24>;
		};
	};
};

So here I have 'port@0' for DSS, which is the DPI output, and it has a
single endpoint. For DSS device, I have pinctrl data.

When the DPI endpoint is initialized, the code looks for pinctrl with
name "default-<portnum>-<endpointnum>". As the DPI is port 0, and just
one endpoint, the code looks for "default-0-0".

For omap3 board with both DPI and SDI as options (they can't be used at
the same time, though), I imagine it'd be like:

&dss {
	vdds_dsi-supply =3D <&vpll2>;
	vdds_sdi-supply =3D <&vpll2>;

	pinctrl-names =3D "default-0-0", "default-1-0";
	pinctrl-0 =3D <&dss_dpi_pins>;
	pinctrl-1 =3D <&dss_sdi_pins>;

	ports {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		port@0 {
			reg =3D <0>;
			dpi_out: endpoint {
			};
		};

		port@1 {
			reg =3D <1>;
			sdi_out: endpoint {
			};
		};
	};
};

Any thoughts?

Every time I work with ports/endpoints, I feel that this is needlessly
complex. But I have never come up with any cleaner or simpler way to
handle this.

I also think this multiple-peripherals-per-single-port is not really
display related, although, for some reason, it seems like display is the
most abused hardware. Maybe ports/endpoints or similar should be in the
common driver framework?

 Tomi



--x4f8H0SFmJbh3XrFVwTb5coGIuOSDQfaL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSrtqfAAoJEPo9qoy8lh71mCAP/1XA7pI5oHDUdHOrapA+pKgV
FV7T2lcZ35wxO6w6euWD+95XDhenRWhsKIdVnrTmeB/vzXDlg94xIaaLRMn6APlD
kGlZkKS2ox0IEXDhfkxA6mTNCdJeDMExaA5LLLZfFQNZQ5HwMWxYJb4J7tCkRbvF
VGv7azDfMsE9K5h5K6PQoki89Dn8CTb0og4rDA4nJMGng9VwilM1xksdTJ2X9nB4
cH2ad3eCIY+JrG6wMbRMTFF7j/ujFr6lov5Of56cUICWWwK8ALBk3gikrvPtGaiW
Nauuyu8P9/v12VMob/BZmBAVKQZd9+aUCv198DsjLS+jb545kQseZrOrmYN6eXIg
GCU7lMODF/DNzUHAmIPwcRYhGigmS82sR65sieu3LdVqyHX7u+dt4Uem7GU3h91l
TCS7/SkJK71e6Yb8d38YvOf1dJvCtDiTKNleDolnHPfXBRhVk/AXz25t6XHMRt3f
YS2Y1Me8eToHtoh3M/tTFJNebWOj5eTRo8oQydZxozHCWC00RTSZlBgK1j/kJLbN
K9D4hQ3I6ln77YyyQ1oyGpIcc7yYVTyFNrZoagMygI/KEoSsTzZ+RUBHPyFcDogb
66U3eqVmboq3gADELHi4CngEAaNf2Aq0ZM0HKgU+rgqSALuKS4NDEfMsLPgpSaLt
nt23Fxou0uZLsJilXAUM
=VaR+
-----END PGP SIGNATURE-----

--x4f8H0SFmJbh3XrFVwTb5coGIuOSDQfaL--
