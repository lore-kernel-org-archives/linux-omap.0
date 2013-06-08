From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/14] ARM: OMAP5: CM: Add OMAP54XX register and bitfield
 files
Date: Sat, 8 Jun 2013 17:54:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306081749140.7001@utopia.booyaka.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51993 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab3FHRy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 13:54:29 -0400
In-Reply-To: <1369845494-30231-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Wed, 29 May 2013, Santosh Shilimkar wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> Add the new defines for OMAP54XX cm registers.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> [santosh.shilimkar@ti.com: Generated es2.0 data]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

...

> diff --git a/arch/arm/mach-omap2/cm1_54xx.h b/arch/arm/mach-omap2/cm1_54xx.h
> new file mode 100644
> index 0000000..7b1f3b6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm1_54xx.h

...

> +
> +/* Function prototypes */
> +extern u32 omap4_cm1_read_inst_reg(s16 inst, u16 idx);
> +extern void omap4_cm1_write_inst_reg(u32 val, s16 inst, u16 idx);
> +extern u32 omap4_cm1_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);

No need for these since they're already prototyped in a common
file in your earlier patch set.

> diff --git a/arch/arm/mach-omap2/cm2_54xx.h b/arch/arm/mach-omap2/cm2_54xx.h
> new file mode 100644
> index 0000000..bab76bd
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm2_54xx.h
> @@ -0,0 +1,394 @@

...

> +/* Function prototypes */
> +extern u32 omap4_cm2_read_inst_reg(s16 inst, u16 idx);
> +extern void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 idx);
> +extern u32 omap4_cm2_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);

No need for these since they're already prototyped in a common
file in your earlier patch set.

Fixed in the local copy here.


- Paul
