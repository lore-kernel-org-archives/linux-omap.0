From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable mask on disable
Date: Tue, 23 Oct 2012 15:00:09 -0700
Message-ID: <87k3ug7st2.fsf@deeprootsystems.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
	<20121023190914.GA853@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:35839 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2JWV7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 17:59:42 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2122815dak.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 14:59:41 -0700 (PDT)
In-Reply-To: <20121023190914.GA853@arwen.pp.htv.fi> (Felipe Balbi's message of
	"Tue, 23 Oct 2012 22:09:14 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Tue, Oct 23, 2012 at 11:09:31AM -0700, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@ti.com>
>> 
>> When debounce clocks are disabled, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>> 
>> This was discovered when board code was doing
>> 
>>   gpio_request_one()
>>   gpio_set_debounce()
>>   gpio_free()
>> 
>> which was leaving the GPIO debounce settings in a confused state.
>> Then, enabling off mode causing bogus state to be restored, leaving
>> GPIO debounce enabled which then prevented the CORE powerdomain from
>> transitioning.
>> 
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> looks like this deserves a Cc: stable@vger.kernel.org tag.
>

Agreed.  I think this goes all the way back to v3.5, but would've only
been seen on boards using a request/gpio_set_debounce/free sequence
combined with off-mode.

Linus, feel free to add the Cc: stable when commiting.  Thanks.

>> ---
>> Applies on v3.7-rc2, targetted for v3.7.
>> 
>>  drivers/gpio/gpio-omap.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 94cbc84..dee2856 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
>>  		 * to detect events and generate interrupts at least on OMAP3.
>>  		 */
>>  		__raw_writel(0, bank->base + bank->regs->debounce_en);
>> +		bank->dbck_enable_mask = 0;
>
> shouldn't omap_gpio_restore_context() check for dbck_enabled instead of
> the mask ? I mean:
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..b3a39a7 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1371,7 +1371,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  				bank->base + bank->regs->dataout);
>  	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>  
> -	if (bank->dbck_enable_mask) {
> +	if (bank->dbck_enabled) {
>  		__raw_writel(bank->context.debounce, bank->base +
>  					bank->regs->debounce);
>  		__raw_writel(bank->context.debounce_en,
>
> the outcome would be the same, so it doesn't really matter. Just that,
> at least to me, it would look better.

I tried your version, and unfortunately, the outcome is not the same,
but don't plan to look into why.  $SUBJECT version is targetted and
tested.  If you want to cleanup the cosmetics here, please do in a
subsequent patch.  This driver could certainly benefit from more
readability cleanups.

> No strong feelings though.

Good.   I'll take that as an Ack.  :)

Kevin
