From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make ALSA omap-aic23.c compile again
Date: Fri, 20 Jan 2006 11:04:16 -0800
Message-ID: <20060120190415.GG4431@atomide.com>
References: <43CD3B51.80105@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CD3B51.80105@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@de.bosch.com> [060117 10:51]:
> 
> ARM: OMAP: Remove errors and warnings and make omap-aic23.c compile again:
> 
> sound/arm/omap-aic23.c:661: error: structure has no member named
> `pm_private_data'
> sound/arm/omap-aic23.c:680: error: structure has no member named
> `pm_private_data'
> sound/arm/omap-aic23.c:772: warning: implicit declaration of function
> `clk_get_usecount'
> sound/arm/omap-aic23.c:863: warning: implicit declaration of function
> `snd_card_set_pm_callback'
> 
> Note: Needs "Fix clk_get_usecount() warning" patch
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>
> 

> --- ./sound/arm/omap-aic23.c_orig	2006-01-17 19:26:00.707889264 +0100
> +++ ./sound/arm/omap-aic23.c	2006-01-17 19:38:02.260196640 +0100
> @@ -59,6 +59,7 @@
>  #include <asm/arch/dma.h>
>  #include <asm/arch/aic23.h>
>  #include <asm/arch/mcbsp.h>
> +#include <asm/arch/clock.h>
>  
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> @@ -658,7 +659,7 @@ static int __init snd_card_omap_aic23_pc
>  
>  static int snd_omap_aic23_suspend(snd_card_t * card, pm_message_t state)
>  {
> -	struct snd_card_omap_aic23 *chip = card->pm_private_data;
> +	struct snd_card_omap_aic23 *chip = card->private_data;
>  	ADEBUG();
>  
>  	if (chip->card->power_state != SNDRV_CTL_POWER_D3hot) {
> @@ -677,7 +678,7 @@ static int snd_omap_aic23_suspend(snd_ca
>   */
>  static int snd_omap_aic23_resume(snd_card_t * card)
>  {
> -	struct snd_card_omap_aic23 *chip = card->pm_private_data;
> +	struct snd_card_omap_aic23 *chip = card->private_data;
>  	ADEBUG();
>  	
>  	if (chip->card->power_state != SNDRV_CTL_POWER_D0) {
> @@ -860,14 +861,13 @@ static int __init snd_omap_aic23_probe(s
>  	if ((err = snd_card_omap_aic23_pcm(omap_aic23, 0)) < 0)
>  		goto nodev;
>  
> -	snd_card_set_pm_callback(card, snd_omap_aic23_suspend,
> -				 snd_omap_aic23_resume, omap_aic23);
> -
>  	strcpy(card->driver, "AIC23");
>  	strcpy(card->shortname, "OSK AIC23");
>  	sprintf(card->longname, "OMAP OSK with AIC23");
>  
>  	snd_omap_init_mixer();
> +
> +	snd_card_set_dev(card, &pdev->dev);
>  	
>  	if ((err = snd_card_register(card)) == 0) {
>  		printk(KERN_INFO "OSK audio support initialized\n");
> 

And pushing this one too.

Tony
