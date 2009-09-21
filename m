From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] OMAP1: Massive clean up of omap730/omap850 code
Date: Mon, 21 Sep 2009 16:17:24 -0700
Message-ID: <20090921231723.GD27699@atomide.com>
References: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57143 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZIUXRX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 19:17:23 -0400
Content-Disposition: inline
In-Reply-To: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-omap@vger.kernel.org

* Alistair Buxton <a.j.buxton@gmail.com> [090919 21:07]:
> Hello from the Linwizard project,
>=20
> We have been working on supporting omap850 smartphones from HTC such
> as Wizard, Herald etc. We have found that omap730 and omap850 are
> almost exactly the same. As far as what is supported in linux-omap so
> far, they are identical. Currently there are seperate code paths for
> 730 and 850, and this is causing us a lot of problems when one is
> changed and the other isn't. I also noticed that OMAP F-Sample board
> uses ARCH_OMAP730 even though it has a OMAP850 SoC.
>=20
> In order to try to clean this up I have produced a patch series which
> removes all cpu_is_omap730/850 and replaces them with unified
> cpu_is_omap7xx() blocks, and similarly merges CONFIG checks. Here is =
a
> random example:
>=20
> -#ifdef CONFIG_ARCH_OMAP730
> - if (cpu_is_omap730()) {
> +#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> + if (cpu_is_omap7xx()) {
> irq_banks =3D omap730_irq_banks;
> irq_bank_count =3D ARRAY_SIZE(omap730_irq_banks);
> }
> #endif
> -#ifdef CONFIG_ARCH_OMAP850
> - if (cpu_is_omap850()) {
> - irq_banks =3D omap850_irq_banks;
> - irq_bank_count =3D ARRAY_SIZE(omap850_irq_banks);
> - }
> -#endif
>=20
> Drilling down through the variables shows they are always equivalent
> for 730 and 850, except where there is a bug.
>=20
> The patch series converts all 730/850 specific code to omap7xx as
> above. Then all variables and defines have been renamed to refer to
> 7xx. omap730.h and omap850.h are removed and replaced with omap7xx.h.
> ARCH_OMAP730 and ARCH_OMAP850 are still distinct, as there are a few
> differences - but only things that haven't been implemented yet.
>=20
> This makes several bugs go away for us on omap850, including the
> MPUIO_VBASE bug, and the lack of working IRQs - since these bugs arn'=
t
> in the 730 paths. It would hopefully prevent similar bugs from showin=
g
> up in the future too.
>=20
> I did everything as small patches, so I won't spam all 35+ patches on
> the list. The work is available in branch omap7xx here:
>=20
> http://ali1234.homelinux.net/linwizard-kernel.git/

Looks good to me. Let's plan on queuing these early so we can test it
in the linux-omap tree to make sure the patches don't break anyting for
other omaps. Then let's get them to the mainline tree the next merge
window after this current one.

To me it looks like we could queue "OMAP7XX] irq.c: Missed a cpu_is_oma=
p850()"
and "OMAP7XX] PM: Add another ARCH_OMAP850 check" already during the -r=
c
cycle as fixes?

Then assuming you're done with the 7xx patches, could you please
combine all the trivial 730 to 7xx rename patches into just one patch?
This will make it easier for people to read through the whole series ;)

Regards,

Tony


=20
> git diff-tree --stat linux-omap/master omap7xx
>=20
> arch/arm/mach-omap1/board-fsample.c =A0 =A0 =A0 =A0 =A0 | =A0 18 +-
> arch/arm/mach-omap1/board-perseus2.c =A0 =A0 =A0 =A0 =A0| =A0 18 +-
> arch/arm/mach-omap1/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 ++-
> arch/arm/mach-omap1/clock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 30 ++++
> arch/arm/mach-omap1/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 45 ++----
> arch/arm/mach-omap1/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 32 +---
> arch/arm/mach-omap1/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 32 ++--
> arch/arm/mach-omap1/mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 70 +++-----
> arch/arm/mach-omap1/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0100 ++++++------
> arch/arm/mach-omap1/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 53 +++---
> arch/arm/mach-omap1/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 13 +-
> arch/arm/mach-omap1/sleep.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 ++--
> arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +-
> arch/arm/plat-omap/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 22 ++--
> arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
227 +++++++------------------
> arch/arm/plat-omap/include/mach/entry-macro.S | =A0 =A08 +-
> arch/arm/plat-omap/include/mach/hardware.h =A0 =A0| =A0 =A02 +-
> arch/arm/plat-omap/include/mach/irqs.h =A0 =A0 =A0 =A0| =A0229 ++++++=
++-----------------
> arch/arm/plat-omap/include/mach/mcbsp.h =A0 =A0 =A0 | =A0 =A06 +-
> arch/arm/plat-omap/include/mach/mux.h =A0 =A0 =A0 =A0 | =A0100 +++---=
-----
> arch/arm/plat-omap/include/mach/omap730.h =A0 =A0 | =A0102 ----------=
-
> arch/arm/plat-omap/include/mach/omap7xx.h =A0 =A0 | =A0102 ++++++++++=
+
> arch/arm/plat-omap/include/mach/omap850.h =A0 =A0 | =A0102 ----------=
-
> arch/arm/plat-omap/include/mach/uncompress.h =A0| =A0 =A03 +-
> arch/arm/plat-omap/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 14 +-
> arch/arm/plat-omap/usb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 10 +-
> drivers/rtc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
> drivers/spi/omap_uwire.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A08 +-
> 28 files changed, 513 insertions(+), 885 deletions(-)
>=20
> --
> Alistair Buxton
> a.j.buxton@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
