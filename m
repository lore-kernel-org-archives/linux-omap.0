From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] ARM: OMAP2+: Clean up wrapping multiple objects in
 Makefile
Date: Wed, 2 May 2012 08:49:49 -0700
Message-ID: <20120502154949.GF3739@atomide.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-3-git-send-email-santosh.shilimkar@ti.com>
 <20120502095612.GG25053@n2100.arm.linux.org.uk>
 <CAMQu2gx3_tZnQg=+8xm4Bnnv31BTOgJki_y=aNDOAUG-xNNrvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24750 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2EBPtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 11:49:55 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gx3_tZnQg=+8xm4Bnnv31BTOgJki_y=aNDOAUG-xNNrvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120502 03:18]:
> On Wed, May 2, 2012 at 3:26 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, May 02, 2012 at 03:18:08PM +0530, Santosh Shilimkar wrote:
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> ---
> >> =C2=A0arch/arm/mach-omap2/Makefile | =C2=A0160 +++++++++++++++++++=
+---------------------
> >> =C2=A01 files changed, 78 insertions(+), 82 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Ma=
kefile
> >> index 56ed62e..669e2b1 100644
> >> --- a/arch/arm/mach-omap2/Makefile
> >> +++ b/arch/arm/mach-omap2/Makefile
> >> @@ -24,10 +24,11 @@ endif
> >> =C2=A0obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
> >>
> >> =C2=A0# SMP support ONLY available for OMAP4
> >> +
> >> =C2=A0obj-$(CONFIG_SMP) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D omap-smp.o omap-headsmp.o
> >> =C2=A0obj-$(CONFIG_HOTPLUG_CPU) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0+=3D omap-hotplug.o
> >> -obj-$(CONFIG_ARCH_OMAP4) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D omap4-common.o omap-wakeupgen.o \
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
sleep44xx.o
> >> +obj-$(CONFIG_ARCH_OMAP4) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D omap4-common.o omap-wakeupgen.o
> >> +obj-$(CONFIG_ARCH_OMAP4) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D sleep44xx.o
> >
> > Using \ in makefiles really isn't a problem. =C2=A0I don't think th=
is is something
> > which we need to do, and it just creates additional changes where n=
one is
> > required.
>=20
> Tony might give better reasoning for this change since he suggested i=
t.

Mostly for making it cleaner to build shared objects between omap4 and =
omap5
without adding things like:

+obj-$(CONFIG_ARCH_OMAP5)                +=3D omap4-common.o omap-wakeu=
pgen.o \
+                                          sleep44xx.o

But of course more localized changes will do there too to prepare addin=
g
omap5.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
