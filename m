From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Fri, 6 Jan 2012 17:20:16 +0100
Message-ID: <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2107708734745473033=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Walker <dwalker@fifo99.com>, Jamie Iles <jamie@jamieiles.com>, Russell King <linux@arm.linux.org.uk>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Barry Song <baohua.song@csr.com>, Thomas Gleixner <tglx@linutronix.de>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Bryan Huntsman <bryanh@codeaurora.org>, Richard Zhao <richard.zhao@freesc>
List-Id: linux-omap@vger.kernel.org


--===============2107708734745473033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grant Likely wrote:
> Hi Thierry,
>=20
> On Fri, Jan 6, 2012 at 7:28 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > The irq_domain_add() function needs the number of interrupts in the
> > domain to properly initialize them. In addition the allocated domain
> > is now returned by the irq_domain_{add,generate}_simple() helpers.
>=20
> The commit text should also include the justification for renaming
> irq_domain_create_simple() -> irq_domain_add_simple()

Actually the commit only fixes up the comment. The function has always been
called irq_domain_add_simple().

For reference, this was introduced in commit 7e71330.

> > =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D kzalloc(sizeof(*domain), GFP_KERN=
EL);
> > - =C2=A0 =C2=A0 =C2=A0 if (!domain) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN_ON(1);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > - =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 if (!domain)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ERR_PTR(-ENOM=
EM);
>=20
> Don't use the ERR_PTR() pattern (it's a horrible pattern IMHO).

Returning NULL here is probably okay. Can the ERR_PTR stay in
irq_domain_generate_simple(), though? It has two error conditions and
handling both by returning NULL may not be what we want.

> Return NULL on failure and keep the WARN_ON() in this function.
> Otherwise looks good.  Thanks for writing this patch.

I thought it would be better to pull the WARN_ON out of the function because
we now actually have a way to determine if the call succeeded in the caller.
In most cases I assume the caller will be much better suited to handle the
situation gracefully such that the WARN_ON is not required.

Thierry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8HH0AACgkQZ+BJyKLjJp/LDQCfY2B6i+joJLJmnLNoW5jCTSJl
sSkAn2Hfd2ya/3dM3Yg6iKWUYRmBmDa0
=zB9Z
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


--===============2107708734745473033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2107708734745473033==--
