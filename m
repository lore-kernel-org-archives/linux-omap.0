From: Torben Hohn <torbenh@linutronix.de>
Subject: Re: RT and omap-gpio irqchip with DeviceTree
Date: Tue, 2 Jul 2013 16:31:30 +0200
Message-ID: <20130702143130.GC27329@localhost.localdomain>
References: <20130702114452.GA13763@localhost.localdomain>
 <CAAwP0s2KUCowe5scWJtiZ8hZb-5EMbmef_WO_03cY3H7DqxSOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60799 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3GBObd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jul 2013 10:31:33 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s2KUCowe5scWJtiZ8hZb-5EMbmef_WO_03cY3H7DqxSOQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, tglx@linutronix.de, bigeasy@linutronix.de, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 02:15:46PM +0200, Javier Martinez Canillas wrote:
> + Grant, Linus W and Jean-Christophe.
>=20
> On Tue, Jul 2, 2013 at 1:44 PM, Torben Hohn <torbenh@linutronix.de> wrote:
> >
> > Hi..
> >
> > I am running into Problems with a network adapter IRQ connected to an
> > omap-gpio pin.
> >
> > omap-gpio expects gpio-request() to be called before i can use the pin.
> > But this is abstracted via the DeviceTree bindings.
> >
> > I see 8d4c277e185c31359cf70573d8b0351fb7dd0dfe in mainline.
> > This one just puts a warning into the exact place, i am dealing with.
> > But i need to make this work, instead of bailing out.
> >
>=20
> This has been discussed extensively on the linux-omap mailing list and
> the agreement is that it has to be handled by the IRQ core. So when a
> GPIO line is mapped in the IRQ domain with irq_create_of_mapping(),
> the core has to take care to request the GPIO and configure it as
> input.

Can you give me a pointer to this discussion please ?
Because i fail to understand why you just dont save the irq_type in some
private data structure, and then use chip->irq_enable() or something.


>=20
>  But until we have this general solution we have to do it on a per irq
> chip driver basis and the less hack-ish solution is to have a custom
> .map function handler that request the GPIO used as IRQ.
>=20
> There is already a patch [1] queued in Linus Walleij linux-gpio tree
> [2] for-next branch that implements this for OMAP GPIO. It would be
> great if you can test it and give feedback.

Thanks for the pointer.
The kernel i am working on is based on 3.8.x (this is before the
irq_domain change to linear)

First i only backported: [1] and [2]

With these i see big streams like these:
[    1.554809] omap_gpio gpio.9: Could not request GPIO-256
[    1.560394] omap_gpio gpio.9: Could not request GPIO-255
[    1.566009] omap_gpio gpio.9: Could not request GPIO-254
[    1.571594] omap_gpio gpio.9: Could not request GPIO-253
[    1.577178] omap_gpio gpio.9: Could not request GPIO-252
[    1.582794] omap_gpio gpio.9: Could not request GPIO-251

This is basically coming from irq_domain_add_legacy() which calls
ops->map(domain, irq, hwirq) before the gpio chip is actually added.

I fixed it by also taking [3].

However, OMAP1 is still calling irq_domain_add_legacy(). This would
probably break with DeviceTree.=20
But since omap1 doesnt use DeviceTree, this is probably a non-issue.

[1] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/comm=
it/?h=3Dfor-next&id=3D570c4bb53366157fa076922d0fc7e7adfd81cf42
[2] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/comm=
it/?h=3Dfor-next&id=3D50fc1d067d9f4b6c99717b91c1aaaa618075f859
[3] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/comm=
it/?h=3Dfor-next&id=3Dede4d7a5b9835510fd1f724367f68d2fa4128453


--=20
Mit freundlichen Gr=FC=DFen
Torben Hohn

Linutronix GmbH

Standort: Bremen

Phone: +49 421 5650 2310 ; Fax.: +49 7556 919 886
mailto: torbenh@linutronix.de
Firmensitz / Registered Office: D-88690 Uhldingen, Auf dem Berg 3
Registergericht / Local District Court: Freiburg i. Br., HRB Nr. / Trade
register no.: 700 806;

Gesch=E4ftsf=FChrer / Managing Directors: Heinz Egger, Thomas Gleixner

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJR0uRCAAoJEESSOlgt2wc79gEH/0JPOsXM6+XwqurIllucJ6B8
k7ApMZ555M3Lq8R5bh1jvIvxHTwKyYSLrONSP1tKGw4j+NabWnfUcuRNqFZKDgSr
2WEhWwUSkcEjC3t+IRnalyvQZ8tIDzP9g270J8UsyM4uvLFpHC8T5RdjQBQ1ztJk
+jpOfBVFFuZY5o1HdLav8l0/+XdgRRuAZDjUTrlpX+fgKInKSvCtBYI5c/q8idx9
PTczg3i5Varb/G/ox0gOIx0vjxl4I1FXSraX4sQGypx31thGJC30xenf9CecezQX
d2fBCzBHAfpSWbz3rbPnaHA3n5cdUPPGmkjriNSCKCcp3nnCR4hbo2cpG1n8Dks=
=ytgM
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
