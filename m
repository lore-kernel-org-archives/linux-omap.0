From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Wed, 29 Dec 2010 10:01:11 +0100
Message-ID: <4D1AF8D7.6060904@free-electrons.com>
References: <4D149045.8080801@free-electrons.com> <20101229072800.GF8172@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49246 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0L2JBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Dec 2010 04:01:25 -0500
In-Reply-To: <20101229072800.GF8172@angua.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>

> Hi Gregory,
> 
Hi Grant,

> Patch does not apply, but I cannot immediately isolate the damage.
> Please see if you can figure out the issue on your end.  Is it your
> mailer?  I could fudge it, but in the long run it is better if this
> issue can get sorted out now.
> 

I found the problem: see below in the patch itself.

> Also, a few other minor nitpicks (I won't reject a patch over these,
> but it helps to have them right):
> 
> Please prefix spi patch names with "spi[/driver]:".  It is the format
> for all spi patches I take through my tree, and if it already follows
> that convention, then I don't need to edit it manually.
> 
> Second, please keep the line length in the patch description short; in
> general I find that a textwidth limit of 70 characters is about right
> for the purpose of reading/replying in email.  A lot of maintainers
> use text email clients like mutt in 80 column terminal windows.
> Keeping a reasonable right hand margin in the text body is simply
> friendly.
> 
> Finally, in changelogs it is easier to read if there is some kind of
> itemization ticks.  For example:
> 
> * Change from v5 to v6:
>   - Rebase on linus/master (after 2.6.37-rc7)
>   - Use CONFIG_SUSPEND instead of CONFIG_PM
>   - Didn't use legacy PM methods anymore. Instead, add a struct
>     dev_pm_ops and add the resume method there.
>   - Fix multi-line comment style
>  

I will fix these (patch prefix, wrapping and itemization ticks) and send the patch again today.

> g.
> 
>> ---
>>  drivers/spi/omap2_mcspi.c |   40 ++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 40 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index 2a651e6..a17ea97 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -1305,10 +1305,50 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>>  /* work with hotplug and coldplug */
>>  MODULE_ALIAS("platform:omap2_mcspi");
>>  +#ifdef	CONFIG_SUSPEND
   ^
   |
Problem was here, I deleted a carrier in error :(

>> +/*
>> + * When SPI wake up from off-mode, CS is in activate state. If it was in
>> + * unactive state when driver was suspend, then force it to unactive state at
>> + * wake up.
>> + */
>> +static int omap2_mcspi_resume(struct device *dev)
>> +{
>> +	struct spi_master	*master = dev_get_drvdata(dev);
>> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
>> +	struct omap2_mcspi_cs *cs;
>> +
>> +	omap2_mcspi_enable_clocks(mcspi);
>> +	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
>> +			    node) {
>> +		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
>> +
>> +			/*
>> +			 * We need to toggle CS state for OMAP take this
>> +			 * change in account.
>> +			 */
>> +			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 1);
>> +			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
>> +			MOD_REG_BIT(cs->chconf0, OMAP2_MCSPI_CHCONF_FORCE, 0);
>> +			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
>> +		}
>> +	}
>> +	omap2_mcspi_disable_clocks(mcspi);
>> +	return 0;
>> +}
>> +#else
>> +#define	omap2_mcspi_resume	NULL
>> +#endif
>> +
>> +static const struct dev_pm_ops omap2_mcspi_pm_ops = {
>> +	.resume = omap2_mcspi_resume,
>> +};
>> +
>>  static struct platform_driver omap2_mcspi_driver = {
>>  	.driver = {
>>  		.name =		"omap2_mcspi",
>>  		.owner =	THIS_MODULE,
>> +		.pm =		&omap2_mcspi_pm_ops
>> +
> 
> Drop the extra line.
> 
>>  	},
>>  	.remove =	__exit_p(omap2_mcspi_remove),
>>  };
>> -- 
>> 1.7.0.4
>>


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
