From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC 04/12] omap: mcbsp: Merge OMAP1 and OMAP2+ McBSP register definitions
Date: Mon, 4 Jul 2011 01:08:02 +0200
Message-ID: <201107040108.03317.jkrzyszt@tis.icnet.pl>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com> <1309510356-27147-5-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:42166 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab1GCXKD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 3 Jul 2011 19:10:03 -0400
In-Reply-To: <1309510356-27147-5-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, 1 Jul 2011 at 10:52:28 Jarkko Nikula wrote:
> There is no need to have separate register definitions for OMAP1
> since they are ordered similarly than in OMAP2+ and thus register
> address offsets can be calculated from OMAP2+ register address
> offsets.

Hi Jarkko,
This patch is missing a similiar change to the calculation of register 
address returned by omap_mcbsp_dma_reg_params(), rendering it broken on 
OMAP1. Otherwise, the whole series works for me on my Amstrad Delta. 

For me, it would be more elegant to redefine all these symbols as 
register serial numbers, not offsets, then multiply them by sub-platform 
specific register width to get their offsets, instead of having offsets 
already defined for one sub-platfrom only and mangle them to get correct 
values on others.

Anyway, with the omap_mcbsp_dma_reg_params() fixed to return correct 
address on OMAP1 as well, you can add my Tested-by: or Acked-by:, which 
one you find more appropriate.

Thanks,
Janusz

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   50
> ++++--------------------------- arch/arm/plat-omap/mcbsp.c          
>    |    2 +
>  2 files changed, 8 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h
> b/arch/arm/plat-omap/include/plat/mcbsp.h index 9882c65..6db02b3
> 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -51,54 +51,16 @@ static struct platform_device omap_mcbsp##port_nr
> = {	\ #define OMAP1610_MCBSP2_BASE	0xfffb1000
>  #define OMAP1610_MCBSP3_BASE	0xe1017000
> 
> -#ifdef CONFIG_ARCH_OMAP1
> -
> -#define OMAP_MCBSP_REG_DRR2	0x00
> -#define OMAP_MCBSP_REG_DRR1	0x02
> -#define OMAP_MCBSP_REG_DXR2	0x04
> -#define OMAP_MCBSP_REG_DXR1	0x06
> -#define OMAP_MCBSP_REG_DRR	0x02
> -#define OMAP_MCBSP_REG_DXR	0x06
> -#define OMAP_MCBSP_REG_SPCR2	0x08
> -#define OMAP_MCBSP_REG_SPCR1	0x0a
> -#define OMAP_MCBSP_REG_RCR2	0x0c
> -#define OMAP_MCBSP_REG_RCR1	0x0e
> -#define OMAP_MCBSP_REG_XCR2	0x10
> -#define OMAP_MCBSP_REG_XCR1	0x12
> -#define OMAP_MCBSP_REG_SRGR2	0x14
> -#define OMAP_MCBSP_REG_SRGR1	0x16
> -#define OMAP_MCBSP_REG_MCR2	0x18
> -#define OMAP_MCBSP_REG_MCR1	0x1a
> -#define OMAP_MCBSP_REG_RCERA	0x1c
> -#define OMAP_MCBSP_REG_RCERB	0x1e
> -#define OMAP_MCBSP_REG_XCERA	0x20
> -#define OMAP_MCBSP_REG_XCERB	0x22
> -#define OMAP_MCBSP_REG_PCR0	0x24
> -#define OMAP_MCBSP_REG_RCERC	0x26
> -#define OMAP_MCBSP_REG_RCERD	0x28
> -#define OMAP_MCBSP_REG_XCERC	0x2A
> -#define OMAP_MCBSP_REG_XCERD	0x2C
> -#define OMAP_MCBSP_REG_RCERE	0x2E
> -#define OMAP_MCBSP_REG_RCERF	0x30
> -#define OMAP_MCBSP_REG_XCERE	0x32
> -#define OMAP_MCBSP_REG_XCERF	0x34
> -#define OMAP_MCBSP_REG_RCERG	0x36
> -#define OMAP_MCBSP_REG_RCERH	0x38
> -#define OMAP_MCBSP_REG_XCERG	0x3A
> -#define OMAP_MCBSP_REG_XCERH	0x3C
> -
> -/* Dummy defines, these are not available on omap1 */
> -#define OMAP_MCBSP_REG_XCCR	0x00
> -#define OMAP_MCBSP_REG_RCCR	0x00
> -
> -#else
> -
> +/* McBSP register addresses. OMAP1 address = address definition / 2
> */ +/* OMAP1-OMAP2420 registers */
>  #define OMAP_MCBSP_REG_DRR2	0x00
>  #define OMAP_MCBSP_REG_DRR1	0x04
>  #define OMAP_MCBSP_REG_DXR2	0x08
>  #define OMAP_MCBSP_REG_DXR1	0x0C
> +/* OMAP2430 and onwards */
>  #define OMAP_MCBSP_REG_DRR	0x00
>  #define OMAP_MCBSP_REG_DXR	0x08
> +/* Common registers */
>  #define OMAP_MCBSP_REG_SPCR2	0x10
>  #define OMAP_MCBSP_REG_SPCR1	0x14
>  #define OMAP_MCBSP_REG_RCR2	0x18
> @@ -126,6 +88,7 @@ static struct platform_device omap_mcbsp##port_nr
> = {	\ #define OMAP_MCBSP_REG_RCERH	0x70
>  #define OMAP_MCBSP_REG_XCERG	0x74
>  #define OMAP_MCBSP_REG_XCERH	0x78
> +/* OMAP2430 and onwards */
>  #define OMAP_MCBSP_REG_SYSCON	0x8C
>  #define OMAP_MCBSP_REG_THRSH2	0x90
>  #define OMAP_MCBSP_REG_THRSH1	0x94
> @@ -138,6 +101,7 @@ static struct platform_device omap_mcbsp##port_nr
> = {	\ #define OMAP_MCBSP_REG_RBUFFSTAT	0xB8
>  #define OMAP_MCBSP_REG_SSELCR	0xBC
> 
> +/* OMAP3 sidetone control registers */
>  #define OMAP_ST_REG_REV		0x00
>  #define OMAP_ST_REG_SYSCONFIG	0x10
>  #define OMAP_ST_REG_IRQSTATUS	0x18
> @@ -146,8 +110,6 @@ static struct platform_device omap_mcbsp##port_nr
> = {	\ #define OMAP_ST_REG_SFIRCR	0x28
>  #define OMAP_ST_REG_SSELCR	0x2C
> 
> -#endif
> -
>  /************************** McBSP SPCR1 bit definitions
> ***********************/ #define RRST			0x0001
>  #define RRDY			0x0002
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 6c62af1..a7ced1b 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -37,6 +37,7 @@ int omap_mcbsp_count, omap_mcbsp_cache_size;
>  static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32
> val) {
>  	if (cpu_class_is_omap1()) {
> +		reg /= 2;
>  		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
>  		__raw_writew((u16)val, mcbsp->io_base + reg);
>  	} else if (cpu_is_omap2420()) {
> @@ -51,6 +52,7 @@ static void omap_mcbsp_write(struct omap_mcbsp
> *mcbsp, u16 reg, u32 val) static int omap_mcbsp_read(struct
> omap_mcbsp *mcbsp, u16 reg, bool from_cache) {
>  	if (cpu_class_is_omap1()) {
> +		reg /= 2;
>  		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
>  				((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)];
>  	} else if (cpu_is_omap2420()) {

