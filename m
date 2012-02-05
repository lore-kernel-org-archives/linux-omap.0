From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 17:33:56 -0800
Message-ID: <20120205013356.GH1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <CANOLnONTdcrSjrq4n6LYJG85uaUe_AX5a4orn1PzeLTfVB5zxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17454 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2BEBd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 20:33:58 -0500
Content-Disposition: inline
In-Reply-To: <CANOLnONTdcrSjrq4n6LYJG85uaUe_AX5a4orn1PzeLTfVB5zxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@ti.com>

* Grazvydas Ignotas <notasas@gmail.com> [120204 12:37]:
> On Sat, Feb 4, 2012 at 10:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Another problem oopses the kernel at boot in the voltage domain cod=
e,
> > which I suspect this has never been boot tested on OMAP34xx CPUs:
> >
> > omap_vc_init_channel: PMIC info requried to configure vc forvdd_cor=
e not populated.Hence cannot initialize vc
> > Unable to handle kernel NULL pointer dereference at virtual address=
 00000000
> > pgd =3D c0004000
> > [00000000] *pgd=3D00000000
> > Internal error: Oops: 5 [#1] PREEMPT
> > Modules linked in:
> > CPU: 0 =C2=A0 =C2=A0Not tainted =C2=A0(3.3.0-rc2+ #204)
> > PC is at omap_vp_init+0x5c/0x15c
> > LR is at omap_vp_init+0x58/0x15c
>=20
> I've got hit by this too, and it also seems to be DT related, because
> if you don't select CONFIG_USE_OF, you lose TWL4030_CORE, which
> results in omap_vp errors and NULL dereference. TWL4030_CORE was made
> to depend on IRQ_DOMAIN, and that is selected by USE_OF or ARM_GIC. I
> guess everyone here builds with USE_OF, but maybe ARCH_OMAP3 should
> select ARM_GIC?

Thanks for tracking this down. We should not select GIC for omap3 as it
does not have it. Instead we should select IRQ_DOMAIN, there's patch
"[PATCH v4 1/4] ARM: kconfig: always select IRQ_DOMAIN" posted that
does that for all ARMs.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
