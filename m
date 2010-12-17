From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
Date: Fri, 17 Dec 2010 07:34:37 -0600
Message-ID: <4D0B66ED.8030302@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47980 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754425Ab0LQNem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 08:34:42 -0500
Received: by mail-yw0-f50.google.com with SMTP id 7so350645ywo.37
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 05:34:41 -0800 (PST)
In-Reply-To: <1292580506-4421-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> The SRAM PA addresses are locally defined and used at
> different places, i.e. SRAM management code and idle sleep code.
> 
> The macros are now defined at a centralized place, for
> easier maintenance.
> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/sdrc.h             |    1 -
>  arch/arm/mach-omap2/sleep34xx.S        |    1 +
>  arch/arm/plat-omap/include/plat/sram.h |   11 +++++++++++
>  arch/arm/plat-omap/sram.c              |    7 ++-----
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
> index 68f57bb..b3f8379 100644
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -74,5 +74,4 @@ static inline u32 sms_read_reg(u16 reg)
>   */
>  #define SDRC_MPURATE_LOOPS		96
>  
> -
spurious change.

[...]

> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 819ea0c..1a686c8 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -41,15 +41,12 @@
>  
>  #define OMAP1_SRAM_PA		0x20000000
>  #define OMAP1_SRAM_VA		VMALLOC_END
> -#define OMAP2_SRAM_PA		0x40200000
> -#define OMAP2_SRAM_PUB_PA	0x4020f800
> +#define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
>  #define OMAP2_SRAM_VA		0xfe400000
>  #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
> -#define OMAP3_SRAM_PA           0x40200000
>  #define OMAP3_SRAM_VA           0xfe400000
> -#define OMAP3_SRAM_PUB_PA       0x40208000
> +#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
Though not directly related to the patch, information sake: the PUB 
physical address on a GP device != public SRAM address on a HS/EMU 
device - in theory PPA can reconfigure how much is available for a 
HS/EMU device here.

>  #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> -#define OMAP4_SRAM_PA		0x40300000
>  #define OMAP4_SRAM_VA		0xfe400000
>  #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>  #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)

Tested-by: Nishanth Menon<nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933

-- 
Regards,
Nishanth Menon
