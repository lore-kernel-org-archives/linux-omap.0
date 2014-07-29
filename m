From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
Date: Tue, 29 Jul 2014 04:25:37 +0200
Message-ID: <20140729022536.GC4421@earth.universe>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 28, 2014 at 04:15:48PM -0500, Felipe Balbi wrote:
> here's another rebase of the original series moving INTC
> to drivers.
>=20
> There aren't many changes, only some fixes here and there
> because of recent changes to irq_domain and irqchip.
>=20
> I have also added a patch to enable INTC address space
> protection so that only privileged modes can access
> INTC's address space.
>=20
> Patches tested on top of v3.17-rc7 with a beagle bone black,
> the only plataform I have which still uses INTC.
>=20
> Tony, if you can run your PM test cases on your side, I'd
> be really glad.

Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

for the whole series except of "drop ti,intc-size support",
which breaks the DT API.

I will give this a try on my N900 in the next days.

-- Sebastian

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1wYgAAoJENju1/PIO/qauI0QAIHmRdHvPeuA50WFg3RcNinL
WV1xTheSeSb41Y6tUlbfFSvCQLwmzUmYVgjj+eUyPUv+MtZix27O6QLUsPHCqD9G
ykZZxv1M+4olV8g3bX6IGt48ofKH50RdedcGaqYnNJj635pVHXRUu4X3PO/Q7XPd
Wl17YxFTlduKEAoByFLGB4QAraPZFc+SCwj3yZdDOQnmqprDrF0Nlg/3xP6FP/bV
EtCUiYkcfF9GuFFbOeFCHleXliBg0huDPWffzuT4dRBKkwnGHmbJydsMLO9mEos3
oGVA6F/nqm+whfYrnX9asa7qU+66e2lnUgTdLVCnaWbDZ2QutVVRcQQ5U/vbteVV
rBrmoEjk0yLAeSXhtUCp9/GOQFixgnYAt21rfcih55J8lQJrq8n/TvzL0xarE0o/
D2tn3zmZWp0YUFUuQRmwRqLF7vQ0orx19AZJAeW/tpxmatkJzLpO8enT2B8gJvjW
3m78WVN2DTGsj7YE0TSwifB1CzOJwh7Au4syreBbI8IgYWC4EGsgmMjmN5y/+b2x
QKQHikNTGEzKsZeAArO6PXdlcguudeALTyLFemw/ppXY9I2+WKsjG4c8Qxq8YhAN
Yq4LkD5Ef0jVryLYtWxO0r5u3iv40bTmi/1H1geVGY3mK3dS3C4y2SNNnpz5J+T5
z9gaRyicE6y3kaAvLQFs
=tS5m
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
