From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 2/3] MMC: OMAP: Fix omap to use MMC_POWER_ON
Date: Tue, 24 Apr 2007 16:49:46 -0400
Message-ID: <462E6D6A.9050402@indt.org.br>
References: <462E6A79.4080409@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <462E6A79.4080409@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "linux >> omap-linux" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi folks,

Please, discard this e-mail. I've sent to the wrong mailing list.

Sorry for this.

Thanks,

Carlos.

ext Carlos Aguiar wrote:
> ------------------------------------------------------------------------
>
> As discussed earlier on LKML:
>
> http://lkml.org/lkml/2006/5/4/44
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Index: linux-2.6.20/drivers/mmc/omap.c
> ===================================================================
> --- linux-2.6.20.orig/drivers/mmc/omap.c	2007-04-24 15:22:12.000000000 -0400
> +++ linux-2.6.20/drivers/mmc/omap.c	2007-04-24 15:22:15.000000000 -0400
> @@ -970,8 +970,10 @@ static void mmc_omap_set_ios(struct mmc_
>  		mmc_omap_power(host, 0);
>  		break;
>  	case MMC_POWER_UP:
> -	case MMC_POWER_ON:
> +		/* Cannot touch dsor yet, just power up MMC */
>  		mmc_omap_power(host, 1);
> +		return;
> +	case MMC_POWER_ON:
>  		dsor |= 1 << 11;
>  		break;
>  	}
> @@ -987,7 +989,7 @@ static void mmc_omap_set_ios(struct mmc_
>  	 * Writing to the CON register twice seems to do the trick. */
>  	for (i = 0; i < 2; i++)
>  		OMAP_MMC_WRITE(host, CON, dsor);
> -	if (ios->power_mode == MMC_POWER_UP) {
> +	if (ios->power_mode == MMC_POWER_ON) {
>  		/* Send clock cycles, poll completion */
>  		OMAP_MMC_WRITE(host, IE, 0);
>  		OMAP_MMC_WRITE(host, STAT, 0xffff);
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
