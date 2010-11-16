From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 1/1] OMAP2: Spi: Force CS to be in inactive state
 after off-mode transition
Date: Tue, 16 Nov 2010 00:54:34 -0700
Message-ID: <20101116075434.GG4074@angua.secretlab.ca>
References: <4CDDD16A.5070200@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56889 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118Ab0KPHyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 02:54:37 -0500
Received: by pzk28 with SMTP id 28so51312pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 23:54:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDDD16A.5070200@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

On Sat, Nov 13, 2010 at 12:44:42AM +0100, Gregory CLEMENT wrote:
> When SPI wake up from OFF mode, CS is in the wrong state: force it
> to the inactive state.
> 
> During the system life, I monitored the CS behavior using a oscilloscope.
> I also activated debug in omap2_mcspi, so I saw when driver disable
> the clocks and restore context when device is not used.
> Each time the CS was in the correct state.
> It was only when system was put suspend to ram with off-mode
> activated that on resume the CS was in wrong state( ie activated).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Looks okay to me, but I'd like to get an ack from other users before I
merge it.  Also some minor comments below.

> ---
>  drivers/spi/omap2_mcspi.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 2a651e6..43d92fc 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -1305,11 +1305,46 @@ static int __exit omap2_mcspi_remove(struct
> platform_device *pdev)
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:omap2_mcspi");
>  +#ifdef	CONFIG_PM
> +/* When SPI wake up from off-mode, CS is in activate state. If it was in
> + * unactive state when driver was suspend, then force it to
> unactive state at

Patch is line-wrap damaged.  Check your mailer configuration.

> + * wake up.
> + */
> +static int omap2_mcspi_resume(struct platform_device *pdev)
> +{
> +	struct spi_master	*master;
> +	struct omap2_mcspi_cs *cs;
> +	struct omap2_mcspi	*mcspi;
> +
> +	master = dev_get_drvdata(&pdev->dev);
> +	mcspi = spi_master_get_devdata(master);

These 5 lines can be collapsed a bit:
	struct spi_master *master = dev_get_drvdata(&pdev->dev);
	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
	struct omap2_mcspi_cs *cs;

> +	omap2_mcspi_enable_clocks(mcspi);
> +	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
> +			    node) {
> +		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
> +
> +			/* We need to togle CS state for OMAP take this

spelling.  s/togle/toggle

> +			 * change in account.
> +			 */
> +			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 1);
> +			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
> +			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 0);
> +			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
> +		}
> +	}
> +	omap2_mcspi_disable_clocks(mcspi);
> +	return 0;
> +}
> +#else
> +#define	omap2_mcspi_resume	NULL
> +#endif
> +
>  static struct platform_driver omap2_mcspi_driver = {
>  	.driver = {
>  		.name =		"omap2_mcspi",
>  		.owner =	THIS_MODULE,
>  	},
> +	.resume =	omap2_mcspi_resume,
>  	.remove =	__exit_p(omap2_mcspi_remove),
>  };
>  -- 1.7.0.4
> 
