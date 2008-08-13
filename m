From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Wed, 13 Aug 2008 16:57:25 +0300
Message-ID: <20080813135721.GC27446@atomide.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62178 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbYHMNzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 09:55:33 -0400
Content-Disposition: inline
In-Reply-To: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hunter, Jon <jon-hunter@ti.com> [080813 06:08]:
> Move OMAP_MCBSP_READ and OMAP_MCBSP_WRITE macro definitions from arch/arm/plat-omap/mcbsp.c to include/asm-arm/arch-omap/mcbsp.h.

Let's rather get rid of the direct mcbsp register tinkering from drivers
and use following instead:

$ grep EXPORT arch/arm/plat-omap/mcbsp.c
EXPORT_SYMBOL(omap_mcbsp_config);
EXPORT_SYMBOL(omap_mcbsp_set_io_type);
EXPORT_SYMBOL(omap_mcbsp_request);
EXPORT_SYMBOL(omap_mcbsp_free);
EXPORT_SYMBOL(omap_mcbsp_start);
EXPORT_SYMBOL(omap_mcbsp_stop);
EXPORT_SYMBOL(omap_mcbsp_pollwrite);
EXPORT_SYMBOL(omap_mcbsp_pollread);
EXPORT_SYMBOL(omap_mcbsp_xmit_word);
EXPORT_SYMBOL(omap_mcbsp_recv_word);
EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);
EXPORT_SYMBOL(omap_mcbsp_recv_buffer);
EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);

If something is missing, let's add a function for it to mcbsp.c.

And, really the best solution would be to add support to
sound/soc/omap/ for various codecs rather than try to keep
the old drivers working.

Tony


> 
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/plat-omap/mcbsp.c        |    5 -----
>  include/asm-arm/arch-omap/mcbsp.h |    8 ++++++++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 70944a5..214136e 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -46,11 +46,6 @@ int omap_mcbsp_read(u32 io_base, u16 reg)
>                 return __raw_readl(io_base + reg);
>  }
> 
> -#define OMAP_MCBSP_READ(base, reg) \
> -                       omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
> -#define OMAP_MCBSP_WRITE(base, reg, val) \
> -                       omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
> -
>  #define omap_mcbsp_check_valid_id(id)  (id < omap_mcbsp_count)
>  #define id_to_mcbsp_ptr(id)            mcbsp_ptr[id];
> 
> diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
> index 8fa89c2..cf39ef1 100644
> --- a/include/asm-arm/arch-omap/mcbsp.h
> +++ b/include/asm-arm/arch-omap/mcbsp.h
> @@ -50,6 +50,14 @@
>  #define OMAP34XX_MCBSP4_BASE   0x49026000
>  #define OMAP34XX_MCBSP5_BASE   0x48096000
> 
> +void omap_mcbsp_write(u32 io_base, u16 reg, u32 val);
> +int omap_mcbsp_read(u32 io_base, u16 reg);
> +
> +#define OMAP_MCBSP_READ(base, reg) \
> +                       omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
> +#define OMAP_MCBSP_WRITE(base, reg, val) \
> +                       omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
> +
>  #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)
> 
>  #define OMAP_MCBSP_REG_DRR2    0x00
> --
> 1.4.4.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
