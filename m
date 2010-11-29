From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Mon, 29 Nov 2010 18:03:29 +0100
Message-ID: <4CF3DCE1.3030007@free-electrons.com>
References: <4CED8F6E.3000808@free-electrons.com> <877hfw1a6a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:34542 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab0K2RDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:03:39 -0500
In-Reply-To: <877hfw1a6a.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>

On 11/29/2010 03:22 PM, Kevin Hilman wrote:
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
>> As request by Grant Likely, there is no more cover letter. Full changelog is following.
>> I am still reluctant to add this changelog in the patch description, as it adds no value to
>> the patch itself: when it was needed I try to updat comments or patch description.
>> I understand that Grant Likely would need an ack from other user as this patch fix a corner case.
>> Kevin Hilman made a few comments on this patch so he could add his "Ack by" or at least his "Review by".
> 
> A couple more comments...
> 
>>
>> Changelog:
>> * Change from v1 to v2:
>> Rebase on linus/master (after 2.6.37-rc1)
>> Do some clean-up and fix indentation on both patches
>> Add more explanations for patch 2
>>
>> * Change from v2 to v3:
>> Use directly resume function of spi_master instead of using function
>> from spi_device as Grant Likely pointed it out.
>> Force this transition explicitly for each CS used by a device.
>>
>> * Change from v3 to v4:
>> Patch clean-up according to Kevin Hilman and checkpatch.
>> Now force CS to be in inactive state only if it was inactive when it was
>> suspended.
>>
>> * Change from v4 to v5:
>> Rebase on linus/master (after 2.6.37-rc3)
>> Collapse some lines as pointed by Grant Likely
>> Fix a spelling
>>
>>
>> == CUT HERE ==
>> When SPI wake up from OFF mode, CS is in the wrong state: force it to the inactive state.
>>
>> During the system life, I monitored the CS behavior using a oscilloscope.
>> I also activated debug in omap2_mcspi, so I saw when driver disable the clocks and restore context when device is not used.
>> Each time the CS was in the correct state.
>> It was only when system was put suspend to ram with off-mode activated that on resume the CS was in wrong state( ie activated).
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/spi/omap2_mcspi.c |   33 +++++++++++++++++++++++++++++++++
>>  1 files changed, 33 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index 2a651e6..dcc024a 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -1305,11 +1305,44 @@ static int __exit omap2_mcspi_remove(struct platform_device *pdev)
>>  /* work with hotplug and coldplug */
>>  MODULE_ALIAS("platform:omap2_mcspi");
>>
>> +#ifdef	CONFIG_PM
> 
> You should use CONFIG_SUSPEND here

OK I will do this.

> 
>> +/* When SPI wake up from off-mode, CS is in activate state. If it was in
>> + * unactive state when driver was suspend, then force it to unactive state at
>> + * wake up.
>> + */
>> +static int omap2_mcspi_resume(struct platform_device *pdev)
>> +{
>> +	struct spi_master	*master = dev_get_drvdata(&pdev->dev);
>> +	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
>> +	struct omap2_mcspi_cs *cs;
>> +
>> +	omap2_mcspi_enable_clocks(mcspi);
>> +	list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_num - 1].cs,
>> +			    node) {
>> +		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
>> +
>> +			/* We need to toggle CS state for OMAP take this
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
>>  static struct platform_driver omap2_mcspi_driver = {
>>  	.driver = {
>>  		.name =		"omap2_mcspi",
>>  		.owner =	THIS_MODULE,
>>  	},
>> +	.resume =	omap2_mcspi_resume,
> 
> This is adding legacy PM methods.  Instead, you should add a struct
> dev_pm_ops and add the resume method there.

OK, I shouldn't copy and paste an old driver!
Thanks for your advices.

> 
> Kevin
> 
>>  	.remove =	__exit_p(omap2_mcspi_remove),
>>  };
>>  -- 1.7.0.4


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
