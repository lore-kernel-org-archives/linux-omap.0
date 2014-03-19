From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 24/62] ARM: omap1: select I2C where needed for PMIC
Date: Wed, 19 Mar 2014 14:04:42 -0700
Message-ID: <20140319210441.GC8333@atomide.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-25-git-send-email-arnd@arndb.de>
 <20140319204619.GB8333@atomide.com>
 <19769201.1MOf3JVGbC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25872 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755574AbaCSVEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 17:04:51 -0400
Content-Disposition: inline
In-Reply-To: <19769201.1MOf3JVGbC@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [140319 14:01]:
> On Wednesday 19 March 2014 13:46:19 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [140319 12:33]:
> > > The OMAP H2, OSK and OSIRIS machines cannot build without
> > > I2C and TPS65010 both enabled unconditionally.
> > > 
> > > In each case, failing to enable CONFIG_I2C results in a
> > > build or link error, so most consistent solution is to
> > > ensure that it is impossible to disable those options.
> > > 
> > > It would be nice to leave CONFIG_I2C as user-selectable,
> > > but doing that properly would require more work.
> > 
> > We should not select drivers. How about let's just have
> > the tps65010 stuff behind an ifdef CONFIG_TPS65010 for
> > those boards?
> 
> Good idea. Like this?

Looks good to me :)

Acked-by: Tony Lindgren <tony@atomide.com>
 
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> index fd90caf..65d2acb 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -318,6 +318,9 @@ static void __init h2_init_smc91x(void)
>  
>  static int tps_setup(struct i2c_client *client, void *context)
>  {
> +	if (!IS_BUILTIN(CONFIG_TPS65010))
> +		return -ENOSYS;
> +	
>  	tps65010_config_vregs1(TPS_LDO2_ENABLE | TPS_VLDO2_3_0V |
>  				TPS_LDO1_ENABLE | TPS_VLDO1_3_0V);
>  
> diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
> index d68909b..3a02621 100644
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -191,6 +191,9 @@ static struct platform_device osk5912_tps_leds = {
>  
>  static int osk_tps_setup(struct i2c_client *client, void *context)
>  {
> +	if (!IS_BUILTIN(CONFIG_TPS65010))
> +		return -ENOSYS;
> +
>  	/* Set GPIO 1 HIGH to disable VBUS power supply;
>  	 * OHCI driver powers it up/down as needed.
>  	 */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
