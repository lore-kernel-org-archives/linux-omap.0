From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 23:09:00 +0200
Message-ID: <CANOLnONTdcrSjrq4n6LYJG85uaUe_AX5a4orn1PzeLTfVB5zxQ@mail.gmail.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
	<20120204190109.GL20333@atomide.com>
	<20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36189 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2BDVJB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 16:09:01 -0500
Received: by iacb35 with SMTP id b35so6492608iac.19
        for <linux-omap@vger.kernel.org>; Sat, 04 Feb 2012 13:09:00 -0800 (PST)
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@ti.com>

On Sat, Feb 4, 2012 at 10:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Another problem oopses the kernel at boot in the voltage domain code,
> which I suspect this has never been boot tested on OMAP34xx CPUs:
>
> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core =
not populated.Hence cannot initialize vc
> Unable to handle kernel NULL pointer dereference at virtual address 0=
0000000
> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT
> Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(3.3.0-rc2+ #204)
> PC is at omap_vp_init+0x5c/0x15c
> LR is at omap_vp_init+0x58/0x15c

I've got hit by this too, and it also seems to be DT related, because
if you don't select CONFIG_USE_OF, you lose TWL4030_CORE, which
results in omap_vp errors and NULL dereference. TWL4030_CORE was made
to depend on IRQ_DOMAIN, and that is selected by USE_OF or ARM_GIC. I
guess everyone here builds with USE_OF, but maybe ARCH_OMAP3 should
select ARM_GIC?


--=20
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
