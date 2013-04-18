From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Thu, 18 Apr 2013 18:10:52 -0500
Message-ID: <51707D7C.1050600@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com> <871ua734mv.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36374 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXK6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 19:10:58 -0400
In-Reply-To: <871ua734mv.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On 04/18/2013 04:34 PM, Kevin Hilman wrote:
> Hi Jon,
> 
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> Commit a2797be (gpio/omap: force restore if context loss is not
>> detectable) broke gpio support for OMAP when booting with device-tree
>> because a restore of the gpio context being performed without ever
>> initialising the gpio context. In other words, the context restored was
>> bad.
>>
>> This problem could also occur in the non device-tree case, however, it
>> is much less likely because when booting without device-tree we can
>> detect context loss via a platform specific API and so context restore
>> is performed less often.
>>
>> Nevertheless we should ensure that the gpio context is initialised
>> during the probe for gpio banks that could lose their state regardless
>> of whether we are booting with device-tree or not.
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  drivers/gpio/gpio-omap.c |   53 +++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 0557529..0ba5cb9 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -70,6 +70,7 @@ struct gpio_bank {
>>  	bool is_mpuio;
>>  	bool dbck_flag;
>>  	bool loses_context;
>> +	bool context_valid;
>>  	int stride;
>>  	u32 width;
>>  	int context_loss_count;
>> @@ -1085,6 +1086,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>>  }
>>  
>>  static const struct of_device_id omap_gpio_match[];
>> +static void omap_gpio_init_context(struct gpio_bank *p);
>>  
>>  static int omap_gpio_probe(struct platform_device *pdev)
>>  {
>> @@ -1179,8 +1181,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>  	omap_gpio_chip_init(bank);
>>  	omap_gpio_show_rev(bank);
>>  
>> -	if (bank->loses_context)
>> +	if (bank->loses_context) {
>>  		bank->get_context_loss_count = pdata->get_context_loss_count;
>> +		omap_gpio_init_context(bank);
>> +	}
>>  
>>  	pm_runtime_put(bank->dev);
>>  
>> @@ -1269,6 +1273,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
>>  	int c;
>>  
>>  	spin_lock_irqsave(&bank->lock, flags);
>> +
>> +	/*
>> +	 * On the first resume during the probe, the context has not
>> +	 * been initialised and so if the context is not valid return.
>> +	 */
>> +	if (!bank->context_valid)
>> +		goto done;
> 
> Not sure I follow the reason to separate it here and in probe.  
> 
> Also, this makes the first runtime_resume a special case and leaves
> things in a strange semi-initialized state that is confusing IMO.

The first resume has always been a special case. The
"bank->get_context_loss_count" is not initialised until after the first
resume (due to another issue we had found - 7b86cef gpio/omap: fix
invalid context restore of gpio bank-0). This should not leave things in
a strange semi-init'ed state, as on the first resume nothing is really
done anyway because there is no context loss.

> Why not just init context right here if bank->loses_context &&
> !bank->context_valid?

Thanks for the suggestion.

> Then the first resume can continue as expected, and everything is fully
> initialized as expected also.  IMO, this is much more readable (and
> maintainable, but that's your job now, so you can decide ;)

If the context has not been lost, which it has not on the first resume,
then resume really does nothing. That's why I had just returned.
However, I would agree that is not completely readable.

Cheers
Jon
