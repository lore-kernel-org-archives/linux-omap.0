From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Allow clock alias provision from device
 tree
Date: Mon, 11 Feb 2013 17:49:47 +0200
Message-ID: <20130211154947.GA18684@arwen.pp.htv.fi>
References: <1360597464-8491-1-git-send-email-rogerq@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1666875384915139630=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1360597464-8491-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============1666875384915139630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 11, 2013 at 05:44:23PM +0200, Roger Quadros wrote:
> @@ -36,12 +39,76 @@ static struct of_device_id omap_dt_match_table[] __in=
itdata =3D {
>  	{ }
>  };
> =20
> +static int __init omap_create_clk_alias(struct device_node *np)

if the rest of the folks agree with the aproach, looks like most of this
can be made a bit more generic ;-)


--=20
balbi

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRGRMbAAoJEIaOsuA1yqRE1mUP/10O7v8YdQtKVvLLTfP3jy3s
bvhYQJKxCsztJQ9LeJB1ODDjBCcXejuidUSrABL5tlWumjXT40bvbR9zxe6aCjiX
FOUYazuSQoFtFBY4QKRyQtikgdIS4NBNbHmvB9JupQmRS9jvPt2g+YoUpm9YUQlL
OIiTRLhNMBSK7k9gCfj0x8eHK+w7GtAhKWhomA/+d+4yGu6Fk4nfmMlJbnELdhho
4AnP6AG6+BnG73pTIlpJMiUg7vPSiyLOEcfPa/KAU1mTMCyYY488hFsN2Zt9quc3
hT0+1JZCvpATEVDC5i3colqqYSSV2D9D7aFtT7mi9jHuFgzCMENN9ocUuQ42E2v+
pD452xSPQDf6LnterU6ZLuNZfJrUFX94K3Gf5Fs2YR1tf5Q8/zAFmN1pJ+WKr2Kj
Vi935mnZC+9WS0m/cKVjiV4fDQNaYMtpqLpjXxSzCdJTlCsyEEkwWpNzbZUOumfZ
JX7GvxP0OVc9LHyOBsPFo3gpkkqQqwtiEBoEGaBuu33Pwf2iWaciAx4oc7ie7zN/
HS4ngzB57QXgEIDggnWe0VsSABow233+cPy8i2Yi9p3FHf5o1JqwK4WCofGEV7ZV
FFmsrB9mTf0iiQ1ynYB0haPO1bsb9sX3gVNatDEVb9i2HRRelXJsR2rEHAttP238
CJaMMBPRYLUznB+5i8qA
=6+e6
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

--===============1666875384915139630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1666875384915139630==--
