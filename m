From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v6 1/1] OMAP2: Spi: Force CS to be in inactive state
 after off-mode transition
Date: Wed, 29 Dec 2010 00:28:00 -0700
Message-ID: <20101229072800.GF8172@angua.secretlab.ca>
References: <4D149045.8080801@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:45766 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab0L2H2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 02:28:04 -0500
Received: by iwn42 with SMTP id 42so5395004iwn.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Dec 2010 23:28:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D149045.8080801@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Dec 24, 2010 at 01:21:25PM +0100, Gregory CLEMENT wrote:
> When SPI wake up from OFF mode, CS is in the wrong state: force it to the inactive state.
> 
> During the system life, I monitored the CS behavior using a oscilloscope.
> I also activated debug in omap2_mcspi, so I saw when driver disable the clocks and restore context when device is not used.
> Each time the CS was in the correct state.
> It was only when system was put suspend to ram with off-mode activated that on resume the CS was in wrong state( ie activated).
> 
> Changelog:
> * Change from v1 to v2:
> Rebase on linus/master (after 2.6.37-rc1)
> Do some clean-up and fix indentation on both patches
> Add more explanations for patch 2
> 
> * Change from v2 to v3:
> Use directly resume function of spi_master instead of using function
> from spi_device as Grant Likely pointed it out.
> Force this transition explicitly for each CS used by a device.
> 
> * Change from v3 to v4:
> Patch clean-up according to Kevin Hilman and checkpatch.
> Now force CS to be in inactive state only if it was inactive when it was
> suspended.
> 
> * Change from v4 to v5:
> Rebase on linus/master (after 2.6.37-rc3)
> Collapse some lines as pointed by Grant Likely
> Fix a spelling
> 
> * Change from v5 to v6:
> Rebase on linus/master (after 2.6.37-rc7)
> Use CONFIG_SUSPEND instead of CONFIG_PM
> Didn't use legacy PM methods anymore. Instead, add a struct dev_pm_ops and add the resume method there.
> Fix multi-line comment style
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi Gregory,

Patch does not apply, but I cannot immediately isolate the damage.
Please see if you can figure out the issue on your end.  Is it your
mailer?  I could fudge it, but in the long run it is better if this
issue can get sorted out now.

Also, a few other minor nitpicks (I won't reject a patch over these,
but it helps to have them right):

Please prefix spi patch names with "spi[/driver]:".  It is the format
for all spi patches I take through my tree, and if it already follows
that convention, then I don't need to edit it manually.

Second, please keep the line length in the patch description short; in
general I find that a textwidth limit of 70 characters is about right
for the purpose of reading/replying in email.  A lot of maintainers
use text email clients like mutt in 80 column terminal windows.
Keeping a reasonable right hand margin in the text body is simply
friendly.

Finally, in changelogs it is easier to read if there is some kind of
itemization ticks.  For example:

* Change from v5 to v6:
  - Rebase on linus/master (after 2.6.37-rc7)
  - Use CONFIG_SUSPEND instead of CONFIG_PM
  - Didn't use legacy PM methods anymore. Instead, add a struct
    dev_pm_ops and add the resume method there.
  - Fix multi-line comment style
 
g.

> ---
>  drivers/spi/omap2_mcspi.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 2a651e6..a17ea97 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -1305,10 +1305,50 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:omap2_mcspi");
>  +#ifdef	CONFIG_SUSPEND
> +/*
> + * When SPI wake up from off-mode, CS is in activate state. If it was in
> + * unactive state when driver was suspend, then force it to unactive state at
> + * wake up.
> + */
> +static int omap2_mcspi_resume(struct device *dev)
> +{
> +	struct spi_master	*master = dev_get_drvdata(dev);
> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
> +	struct omap2_mcspi_cs *cs;
> +
> +	omap2_mcspi_enable_clocks(mcspi);
> +	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
> +			    node) {
> +		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
> +
> +			/*
> +			 * We need to toggle CS state for OMAP take this
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
> +static const struct dev_pm_ops omap2_mcspi_pm_ops = {
> +	.resume = omap2_mcspi_resume,
> +};
> +
>  static struct platform_driver omap2_mcspi_driver = {
>  	.driver = {
>  		.name =		"omap2_mcspi",
>  		.owner =	THIS_MODULE,
> +		.pm =		&omap2_mcspi_pm_ops
> +

Drop the extra line.

>  	},
>  	.remove =	__exit_p(omap2_mcspi_remove),
>  };
> -- 
> 1.7.0.4
> 
