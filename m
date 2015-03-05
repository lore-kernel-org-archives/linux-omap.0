From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Thu, 5 Mar 2015 01:48:01 +0100
Message-ID: <20150305004801.GC1033@earth>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423088075-10025-4-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, mark.rutland@arm.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Feb 04, 2015 at 11:14:32PM +0100, Marek Belisko wrote:
> + - volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +	for charging calibration (see example)
> + - volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +	for discharging calibration (see example)

Please prefix these properties with "ti,"

-- Sebastian

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU96e+AAoJENju1/PIO/qaVcUP/1ABHAiQQ7/5dAaiV2wOUZUp
tNfNGY13wHRn+4O2agQyhob0kh2qsjMA0uRODduUiQmYdxqlC1TbyVh98i44xTfY
4ynGggHrzM4RlvOnqorbCa7AW75UDDPHmOlzwuwbjLayes4Qw5PB1JHYChE47PhX
4tOBjTgb8DMpWr3YYbL2uyEm4jmPSxaicPkzaM54ZOKtQJ4xuIc/v2vRzQ8k5Lv1
xA1zfyCFmSvBiGJVzcAunerjfYw8UbgAOoMj16hu25BxH+HorQX/dEhyBDj8RDAj
JVUTPP4w+Ry3KjAmKoomxOPLzlLrspJWUQ2yDQVhGExQShr374t9c17n2mcUp7Fk
9JYWNJIksNeb81Al8ZPOpFuHlgPN6mBIHLU2SQ32kOyOBIZs4Xiovbkdj0OAo+H0
Kdl9hzdsFD10UGtcgwywxVUXyiJ0QT3U+i4+NGBTztId5XoZVRi2fD8REcrn0tqS
Umr9U7q6vpxx+RTGX0PFgFK5Pozld610mFieb5RKnK1wjkKaVwEWHwY2HhQCfdY0
CscPRCaEjG1Q2e3Qt57Ai/VOW+bdSB9aF5AM2ra5vmwl9URbhO+1O+rt6ShSOISS
XoDB13GkTAqp/ECPzyfJQQm8rrS2/rINcoMwkF136X5uXo73KfKkwNBGc7EWdGqm
zvIYiVGRAmBpT/X2Vh+Z
=fw4b
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
