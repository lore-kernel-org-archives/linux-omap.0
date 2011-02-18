From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v7 00/12] omap3: pm: TWL4030 power scripts and workaround
 for TWL errata 27
Date: Fri, 18 Feb 2011 18:27:17 +0100
Message-ID: <AANLkTinTAVuK=CJaCgve4LQa-4jPhHf1ycUf-BhEz5i0@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60503 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab1BRR1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 12:27:18 -0500
Received: by qwd7 with SMTP id 7so530559qwd.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 09:27:18 -0800 (PST)
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Fri, Feb 18, 2011 at 6:08 PM, Lesly A M <leslyam@ti.com> wrote:
> Patch series for TWL4030 power scripts and workaround for TWL errata =
27.
>
> Changes for implementing TWL4030 power scripts recommended by hardwar=
e team.
> Introduced a new TWL4030 power script file, which can be used by diff=
erent
> OMAP3 board with the power companion chip TWL4030.
>
> Updated the changes for TWL4030 errata 27 & 28, modified the
> TWL4030 power script and voltage controller setuptime.
> Workaround for TWL4030 errata 27 & 28 is required for
> Si version less than or equal to TWL5030 ES1.1.
>
> TWL4030 script changes rebased on Kevin's PM tree in pm branch.
>
> Changes in v7:
> =A0 =A0 =A0 =A0changes to fix Nishanth Menon's comments
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) Added the TWL4030 Errata 27 fix
>
> =A0 =A0 =A0 =A0split the first patch in v6
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) =A0fix for twl4030 script load
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) correct the warning print during s=
cript loading
>
> =A0 =A0 =A0 =A0Added new patch files
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) pmic_info struct cleanup
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) changing sys_off signal polarity
>
> =A0 =A0 =A0 =A0Updated the change logs
>
> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode enab=
led in suspend path.
> =A0 =A0 =A0 =A0Tested with suspend/resume script, which will test sys=
tem suspend in a loop.
> =A0 =A0 =A0 =A0Tested for more than 1000 iterations.

Good to see the TWL scripts back in the mainline kernel!
Are the scripts compatible with the OMAP3 Beagleboard? I would like to
test the changes on that board.

Thanks,
Jean

>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> Lesly A M (12):
> =A0omap3: pm: Fix for the TRITON sleep/wakeup sequence
> =A0omap3: pm: Correct the warning print during script loading
> =A0omap3: pm: cleanup pmic_info structure
> =A0omap3: pm: Using separate clk/volt setup_time for RET and OFF stat=
es
> =A0omap3630: pm: Adding voltage controller data
> =A0omap3: pm: Correcting the sys_offmode signal polarity
> =A0omap3: pm: Re-programing the setup time based on CORE target state
> =A0omap3: pm: TWL4030 power scripts for OMAP3 boards
> =A0omap3: pm: TWL5030 version checking
> =A0mfd: TWL4030: changes for TRITON Errata 27 workaround
> =A0omap3430: Updating the board file to use TWL4030 scripts
> =A0omap3630: Updating the board file to use TWL4030 scripts
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 =
+-
> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 =A02 +
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A036=
9 +++++++++++++++++++++++---
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 15 +-
> =A0arch/arm/mach-omap2/twl4030.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
261 ++++++++++++++++++
> =A0arch/arm/mach-omap2/twl4030.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 21 ++
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
167 +++++++++---
> =A0arch/arm/plat-omap/include/plat/voltage.h =A0 =A0| =A0 49 +++-
> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 50 ++++
> =A0drivers/mfd/twl4030-power.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 79 ++++++-
> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 45 +++-
> =A012 files changed, 961 insertions(+), 112 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/twl4030.c
> =A0create mode 100644 arch/arm/mach-omap2/twl4030.h
>
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
