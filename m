From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Fri, 6 Mar 2009 16:07:16 -0800
Message-ID: <200903061607.16825.david-b@pacbell.net>
References: <20090226140450.GB8595@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FADBF6CF@dbde02.ent.ti.com> <20090306133428.GA4327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:30374 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751001AbZCGAHU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 19:07:20 -0500
In-Reply-To: <20090306133428.GA4327@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 06 March 2009, Mark Brown wrote:
> > Later, I found out that in set_machine_constraints(),ops->enable() =
is
> > being called if the boot_on flag is set. What is the purpose of doi=
ng
> > this? Since the regulator is already enabled, why we are calling th=
e
> > ops->enable() to do the same again? In my opinion, regulator_enable=
()
>=20
> This ensures that the regulator is actually turned on. =A0Previously
> boot_on was equivalent to always_on and there was no way for a machin=
e
> driver to turn a regulator on at startup so the semantics of boot_on
> were changed slightly to be usable to switch a regulator on at boot.

The boot_on semantics are kind of odd then ...

What I thought they meant:  Bootloader turned this on.
What you describe above:    Kernel turn this on during startup.
Versus normal behavior:     Consumer turns it on, as needed.

I wouldn't have thought there would be a need for that
second case, since the board-specific init code can
just define a consumer that turns it on if that's what
it needs.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
