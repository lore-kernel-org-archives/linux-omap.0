From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Mon, 9 Jan 2012 10:03:12 +0100
Message-ID: <20120109090311.GA10040@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <4F072843.6050306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F072843.6050306@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Walker <dwalker@fifo99.com>, Russell King <linux@arm.linux.org.uk>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Barry Song <baohua.song@csr.com>, Thomas Gleixner <tglx@linutronix.de>, OMAP SUPPORT <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Bryan Huntsman <bryanh@codeaurora.org>, Richard Zhao <richard.zhao@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Cousson, Benoit wrote:
> Hi Thierry,
>=20
> On 1/6/2012 3:28 PM, Thierry Reding wrote:
> >The irq_domain_add() function needs the number of interrupts in the
> >domain to properly initialize them. In addition the allocated domain
> >is now returned by the irq_domain_{add,generate}_simple() helpers.
>=20
> [...]
>=20
> >diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/b=
oard-generic.c
> >index d587560..bf67781 100644
> >--- a/arch/arm/mach-omap2/board-generic.c
> >+++ b/arch/arm/mach-omap2/board-generic.c
> >@@ -66,8 +66,11 @@ static struct of_device_id intc_match[] __initdata =
=3D {
> >  static void __init omap_generic_init(void)
> >  {
> >  	struct device_node *node =3D of_find_matching_node(NULL, intc_match);
> >-	if (node)
> >-		irq_domain_add_simple(node, 0);
> >+	if (node) {
> >+		struct irq_domain *domain;
> >+		domain =3D irq_domain_add_simple(node, 0, INTCPS_NR_IRQS);
>=20
> The number of interrupts will depend on the OMAP generation. That
> one is just valid for the 3430 INTC controller.
> Since the previous code was using zero, I guess that using 0 there
> should be fine.
>=20
> Moreover, that piece of code should not exist anymore on 3.3 if the
> series I sent last month to leverage Rob's DT interrupt init is
> merged [1].
>=20
> I've just ping Rob and Grant on that series to get a status.

Okay, so I guess we should wait for you patch to go in first and I'll update
this patch on top of that. I assume we can coordinate things in linux-next?

Thierry

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8KrU8ACgkQZ+BJyKLjJp+TRgCfZOrAsza8BDBWyon6uCOjTrsW
V6IAnjIkRPQSQTh5AThunw4n4ZK1La8m
=eQ7B
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
