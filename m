From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Fri, 24 Mar 2017 22:04:24 +0100
Message-ID: <20170324210423.4exvxg2tysqzenqo@earth>
References: <20170322234210.5557-1-tony@atomide.com>
 <20170324100622.mzra66z35xlndhdj@earth>
 <20170324140807.GW10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eb76ak4yejpygfzk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170324140807.GW10760-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--eb76ak4yejpygfzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 24, 2017 at 07:08:07AM -0700, Tony Lindgren wrote:
> > s->battdetb =3D cpcap_sense_virq(ddata->reg, ddata->irq_battdetb);
> > (and so on)
> >=20
> > looks cleaner IMHO.
>=20
> I figured I'll do a follow up patch for when available to remove
> dependencies between subsystems.

Ok. I'm fine with that.

-- Sebastian

--eb76ak4yejpygfzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljVidUACgkQ2O7X88g7
+pq7xg/+KgoderjiZr3m+6EOEHwjTu6aod5uCm2T1aMa5vN3GnDqtO9GMJMfXlXu
QVht3uc0oOqaLcnGcO+ruGUYcW3uR5ZFGi6Iaeiw6K3mlvQp695ZnLFsLBQR3Jv5
mYXY9APbnrtgjecj9LHBF9/F7TLmJkK1mF7uVnVoct19asV40fCiJ55jq1Hqf43L
pLuOB78+aSiABCpvhVU+GC25DS8xnz2v4FPGB0lUrx/9nT+BRXozip8D/dsrajsu
yd/18kq/tLKTuKE310Gg+K+8Mxnd+PZG3SNwDLF+nm36t1TjoExgBuHDIyjzBNfD
c33mxhnjX4DENW5akyHvXnANZ7pAZZtlQ1Ru0Fw/tcZlUsQy56HUS5LzKBDNo1gK
rCB2aO6t4wS6pgUEHVEPOMTE3QRNdDosqL6X+aMRIXrTgsEadWBfW8Ne7ASH5L7M
9n21V7iIxwD2Z9Y94BnvZS0sfUld2ZNRhBBJU5/HMVBXCEa7o1yptuQVZj6I+24Z
ENhejOkAI+gjfZfTyUb1fLrgJkIsnEXtPV5vQeqibPOkV2CevHpGBp6owzjhZqnX
S3Bbw/4oQsttT4PF56OKFpdIvik674OXo5+FKtp+RUSSUpGHyy+Zkp/d5J6K6sIU
E220gnhIEFEfI7gHCJw3uAbhkus9V4iU+39X9zVPsm3ND9oan/4=
=/39p
-----END PGP SIGNATURE-----

--eb76ak4yejpygfzk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
