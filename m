From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] OMAP: add pwm driver using dmtimers.
Date: Thu, 13 Dec 2012 08:11:00 +0100
Message-ID: <20121213071100.GB9946@avionic-0098.adnet.avionic-design.de>
References: <20121212192430.50cea126@notabene.brown>
 <50C8ABFC.3080309@ti.com>
 <20121213140635.4eda5858@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121213140635.4eda5858@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2012 at 02:06:35PM +1100, NeilBrown wrote:
>=20
> [Thierry: question for you near the end - thanks]
>=20
> On Wed, 12 Dec 2012 10:08:28 -0600 Jon Hunter <jon-hunter@ti.com> wrote:
>=20
> > Hi Neil,
> >=20
> > On 12/12/2012 02:24 AM, NeilBrown wrote:
[...]
> > > +{
> > > +	struct omap_chip *omap =3D platform_get_drvdata(pdev);
> > > +	int status =3D 0;
> > > +
> > > +	status =3D pwmchip_remove(&omap->chip);
> > > +	if (status < 0)
> > > +		goto done;
> > > +
> > > +	omap_dm_timer_free(omap->dm_timer);
> >=20
> > Is it guaranteed that the timer will be disabled at this point?
>=20
> Uhmm... it seems that pwm_put() doesn't call pwm_disable(), so I guess it
> might not be disabled.
> Thierry: should pwm_put do that, or do I need a 'free' function in my chip
> ops to do that?

To be honest, I haven't decided yet. =3D) There have been discussions that
resulted in a request to run pwm_disable() from pwmchip_remove() on all
PWM devices a chip provides.

This isn't implemented yet and I'm not sure about all the side-effects.
I think for now the best way would be to implement .free() within this
driver, or even do an explicit pwm_disable() in the driver's .remove()
function to do this. When I've come to a decision I'll refactor all of
that in one patch across the whole subsystem.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyX+EAAoJEN0jrNd/PrOh+48QAIcq69oZPO9naDEVHlt0bHUO
CPTVZkWInzib6pZ15cPRshAsYMour6zGHf6h1NM+ZHW6Q4nSAsijC2w9VWTvXbwi
ha79M2c/3DD+8svkeBBuQ26cxKB9I9PWn6rOAfEpQLRexDlbgm94TBEB7SMyyokE
hD/H26K6i37qe8UyqUuFTqfNcp+7x/KDl7N8vAje3AnkzFLlJkt9iV3LqWPdLtDt
LQZq0q/bBjhSvgRqvkgUNepPdDbpWb65p8CCFtMKP8K0ORAoBQAEbgmCe46/3bur
Q/TbHLFKOnBjWdTii1nB0U+RDaACtSIJwFepsgeihyKjaU636nVtlKuzDfDCtSD3
IUdAQON6H7Sk759mz9oENGPUKXSY+k6Q2eFXt8sOuP1azj/p4r20E7gliL6sfCdR
khqdDpoJKNUo/0qfPXbRjWMo2jIIVFVvmIh12p/ck5vMCq+1mb0lg57baeyusv+K
vAdpjVUl4zw7HPQGTgfbnV9iMqSQaSeruij4MczUDYxXAqKHWjgcuafgEgVC+fns
ZEKmBagm+iDrGzN5D3+JtZZsBCj9vgjQSn1bPwE+bXp7xqOvwrYkgSa/+r8jSgq+
ZFLPwX8cXjgpn0g1NNo6BPXDax83REhFT0QaBuvIrgF20qAm0JdKHRT7dD5UHpVN
3DZzWZNSFnQ726p/8Xi0
=Ztp6
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
