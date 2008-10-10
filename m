From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Fri, 10 Oct 2008 15:54:33 -0700
Message-ID: <200810101554.34176.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com> <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC3560870239624A47@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28856 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1763897AbYJJWyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 18:54:37 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A47@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Friday 10 October 2008, Pandita, Vikram wrote:
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -159,7 +159,7 @@ void __init omap_init_irq(void)
> =A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "Total of %ld interrupts on =
%d active controller%s\n",
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 nr_irqs, nr_banks, nr_banks > 1 =
? "s" : "");
> =A0
> -=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < nr_irqs; i++) {
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < NR_IRQS; /*nr_irqs;*/ i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_chip(i, &omap=
_irq_chip);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_handler(i, ha=
ndle_level_irq);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_irq_flags(i, IRQF=
_VALID);
>=20

This could explain a problem appearing on every OMAP3 board.
But not one appearing only on Overo ... especially when the
same binary works on Beagle.

However, that's also very incorrect.  Most of those NR_IRQS
interrupts are managed by some chip other than the toplevel
OMAP IRQ controller(s)...

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
