From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Wed, 25 Apr 2012 13:44:56 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FDC71@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab2DYNpG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 09:45:06 -0400
In-Reply-To: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 30, 2012 at 21:33:51, Hiremath, Vaibhav wrote:
> After some healthy discussion, now we have come to the conclusion and
> decided to handle AM33XX PRM/CM part separately; as AM33XX-PRCM module is
> different than OMAP3 and OMAP4 architecture.
> 
> The difference becomes very interesting/weird when it comes to
> the consistency for register offsets in PRM address space and
> bit-field offsets inside PRM registers,
> So along with Powerdomain data and PRM api's required for AM33XX
> device, this patch series adds,
> 
>  - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
>  - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
>  - Logicretstate and mem_on/ret/pwrst/retst mask to "struct
>    powerdomain"
> 
> Testing: This patch series has been boot tested on AM37xEVM and AM335x
>          based BeagleBone community board.
> 
> Thanks to Paul here...for helping and concluding on this,
> shortly I will submit similar patch for CM, clockdomain and clock-tree
> support for AM33xx.
> 
> This patch-series is created on top of "linux-omap/cleanup" branch, and
> also gets applied to "linux-omap/master" branch.
> The patches are also available at -
> https://github.com/hvaibhav/am335x-linux/tree/am335x-prm-cm
> 
> Changes from previous versions:
> ===============================
> From V3:
> 	- No code change, only added Voltagedomain patch (from V2 series)
> 	  to this series.
> 
> From V1 & V2:
>     	- Rolled back to my original approach, where AM33xx
> 	  device was handled separately (RFC version).
> 	- As per Paul's comments, added Register offsets & bit-fields
> 	  masks.
> 
> Vaibhav Hiremath (4):
>   ARM: OMAP3+: am33xx: Add voltage domain data
>   ARM: OMAP3/4: omap_hwmod: Add rstst_off field to struct
>     omap_hwmod_omap4_prcm
>   ARM: OMAP2+: powerdomain: Add offset & mask fields to struct
>     powerdomain
>   ARM: OMAP3+: am33xx: Add powerdomain & PRM support
> 
>  arch/arm/mach-omap2/Makefile                  |    6 +
>  arch/arm/mach-omap2/io.c                      |    2 +
>  arch/arm/mach-omap2/omap_hwmod.c              |   32 ++-
>  arch/arm/mach-omap2/powerdomain.h             |   23 ++-
>  arch/arm/mach-omap2/powerdomain33xx.c         |  230 ++++++++++++++++
>  arch/arm/mach-omap2/powerdomains33xx_data.c   |  185 +++++++++++++
>  arch/arm/mach-omap2/prm-regbits-33xx.h        |  357 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/prm33xx.c                 |  134 +++++++++
>  arch/arm/mach-omap2/prm33xx.h                 |  129 +++++++++
>  arch/arm/mach-omap2/voltage.h                 |    1 +
>  arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 +++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
>  12 files changed, 1139 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
>  create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
>  create mode 100644 arch/arm/mach-omap2/prm33xx.c
>  create mode 100644 arch/arm/mach-omap2/prm33xx.h
>  create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
> 
> 

Tony, Paul and Kevin,

Any comments on this patch series?

Thanks,
Vaibhav
