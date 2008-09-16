From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce is enabled v2.
Date: Tue, 16 Sep 2008 15:32:47 +0300
Message-ID: <87myi88e4w.fsf@trdhcp146196.ntc.nokia.com>
References: <873ak0mk5t.fsf@deeprootsystems.com>
	<1221567379-2177-1-git-send-email-jouni.hogander@nokia.com>
	<alpine.DEB.1.00.0809160618250.21341@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30907 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYIPMbW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:31:22 -0400
In-Reply-To: <alpine.DEB.1.00.0809160618250.21341@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Tue, 16 Sep 2008 06:19:51 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hi Jouni,
>
> sorry to make you rework this again, but:
>
> On Tue, 16 Sep 2008, Jouni Hogander wrote:
>
>> This patch changes gpio "driver" to enable debounce clock for
>> gpio-bank only when debounce is enabled for some gpio in that bank.
>
>> =20
>> +#if defined(CONFIG_ARCH_OMAP3)
>> +	if (cpu_is_omap34xx())
>> +		enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
>> +#endif
>
> the #ifdefs here are unnecessary, since the preprocessor will reduce=20
> cpu_is_omap34xx() to a constant for single-OMAP builds..

NP. Maybe I can learn this multi/single OMAP thing:)

If I remove these ifdefs then I should remove also these:

#if defined(CONFIG_ARCH_OMAP3)
	struct clk *dbck;
#endif

Is that ok?

>
>> @@ -1513,6 +1515,15 @@ static int __init _omap_gpio_init(void)
>>  		}
>>  		set_irq_chained_handler(bank->irq, gpio_irq_handler);
>>  		set_irq_data(bank->irq, bank);
>> +
>> +#if defined(CONFIG_ARCH_OMAP3)
>> +		if (cpu_is_omap34xx()) {
>> +			sprintf(clk_name, "gpio%d_dbck", i + 1);
>> +			bank->dbck =3D clk_get(NULL, clk_name);
>> +			if (IS_ERR(bank->dbck))
>> +				printk(KERN_ERR "Could not get %s\n", clk_name);
>> +		}
>> +#endif
>
> as above.
>
>
> - Paul
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
