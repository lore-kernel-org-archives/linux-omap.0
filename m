From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 13/35] arm: omap: irq: call set_handle_irq() from
 intc_of_init
Date: Tue, 29 Jul 2014 18:00:23 +0200
Message-ID: <20140729160022.GA21830@earth.universe>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-14-git-send-email-balbi@ti.com>
 <20140729022019.GB4421@earth.universe>
 <20140729153649.GD17808@saruman.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140729153649.GD17808-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 29, 2014 at 10:36:49AM -0500, Felipe Balbi wrote:
> On Tue, Jul 29, 2014 at 04:20:20AM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Mon, Jul 28, 2014 at 04:16:01PM -0500, Felipe Balbi wrote:
> > > this will let us drop .handle_irq and .init_irq fields
> > > from our generic machine_descs.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  arch/arm/mach-omap2/irq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> > > index e6997c5..e452411 100644
> > > --- a/arch/arm/mach-omap2/irq.c
> > > +++ b/arch/arm/mach-omap2/irq.c
> > > @@ -314,6 +314,8 @@ static int __init intc_of_init(struct device_node=
 *node,
> > > =20
> > >  	omap_init_irq(res.start, nr_irq, of_node_get(node));
> > > =20
> > > +	set_handle_irq(omap2_intc_handle_irq);
> > > +
> > >  	return 0;
> > >  }
> > >
> >=20
> > if you respin the patchset you may want to call omap_intc_handle_irq
> > directly. It makes the review of the patchset less confusing.
> >=20
> > (I was wondering why omap3 can call omap2_intc_handle_irq until I
> > noticed, that your previous changes made both functions simple
> > wrapper functions for omap_intc_handle_irq)
>=20
> this is done later for a reason. At this point, omap_intc_handle_irq()
> still misses proper annotations for asmlinkage and
> __exception_irq_entry.

I guess that could be solved by moving the annotations to
omap_intc_handle_irq and just keeping omap{23}_intc_handle_irq as a
#define. Probably not worth the extra work, though.

-- Sebastian

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT18UVAAoJENju1/PIO/qaziAP/3YU2twsXjL4kpqHg9kUN35/
fm7I7whLY1ZqQRW2CcZv4QHE9JLHubqW4RcTFof+woFksDkLtUwbV4suyC5DJ/up
3irrl0ZOO20XuNq7WnsOEZCng1SkH8EBso0jdw+QfSsKpy4Uvcvn3qBibORFldbZ
IKsxtXZZNJmV9GLNaFprBPwp5+aKEuuHGAMWLYaz5E2WNW2pe+8V+5sQPeuQODwy
FtnLCSOKY1QZE8dJGypLYq95q5G5cGgwhBi/IhTS2Y5OoKMYlDHBPtIZ+DqukvKT
hkIfJvtRTA8R9PnO6Bq8B8XehNLpalm4wvvZroDXx3GrKtAADenoeX8wok77JdUE
29ZOm6O+rBjU6WmwSiZDpicmqtmWkHimyv8QlJ6YWUZcsAs8QP03h/RRJdFmcxOA
Uc//u3EAJs7x9StKKE/aYFJV7TFJkt2t5+yOmDLlTv5ivD8yLrKnlHNhNttPekKX
MsDm/IA2A2oV51zSu7LokAHULE5iH6XqqozBHZROrti0eZ/sfgRLtE44m6ajoDpc
Q3659JROOjcMZNiz+E8+5WVNeVBmhQ6gbGIJLHR6I+lB0C5x1NB27cAvSpFf6DXI
dy1xubDewcWCNivMSQjqEAtHO0I/Cn/zZ3afLKqty0brnH0LT4OLqwgByG5E4S3a
FDl2eDYj4CTpIhaKYTSq
=qtyI
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
