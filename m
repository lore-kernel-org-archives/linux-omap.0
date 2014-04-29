From: sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH 1/5] drivers: w1: omap_hdq: cleanup and bug fixes.
Date: Tue, 29 Apr 2014 14:45:08 +0530
Message-ID: <535F6D9C.8050502@ti.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com> <1397651532-31456-2-git-send-email-sourav.poddar@ti.com> <alpine.DEB.2.02.1404281918360.14616@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbaD2JPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:50 -0400
In-Reply-To: <alpine.DEB.2.02.1404281918360.14616@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com

Hi Paul,

On Tuesday 29 April 2014 12:49 AM, Paul Walmsley wrote:
> On Wed, 16 Apr 2014, Sourav Poddar wrote:
>
>> The patch adds the following to the omap hdq driver.
>> 1. HDQ Device reset call in probe.
>> 2. Enabling '1 wire mode' and checking for presence pulse bit.
>> 3. Proper disabling and enabling of interrupts during read path.
>> 4. Add re-initialization code during SKIP ROM command execution.
>> 5. Miscellaneous cleanup(formatting, return error checks).
>>
>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>> ---
>>   drivers/w1/masters/omap_hdq.c |   85 ++++++++++++++++++++++++++++++++---------
>>   1 file changed, 68 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
>> index 9900e8e..0a7bf7f 100644
>> --- a/drivers/w1/masters/omap_hdq.c
>> +++ b/drivers/w1/masters/omap_hdq.c
> ...
>
>> @@ -115,6 +116,15 @@ static inline u8 hdq_reg_merge(struct hdq_data *hdq_data, u32 offset,
>>   	return new_val;
>>   }
>>
>> +static void hdq_disable_interrupt(struct hdq_data *hdq_data, u32 offset,
>> +				  u8 mask)
>> +{
>> +	u32 ie;
>> +
>> +	ie = readl(hdq_data->hdq_base + offset);
>> +	writel(ie&  mask, hdq_data->hdq_base + offset);
>> +}
>> +
> Does this function really need to take offset and mask arguments?  Won't
> they always be constant, and therefore, no need to pass them?

Yes, thats correct, they are always constant and can be used directly 
inside the
api. I will fix this in my next version.

>
> - Paul

