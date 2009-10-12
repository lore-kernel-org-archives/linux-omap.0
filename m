From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/1] Runtime detection of OMAP35x variants
Date: Mon, 12 Oct 2009 10:28:54 -0700
Message-ID: <20091012172854.GH12700@atomide.com>
References: <1255117622-28054-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65296 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348AbZJLR3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 13:29:40 -0400
Content-Disposition: inline
In-Reply-To: <1255117622-28054-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [091009 12:54]:
> This patch allows run-time detection of different
> variants in the OMAP35x family.
> 
>   [1] http://marc.info/?l=linux-omap&m=125387617812499&w=2
>   
> This patch was been created against omap3-upstream at:
>   21f1a8f : omap: Include bitops from cpu.h
> 
> The testing was done on OMAP3EVM boards with these silicon
> revisions - ES2.0, ES2.1, ES3.0 and ES3.1.
> 
> Correctness against ES1.0 and a variant of ES2.0 was verified
> by 'simulation' described in the test summary below:

Great, thanks for doing these checks!

Tony

> 
> 1) ES 3.1
> 
>    Value of IDCODE register in u-boot:
>         OMAP3_EVM # md 4830a204 4
>         4830a204: 4b7ae02f 00000000 00000008 000000f0    /.zK............
>                  ^^^
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES3.1
>         ...
> 
> 2) ES 3.0
> 
>    Value of IDCODE register in u-boot:
>         OMAP3_EVM # md 4830a204 4
>         4830a204: 3b7ae02f 00000000 00000000 000000f0    /.z;............
>                  ^^^
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES3.0
>         ...
> 
> 3) ES 2.1
> 
>    Value of IDCODE register in u-boot:
>         OMAP3_EVM # md 4830a204 4
>         4830a204: 2b7ae02f 00000000 00000000 000000f0    /.z+............
>                  ^^^
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES2.1
>         ...
> 
> 4) ES 2.0 (simulated)
> 
>    The code correctness was verified by 'simulating' an ES 1.0 device
>    as shown in the diff below:
>      -  idcode = read_tap_reg(OMAP_TAP_IDCODE);
>      +  idcode = (u32)0x1b7ae02f;
>         hawkeye = (idcode >> 12) & 0xffff;
> 
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES2.0
>         ...
> 
> 5) ES 2.0
> 
>    Value of IDCODE register in u-boot:
>         OMAP3_EVM # md 4830a204 4
>         4830a204: 0b7ae02f 00000000 00000000 000000f0    /.z.............
>                  ^^^
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES2.0
>         ...
> 
> 6) ES 1.0 (simulated)
> 
>    The code correctness was verified by 'simulating' an ES 1.0 device
>    as shown in the diff below:
> 
>         cpuid = read_cpuid(CPUID_ID);
>         if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
>                 omap_revision = OMAP3430_REV_ES1_0;
>                 return;
>         }
>      +  omap_revision = OMAP3430_REV_ES1_0;
>      +  return;
> 
>    Print during boot-up:
>         ...
>         Memory policy: ECC disabled, Data cache writeback
>         OMAP3430/3530 ES1.0
>         ...
> 
> Sanjeev Premi (1):
>   Runtime detection of OMAP35x devices
> 
>  arch/arm/mach-omap2/id.c              |   65 +++++++++++++++++++++++++++------
>  arch/arm/plat-omap/include/mach/cpu.h |   37 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 11 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
