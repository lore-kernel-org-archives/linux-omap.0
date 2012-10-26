From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 06/14] mtd: onenand: omap: use pdata info instead of
 cpu_is
Date: Fri, 26 Oct 2012 09:40:06 -0700
Message-ID: <20121026164005.GD11908@atomide.com>
References: <cover.1349672877.git.afzal@ti.com>
 <860ba92c34cbb490beccd5442087087c1751a6a2.1349672877.git.afzal@ti.com>
 <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45184 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965389Ab2JZQkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 12:40:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210260146270.11251@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Afzal Mohammed <afzal@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>, Jon Hunter <jon-hunter@ti.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121025 18:50]:
> Hi Afzal
> 
> On Mon, 8 Oct 2012, Afzal Mohammed wrote:
> 
> > platform data now contains a field to indicate whether
> > soc belongs to omap34xx family, use it instead of
> > cpu_is_* check.
> > 
> > This helps in removing dependency of platform specific
> > header file - cpu.h
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> 
> This one breaks an N800 multi-OMAP build here:
> 
>   LD      init/built-in.o
> drivers/built-in.o: In function `omap2_onenand_probe':
> /home/paul/linux-bisect/drivers/mtd/onenand/omap2.c:788: undefined 
> reference to `omap3_onenand_read_bufferram'
> /home/paul/linux-bisect/drivers/mtd/onenand/omap2.c:788: undefined 
> reference to `omap3_onenand_write_bufferram'
> make: *** [vmlinux] Error 1
> 
> A fix is below.

If you can add this too into your fixes branch on top of
omap-for-v3.8/cleanup-headers that would be nice.

Regards,

Tony

> ---
>  drivers/mtd/onenand/omap2.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 53069ae..f87cf39 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -445,13 +445,19 @@ out_copy:
>  
>  #else
>  
> -int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -				 unsigned char *buffer, int offset,
> -				 size_t count);
> +static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> +					unsigned char *buffer, int offset,
> +					size_t count)
> +{
> +	return -ENOSYS;
> +}
>  
> -int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -				  const unsigned char *buffer,
> -				  int offset, size_t count);
> +static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> +					 const unsigned char *buffer,
> +					 int offset, size_t count)
> +{
> +	return -ENOSYS;
> +}
>  
>  #endif
>  
> -- 
> 1.7.10.4
> 
