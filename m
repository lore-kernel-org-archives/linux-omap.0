From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 01/29] clk: Add support for rate table based dividers
Date: Tue, 19 Jun 2012 10:52:43 +0530
Message-ID: <4FE00CA3.5080309@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <1339678038-23082-2-git-send-email-rnayak@ti.com> <20120618200442.GA4402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56760 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467Ab2FSFWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 01:22:50 -0400
Received: by obbtb8 with SMTP id tb8so3837995obb.0
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 22:22:48 -0700 (PDT)
In-Reply-To: <20120618200442.GA4402@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 19 June 2012 01:34 AM, Mike Turquette wrote:
> On 20120614-18:16, Rajendra Nayak wrote:
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index e548c43..e4911ee 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -32,30 +32,69 @@
>>   #define div_mask(d)	((1<<  (d->width)) - 1)
>>   #define is_power_of_two(i)	!(i&  ~i)
>>
>> +static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
>> +{
>> +	unsigned int maxdiv;
>> +	const struct clk_div_table *clkt;
>> +
>> +	for (clkt = table; clkt->div; clkt++)
>> +		if (clkt->div>  maxdiv)
>> +			maxdiv = clkt->div;
>> +	return maxdiv;
>> +}
>> +
>
> Hi Rajendra,
>
> During testing the compiler warns that maxdiv is uninitialized here.

Thanks Mike, I'll fix that up.

>
> Regards,
> Mike

