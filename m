From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 02/19] ARM: OMAP4: PM: save/restore all CM1/2 settings in OFF mode
Date: Wed, 09 May 2012 16:27:31 -0700
Message-ID: <87ehqtexzw.fsf@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	<1334914432-26456-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38339 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758527Ab2EIX3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 19:29:14 -0400
Received: by pbbro8 with SMTP id ro8so1553562pbb.39
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 16:29:08 -0700 (PDT)
In-Reply-To: <1334914432-26456-3-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 20 Apr 2012 12:33:35 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Axel Haslam <axelhaslam@gmail.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Restore all CM1/2 module registers as they are lost in OFF mode.

Except they are still lost since nobody calls these new functions (in
this patch.)  :)

For ease of review, it's preferred to add the *users* of new code in the
same patch as the new code.

> [nm@ti.com: minor clean ups]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Axel Haslam <axelhaslam@gmail.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm44xx.c |  322 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/cm44xx.h |    2 +
>  2 files changed, 324 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
> index 535d66e..fb5465b 100644
> --- a/arch/arm/mach-omap2/cm44xx.c
> +++ b/arch/arm/mach-omap2/cm44xx.c
> @@ -21,8 +21,11 @@
>  #include "iomap.h"
>  #include "common.h"
>  #include "cm.h"
> +#include "cm44xx.h"
>  #include "cm1_44xx.h"
>  #include "cm2_44xx.h"
> +#include "cminst44xx.h"
> +#include "prcm44xx.h"
>  #include "cm-regbits-44xx.h"
>  
>  /* CM1 hardware module low-level functions */
> @@ -50,3 +53,322 @@ void omap4_cm2_write_inst_reg(u32 val, s16 inst, u16 reg)
>  {
>  	__raw_writel(val, OMAP44XX_CM2_REGADDR(inst, reg));
>  }
> +
> +#define MAX_CM_REGISTERS 51
> +
> +struct omap4_cm_reg {
> +	u16 offset;
> +	u32 val;
> +};
> +
> +struct omap4_cm_regs {
> +	u32 mod_off;
> +	u32 no_reg;

minor: do these need to be u32?

> +	struct omap4_cm_reg reg[MAX_CM_REGISTERS];
> +};
> +
> +static struct omap4_cm_regs cm1_regs[] = {
> +	/* OMAP4430_CM1_OCP_SOCKET_MOD */
> +	{ .mod_off = OMAP4430_CM1_OCP_SOCKET_INST, .no_reg = 1,
> +	{{.offset = OMAP4_CM_CM1_PROFILING_CLKCTRL_OFFSET} },

For readability sake, I'd prefer to see this line indented.  And why
the extra space before the final '}'}

> +	},

[...]

> +static void omap4_cm1_prepare_off(void)
> +{
> +	u32 i, j;
> +	struct omap4_cm_regs *cm_reg = cm1_regs;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm1_regs); i++, cm_reg++) {
> +		for (j = 0; j < cm_reg->no_reg; j++) {
> +			cm_reg->reg[j].val =
> +			    omap4_cminst_read_inst_reg(OMAP4430_CM1_PARTITION,
> +						       cm_reg->mod_off,
> +						       cm_reg->reg[j].offset);
> +		}
> +	}
> +}
> +
> +static void omap4_cm2_prepare_off(void)
> +{
> +	u32 i, j;
> +	struct omap4_cm_regs *cm_reg = cm2_regs;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm2_regs); i++, cm_reg++) {
> +		for (j = 0; j < cm_reg->no_reg; j++) {
> +			cm_reg->reg[j].val =
> +			    omap4_cminst_read_inst_reg(OMAP4430_CM2_PARTITION,
> +						       cm_reg->mod_off,
> +						       cm_reg->reg[j].offset);
> +		}
> +	}
> +}

> +static void omap4_cm1_resume_off(void)
> +{
> +	u32 i, j;
> +	struct omap4_cm_regs *cm_reg = cm1_regs;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm1_regs); i++, cm_reg++) {
> +		for (j = 0; j < cm_reg->no_reg; j++) {
> +			omap4_cminst_write_inst_reg(cm_reg->reg[j].val,
> +						    OMAP4430_CM1_PARTITION,
> +						    cm_reg->mod_off,
> +						    cm_reg->reg[j].offset);
> +		}
> +	}
> +}
> +
> +static void omap4_cm2_resume_off(void)
> +{
> +	u32 i, j;
> +	struct omap4_cm_regs *cm_reg = cm2_regs;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm2_regs); i++, cm_reg++) {
> +		for (j = 0; j < cm_reg->no_reg; j++) {
> +			omap4_cminst_write_inst_reg(cm_reg->reg[j].val,
> +						    OMAP4430_CM2_PARTITION,
> +						    cm_reg->mod_off,
> +						    cm_reg->reg[j].offset);
> +		}
> +	}
> +}

Notice the two prpare functions (and resume functions) are basically
identical, except for the partition.

How about adding a .partition field to the struct so there can be a
single function}

Kevin
