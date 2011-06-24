From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/25] Re-jig cpu_suspend for a saner calling convention
Date: Fri, 24 Jun 2011 09:43:41 +0200
Message-ID: <BANLkTinOUqpnhts8p4Ft9Bfs78V42A2nGw@mail.gmail.com>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Thu, Jun 23, 2011 at 9:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Version 3.
>
> Currently cpu_suspend is not like a normal C function - when it's cal=
led
> it returns normally to a bunch of code which is not expected to retur=
n.
> The return path is via code pointed to by 'r3'.
>
> It also corrupts a bunch of registers in ways which make it non-compl=
iant
> with a C API.
>
> If we do make this compliant as a normal C-like function, it eliminat=
es
> this register saving, and also allows us to make greater savings. =A0=
We
> also swap 'lr' and 'r3', so cpu_suspend effectively only returns to
> following code on resume - and r3 points to the suspend code.
>
> I've also changed cpu_suspend() to have a saner visible prototype for
> calling from platforms, hiding the needed v:p offset parameter in the
> inline function.
>
> So, this becomes:
> static void soc_suspend(void)
> {
> =A0 =A0 =A0 =A0[soc specific preparation]
>
> =A0 =A0 =A0 =A0cpu_suspend(soc_suspend_arg, soc_finish_suspend);
>
> =A0 =A0 =A0 =A0[soc specific cleanup ]
> }
>
> where soc_suspend_fn can be either assembly or C code - but must neve=
r
> return. =A0(See separate patch posted on 13th June to allow it to ret=
urn.)
>
> This patch series also merges the call to cpu_init() into cpu_suspend=
(),
> and makes cpu_init() call the per-CPU initialization function to ensu=
re
> that various registers are setup (eg, clock switching on StrongARM,
> read-buffer enabled for userspace, etc.) =A0This allows some more cus=
tom
> platform suspend code to be removed.
>
> I've been able to convert OMAP3 suspend support and test it in both
> retention and off modes.
>
> The only platform not converted to cpu_suspend() is the shmobile stuf=
f,
> which I've requested their assistance with.
>
> This patch set also eliminates 300 LOC from platform code.
>
> Tested on Assabet (SA1100) and 3430LDP only.

That is a great set of patches! We are now close to have a clean
suspend code, all the way from arch code to low level OMAP-specific
ASM implementation.

=46WIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
> =A0arch/arm/include/asm/suspend.h =A0 =A0 =A0 =A0 =A0| =A0 21 ++++
> =A0arch/arm/kernel/setup.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 99 +=
+++++++++----------
> =A0arch/arm/kernel/sleep.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 73 +=
+++++---------
> =A0arch/arm/mach-exynos4/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
> =A0arch/arm/mach-exynos4/sleep.S =A0 =A0 =A0 =A0 =A0 | =A0 22 ----
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 48 ++---=
----
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0 | =A0160 ++-------=
----------------------
> =A0arch/arm/mach-pxa/include/mach/pm.h =A0 =A0 | =A0 =A04 +-
> =A0arch/arm/mach-pxa/palmz72.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-pxa/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/arm/mach-pxa/pxa25x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +=
-
> =A0arch/arm/mach-pxa/pxa27x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++-
> =A0arch/arm/mach-pxa/pxa3xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +++=
-
> =A0arch/arm/mach-pxa/sleep.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 55 ++-=
--------
> =A0arch/arm/mach-pxa/zeus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03=
 +-
> =A0arch/arm/mach-s3c2412/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +=
-
> =A0arch/arm/mach-s3c2416/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +=
-
> =A0arch/arm/mach-s3c64xx/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
> =A0arch/arm/mach-s3c64xx/sleep.S =A0 =A0 =A0 =A0 =A0 | =A0 23 -----
> =A0arch/arm/mach-s5pv210/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
> =A0arch/arm/mach-s5pv210/sleep.S =A0 =A0 =A0 =A0 =A0 | =A0 21 ----
> =A0arch/arm/mach-sa1100/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A07 +=
-
> =A0arch/arm/mach-sa1100/sleep.S =A0 =A0 =A0 =A0 =A0 =A0| =A0 19 +----
> =A0arch/arm/mm/proc-sa1100.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +=
-
> =A0arch/arm/mm/proc-v7.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10=
 ++-
> =A0arch/arm/plat-s3c24xx/sleep.S =A0 =A0 =A0 =A0 =A0 | =A0 25 -----
> =A0arch/arm/plat-samsung/include/plat/pm.h | =A0 =A05 +-
> =A0arch/arm/plat-samsung/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +--
> =A028 files changed, 180 insertions(+), 474 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
