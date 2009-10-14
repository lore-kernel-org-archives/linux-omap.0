From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Wed, 14 Oct 2009 15:35:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB255500@dbde02.ent.ti.com>
References: <1255512629-14323-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49526 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbZJNKFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 06:05:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9EA54Dc026597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 05:05:07 -0500
In-Reply-To: <1255512629-14323-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

Charu,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Varadarajan, Charu Latha
> Sent: Wednesday, October 14, 2009 3:00 PM
> To: linux-omap@vger.kernel.org
> Cc: Varadarajan, Charu Latha; Syed, Rafiuddin
> Subject: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg access
> 
> omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
> McBSP registers as 16-bit registers.
> 
> The McBSP registers (DRR_REG and DXR_REG) are limited to
> 32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
> not allowed and can corrupt register content.
> 
> This patch modifies omap_mcbsp_pollwrite and
> omap_mcbsp_pollread functions to do 32 bit access for above
> mentioned McBSP registers. Data accepted by these
> functions is also modified to 32-bit.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
>  arch/arm/plat-omap/mcbsp.c              |   46 ++++++++++++++------------
> -----
>  2 files changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-
> omap/include/mach/mcbsp.h
> index 7e9cae3..05b0d8d 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -455,8 +455,8 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int
> id, u32 * word);
>  void omap_mcbsp_set_spi_mode(unsigned int id, const struct
> omap_mcbsp_spi_cfg * spi_cfg);
> 
>  /* Polled read/write functions */
> -int omap_mcbsp_pollread(unsigned int id, u16 * buf);
> -int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
> +int omap_mcbsp_pollread(unsigned int id, u32 *buf);
> +int omap_mcbsp_pollwrite(unsigned int id, u32 buf);
If the issue is with DRR_REG and DXR_REG, why are you changing the signature of the generic API. You can handle these registers as a exceptions in the code.
>  int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t
> io_type);
> 
>  #endif
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 88ac976..1f278a2 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -613,7 +613,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
>  EXPORT_SYMBOL(omap_mcbsp_stop);
> 
>  /* polled mcbsp i/o operations */
> -int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> +int omap_mcbsp_pollwrite(unsigned int id, u32 buf)
>  {
>  	struct omap_mcbsp *mcbsp;
>  	void __iomem *base;
> @@ -626,26 +626,24 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
>  	mcbsp = id_to_mcbsp_ptr(id);
>  	base = mcbsp->io_base;
> 
> -	writew(buf, base + OMAP_MCBSP_REG_DXR1);
> +	OMAP_MCBSP_WRITE(base, DXR, buf);
Why do you need this? Is writew()/readw() not doing 16 bit operations  ?
>  	/* if frame sync error - clear the error */
> -	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
> +	if (OMAP_MCBSP_READ(base, SPCR2) & XSYNC_ERR) {
>  		/* clear error */
> -		writew(readw(base + OMAP_MCBSP_REG_SPCR2) & (~XSYNC_ERR),
> -		       base + OMAP_MCBSP_REG_SPCR2);
> +		OMAP_MCBSP_WRITE(base, SPCR2, OMAP_MCBSP_READ(base , SPCR2)
> +					& (~XSYNC_ERR));
>  		/* resend */
>  		return -1;
>  	} else {
>  		/* wait for transmit confirmation */
>  		int attemps = 0;
> -		while (!(readw(base + OMAP_MCBSP_REG_SPCR2) & XRDY)) {
> +		while (!(OMAP_MCBSP_READ(base, SPCR2) & XRDY)) {
>  			if (attemps++ > 1000) {
> -				writew(readw(base + OMAP_MCBSP_REG_SPCR2) &
> -				       (~XRST),
> -				       base + OMAP_MCBSP_REG_SPCR2);
> +				OMAP_MCBSP_WRITE(base, SPCR2,
> +					OMAP_MCBSP_READ(base, SPCR2) & (~XRST));
>  				udelay(10);
> -				writew(readw(base + OMAP_MCBSP_REG_SPCR2) |
> -				       (XRST),
> -				       base + OMAP_MCBSP_REG_SPCR2);
> +				OMAP_MCBSP_WRITE(base, SPCR2,
> +					OMAP_MCBSP_READ(base, SPCR2) | (XRST));
>  				udelay(10);
>  				dev_err(mcbsp->dev, "Could not write to"
>  					" McBSP%d Register\n", mcbsp->id);
> @@ -658,7 +656,7 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
>  }
>  EXPORT_SYMBOL(omap_mcbsp_pollwrite);
> 
> -int omap_mcbsp_pollread(unsigned int id, u16 *buf)
> +int omap_mcbsp_pollread(unsigned int id, u32 *buf)
>  {
>  	struct omap_mcbsp *mcbsp;
>  	void __iomem *base;
> @@ -671,24 +669,22 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
> 
>  	base = mcbsp->io_base;
>  	/* if frame sync error - clear the error */
> -	if (readw(base + OMAP_MCBSP_REG_SPCR1) & RSYNC_ERR) {
> +	if (OMAP_MCBSP_READ(base, SPCR1) & RSYNC_ERR) {
>  		/* clear error */
> -		writew(readw(base + OMAP_MCBSP_REG_SPCR1) & (~RSYNC_ERR),
> -		       base + OMAP_MCBSP_REG_SPCR1);
> +		OMAP_MCBSP_WRITE(base, SPCR1, OMAP_MCBSP_READ(base, SPCR1)
> +					& (~RSYNC_ERR));
>  		/* resend */
>  		return -1;
>  	} else {
>  		/* wait for recieve confirmation */
>  		int attemps = 0;
> -		while (!(readw(base + OMAP_MCBSP_REG_SPCR1) & RRDY)) {
> -			if (attemps++ > 1000) {
> -				writew(readw(base + OMAP_MCBSP_REG_SPCR1) &
> -				       (~RRST),
> -				       base + OMAP_MCBSP_REG_SPCR1);
> +		while (!(OMAP_MCBSP_READ(base, SPCR1) & RRDY)) {
> +			if (attemps++ > 10000) {
> +				OMAP_MCBSP_WRITE(base, SPCR1,
> +					OMAP_MCBSP_READ(base, SPCR1) & (~RRST));
>  				udelay(10);
> -				writew(readw(base + OMAP_MCBSP_REG_SPCR1) |
> -				       (RRST),
> -				       base + OMAP_MCBSP_REG_SPCR1);
> +				OMAP_MCBSP_WRITE(base, SPCR1,
> +					OMAP_MCBSP_READ(base, SPCR1) | (RRST));
>  				udelay(10);
>  				dev_err(mcbsp->dev, "Could not read from"
>  					" McBSP%d Register\n", mcbsp->id);
> @@ -696,7 +692,7 @@ int omap_mcbsp_pollread(unsigned int id, u16 *buf)
>  			}
>  		}
>  	}
> -	*buf = readw(base + OMAP_MCBSP_REG_DRR1);
> +	*buf = OMAP_MCBSP_READ(base, DRR);
> 
>  	return 0;
>  }
> --
> 1.6.0.4


Regards,
Santosh
