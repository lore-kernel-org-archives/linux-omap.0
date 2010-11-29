From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Mon, 29 Nov 2010 17:59:48 +0100
Message-ID: <4CF3DC04.70009@free-electrons.com>
References: <4CED8F6E.3000808@free-electrons.com> <87y68i447o.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:50326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab0K2RAA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:00:00 -0500
In-Reply-To: <87y68i447o.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>

On 11/25/2010 01:49 AM, Kevin Hilman wrote:
> This bit of meta-description and changelog should go after the '---'
> just after your signoff.  That way, git tools can still auto-apply the
> email, and git ignores stuff after the '---' so it doesn't end up in the
> git history.

Thanks for the advice

>> I understand that Grant Likely would need an ack from other user as this patch fix a corner case.
>> Kevin Hilman made a few comments on this patch so he could add his "Ack by" or at least his "Review by".
> 
> I haven't actually tested it, only reviewed it, so you can add a
> Reviewed by for me, but I'm not SPI-aware enough to ack this patch or
> test it thoroughly.  Also,  I have some more comments below...

Thanks I will add it in my next version.

> Also, in the last patch I suggested you do more of a save/restore of
> this value instead of a restore to a hard-coded value.  IOW, save the
> value in the suspend method, restore it in resume. I thought you had
> agreed to that.  I'm not an SPI expert, so not sure if it makes sense,
> but it seems more robust that way and more future proof.

Well I took in account your suggestion and I didn't restore anymore an
hardcore value. The state of the CS is already store in cs->chconf0, so
now I use it. The tricky part is omap2_mcspi_enable_clocks restore the
register when clock was disable, but for OMAP2_MCSPI_CHCONF_FORCE bit, we
had to toggle it. When resumed from OFF mode the OMAP2_MCSPI_CHCONF0
register have default value, which means that OMAP2_MCSPI_CHCONF_FORCE
 is 0. So if we want that OMAP2_MCSPI_CHCONF_FORCE=0 is taken in account
we have to first write a 1 and then a 0. But if we want that
OMAP2_MCSPI_CHCONF_FORCE=1, then we have nothing more to do, because in
omap2_mcspi_enable_clocks this bit was change from 0 (its default value)
to 1. That's why I only do a change when OMAP2_MCSPI_CHCONF_FORCE have to
be changed to 0.
I suppose this means that I had to add more comment around my code about
it.

>> When SPI wake up from OFF mode, CS is in the wrong state: force it to the inactive state.
>>
>> During the system life, I monitored the CS behavior using a oscilloscope.
>> I also activated debug in omap2_mcspi, so I saw when driver disable the clocks and restore context when device is not used.
>> Each time the CS was in the correct state.
>> It was only when system was put suspend to ram with off-mode activated that on resume the CS was in wrong state( ie activated).
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
> 
> This is where any changelog and extra info for reviewers should go.
> 
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
>> +/* When SPI wake up from off-mode, CS is in activate state. If it was in
>> + * unactive state when driver was suspend, then force it to unactive state at
>> + * wake up.
>> + */
> 
> please fix multi-line comment style.  Search for 'multi-line' in
> CodingStyle.

OK, I though CodingStyle was about burning GNU coding standards ;)
More seriously I keep the same style that other multi-line comment
in this file. But I have no problem to change it.

> 
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
> 
> multi-line coding style
> 
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
>>  	.remove =	__exit_p(omap2_mcspi_remove),
>>  };
>>  -- 1.7.0.4
> 
> Kevin


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
