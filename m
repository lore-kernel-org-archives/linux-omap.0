From: "zumeng.chen" <zchen@windriver.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Sat, 16 Jun 2012 08:15:19 +0800
Message-ID: <4FDBD017.2010606@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com> <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com> <4FD96CBF.5040106@windriver.com> <79CD15C6BA57404B839C016229A409A83EA4FC98@DBDE01.ent.ti.com> <4FD98BD0.7090901@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64315 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab2FPAPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 20:15:35 -0400
In-Reply-To: <4FD98BD0.7090901@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "mike@compulab.co.il" <mike@compulab.co.il>, "tony@atomide.com" <tony@atomide.com>
Cc: Zumeng Chen <zumeng.chen@windriver.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Zumeng Chen <zumeng.chen@gmail.com>, "Hunter, Jon" <jon-hunter@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 2012年06月14日 14:59, Zumeng Chen wrote:
> 于 2012年06月14日 14:31, Hiremath, Vaibhav 写道:
>> On Thu, Jun 14, 2012 at 10:16:55, Zumeng Chen wrote:
>>> 于 2012年06月13日 20:18, Hiremath, Vaibhav 写道:
>>>> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>>>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>>>>
>>>>> If we don't set proper debouce time for ads7846, then there are
>>>>> flooded interrupt counters of ads7846 responding to one time
>>>>> touch on screen, so the driver couldn't work well.
>>>>>
>>>>> And since most OMAP3 series boards pass NULL pointer of board_pdata
>>>>> to omap_ads7846_init, so it's more proper to set it in driver level
>>>>> after having gpio_request done.
>>>>>
>>>>> This patch has been validated on 3530evm.
>>>>>
>>>>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>>>> ---
>>>>>   drivers/input/touchscreen/ads7846.c |    4 ++++
>>>>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>>>>> index f02028e..459ff29 100644
>>>>> --- a/drivers/input/touchscreen/ads7846.c
>>>>> +++ b/drivers/input/touchscreen/ads7846.c
>>>>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>>>>   		}
>>>>>
>>>>>   		ts->gpio_pendown = pdata->gpio_pendown;
>>>>> +#ifdef CONFIG_ARCH_OMAP3
>>>>> +		/* 310 means about 10 microsecond for omap3 */
>>>>> +		gpio_set_debounce(pdata->gpio_pendown, 310);
>>>>> +#endif
>>>>>
>>>> Zumeng,
>>>>
>>>> With my sign-off you are changing the original code, that too
>>>> without my sign-off and ack.
>>>> I wouldn't mind you to submit patches from my tree, but the expectation is
>>>> if you are changing the original code, it should be under your sign-off.
>>> Thanks, good to learn. I'll remove in next time.
>>>> Coming to the patch, #ifdef in driver is not recommended, and this 10msec
>>>> delay is specific to OMAP GPIO and driver should not be aware of this,
>>>> that's where you will find the original patch handling it in board file.
>>> According to the git blame of the board-omap3evm.c I think
>>> 96974a24 did a good thing to all the related codes for omap3
>>> boards. So I think we can call board and driver as BSP level :-)
>>>
>>> If #ifdef in driver can save many codes, I guess it's deserved.
>>>
>> No, not really.
>>
>> In the same commit, the debounce time is already handled as an argument to 
>> the function omap_ads7846_init(), and that’s the way it should be.
> That means you'd like to implement the same get_pendown_state for every
> omap3 board? Currently, board_pdata is NULL.
>
> And actually, the reason why I agree 96974a24 is that get_pendown_state
> for all omap3 boards is the common chip level gpio operations. so I think
> we should set debounce for them in one common point.
>
> But since Igor and you don't like them, I have created and tested the
> attachment
> patch, and I'd like Mike to check if convenience too
> But obviously there are more codes than mine before :-)
Tony & Mike,

How about your comments on this issue? Do you think the following is
acceptable VS my last email _attachment_.

+#ifdef CONFIG_ARCH_OMAP3
+		/* 310 means about 10 microsecond for omap3 */
+		gpio_set_debounce(pdata->gpio_pendown, 310);
+#endif


Regards,
Zumeng


> Regards,
> Zumeng
>> So no need for #ifdefs in driver...
>>
>> Thanks,
>> Vaibhav

