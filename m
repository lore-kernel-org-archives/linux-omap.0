From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-SR] [PATCH 5/7] omap3: sr: device: add unlikely checks
Date: Fri, 9 Jul 2010 09:23:15 -0500
Message-ID: <4C3730D3.8040309@ti.com>
References: <1277502400-9915-1-git-send-email-nm@ti.com>	 <1277502400-9915-6-git-send-email-nm@ti.com>	 <1278681148.9953.110.camel@localhost>  <4C3726C9.7010002@ti.com> <1278684927.9953.119.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49830 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0GIOXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 10:23:17 -0400
In-Reply-To: <1278684927.9953.119.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Gopinath, Thara" <thara@ti.com>

Artem Bityutskiy had written, on 07/09/2010 09:15 AM, the following:
> On Fri, 2010-07-09 at 08:40 -0500, Nishanth Menon wrote:
>> Artem Bityutskiy had written, on 07/09/2010 08:12 AM, the following:
>>> On Fri, 2010-06-25 at 16:46 -0500, Nishanth Menon wrote:
>>>> Add unlikely checks to better optimize the rare occurrance of
>>>> erroneous conditions.
>>>>
>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>> Cc: Thara Gopinath <thara@ti.com>
>>>>
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> unlikely and friends make sens only in realy hot path places. In other
>>> places like you touch, they are pointless - better let gcc make a choice
>>> @@ -43,8 +43,9 @@ static void __init sr_read_efuse(struct omap_sr_dev_data *dev_data,
>>>  {
>>>  	int i;
>>>  
>>> -	if (!dev_data || !dev_data->volts_supported || !dev_data->volt_data ||
>>> -			!dev_data->efuse_nvalues_offs) {
>>> +	if (unlikely(!dev_data || !dev_data->volts_supported ||
>>> +			!dev_data->volt_data ||
>>> +			!dev_data->efuse_nvalues_offs)) {
>>> @@ -87,8 +88,8 @@ static void __init sr_set_testing_nvalues(struct omap_sr_dev_data *dev_data,
>>>  {
>>>  	int i;
>>>  
>>> -	if (!dev_data || !dev_data->volts_supported ||
>>> -			!dev_data->volt_data || !dev_data->test_nvalues) {
>>> +	if (unlikely(!dev_data || !dev_data->volts_supported ||
>>> +			!dev_data->volt_data || !dev_data->test_nvalues)) {
>> and other places, why do you think that these are checks that should be 
>> expected? - would be great if you can explain inline to the patch which 
>> unlikely checks dont make sense.
>>
>> static functions such as these are helpers for the maincode, unless 
>> something horribly wrong occurs within the codepath calling these 
>> helpers, they are not expected to be invalid parameters. hence the 
>> rationale for adding unlikely.
> 
> Sorry, I do not really understand you. All I said is that
> unlikely()/likely() are usually used in hot-paths / tight loops.
> 
> unlikely()/likely() are micro optimization. They make no difference when
> you use them in initialization paths.
> 
> So what I said, that in your patch they will make no difference
> performance wise. So no benefits.
> 
> But they make if () statements a bit more difficult to read, this is a
> drawback.
> 
> So your patch introduces no benefits, just a drawback. Thus, it is not
> good.
> 
> There were many flamewars about unlikely and likely in lkml in the past.
> And the outcome was always - do not use them anywhere except of
> performance-critical tight loops / hot paths.
> 
> 
alright.. thanks for the review. will drop this patch.

-- 
Regards,
Nishanth Menon
