From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [GIT PULL] OMAP PM updates for 2.6.39
Date: Fri, 11 Mar 2011 16:33:40 +0100
Message-ID: <AANLkTimMsYhCqqRjcBDCMDT4=iTwBG_qLHWjuxVZTmXE@mail.gmail.com>
References: <87k4g6eakw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48563 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab1CKPdl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 10:33:41 -0500
Received: by ywj3 with SMTP id 3so1215163ywj.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 07:33:41 -0800 (PST)
In-Reply-To: <87k4g6eakw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, Mar 11, 2011 at 1:59 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tony,
>
> Please pull the following OMAP PM related changes for the upcoming
> 2.6.39 merge window.
>
> Kevin
>
> The following changes since commit a5abba989deceb731047425812d268daf7=
536575:
>
> =A0Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)
>
> are available in the git repository at:
> =A0ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-oma=
p-pm.git for_2.6.39/pm-misc

Waht about the following patch? IIUC it is scheduled for .39.

    perf: add OMAP support for the new power events

Regards,
Jean

>
> Anand S Sawant (1):
> =A0 =A0 =A0OMAP2+: smartreflex: remove SR debug directory in omap_sr_=
remove()
>
> Dave Martin (5):
> =A0 =A0 =A0ARM: omap4: Provide do_wfi() for Thumb-2
> =A0 =A0 =A0ARM: omap4: Convert END() to ENDPROC() for correct linkage=
 with CONFIG_THUMB2_KERNEL
> =A0 =A0 =A0ARM: omap3: Remove hand-encoded SMC instructions
> =A0 =A0 =A0ARM: omap3: Thumb-2 compatibility for sram34xx.S
> =A0 =A0 =A0ARM: omap3: Thumb-2 compatibility for sleep34xx.S
>
> Kevin Hilman (2):
> =A0 =A0 =A0MAINTAINERS: update Kevin's email for OMAP PM section
> =A0 =A0 =A0OMAP2+: remove unused UART base addresses from omap_global=
s
>
> Menon, Nishanth (1):
> =A0 =A0 =A0OMAP3|4: OPP: make omapx_opp_init non-static
>
> Nishanth Menon (1):
> =A0 =A0 =A0OMAP3: beagle xm: enable up to 800MHz OPP
>
> Paul Walmsley (1):
> =A0 =A0 =A0OMAP2/3: PM: remove unnecessary wakeup/sleep dependency cl=
ear
>
> Ricardo Salveti de Araujo (1):
> =A0 =A0 =A0OMAP3630: PM: don't warn the user with a trace in case of =
PM34XX_ERRATUM
>
> Sanjeev Premi (1):
> =A0 =A0 =A0OMAP3: PM: Initialize IVA only if available
>
> Santosh Shilimkar (7):
> =A0 =A0 =A0omap3: pm: Use exported set_cr() instead of a custom one.
> =A0 =A0 =A0omap3: cpuidle: Add description field to each C-state.
> =A0 =A0 =A0OMAP3: PM: Use ARMv7 supported instructions instead of leg=
acy CP15 ones
> =A0 =A0 =A0OMAP3: PM: Fix the MMU on sequence in the asm code
> =A0 =A0 =A0OMAP3: PM: Allow the cache clean when L1 is lost.
> =A0 =A0 =A0OMAP3: PM: Remove un-necessary cp15 registers form low pow=
er cpu context
> =A0 =A0 =A0OMAP3: PM: Clear the SCTLR C bit in asm code to prevent da=
ta cache allocation
>
> Thara Gopinath (1):
> =A0 =A0 =A0OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
>
> Vasiliy Kulikov (1):
> =A0 =A0 =A0OMAP: PM: SmartReflex: fix potential NULL dereference
>
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0 =A0 | =A0 50 +=
+++
> =A0arch/arm/mach-omap2/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 14 --
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +-
> =A0arch/arm/mach-omap2/include/mach/omap4-common.h | =A0 =A04 +
> =A0arch/arm/mach-omap2/omap-headsmp.S =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
> =A0arch/arm/mach-omap2/omap44xx-smc.S =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A08 +-
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 60 +++++
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +-
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +-
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 +-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A01 +
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A08 +-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 25 +--
> =A0arch/arm/mach-omap2/sleep34xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0282 +++++++++++------------
> =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 31 ++-
> =A0arch/arm/mach-omap2/sram34xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 36 +++-
> =A0arch/arm/plat-omap/include/plat/common.h =A0 =A0 =A0 =A0| =A0 =A04=
 -
> =A018 files changed, 320 insertions(+), 228 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
