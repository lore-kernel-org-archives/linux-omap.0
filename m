From: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] clk/ti/adpll: allocate room for terminating null
Date: Fri, 27 Sep 2019 20:00:21 +0200
Message-ID: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
References: <20190927145737.7832-1-steve@sk2.org>
 <20190927152315.GE5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190927152315.GE5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Le 27/09/2019 17:23, Tony Lindgren a écrit :
> * Stephen Kitt <steve@sk2.org> [190927 15:13]:
>> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
>> terminating null. This patch adds the extra byte, and switches to
>> snprintf to avoid overflowing.
>> 
>> Signed-off-by: Stephen Kitt <steve@sk2.org>
>> ---
>>  drivers/clk/ti/adpll.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
>> index fdfb90058504..27933c4e8a27 100644
>> --- a/drivers/clk/ti/adpll.c
>> +++ b/drivers/clk/ti/adpll.c
>> @@ -196,12 +196,13 @@ static const char *ti_adpll_clk_get_name(struct 
>> ti_adpll_data *d,
>>  	} else {
>>  		const char *base_name = "adpll";
>>  		char *buf;
>> +		size_t size = 8 + 1 + strlen(base_name) + 1 +
>> +			      strlen(postfix) + 1;
>> 
>> -		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
>> -				    strlen(postfix), GFP_KERNEL);
>> +		buf = devm_kzalloc(d->dev, size, GFP_KERNEL);
>>  		if (!buf)
>>  			return NULL;
>> -		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
>> +		snprintf(buf, size, "%08lx.%s.%s", d->pa, base_name, postfix);
>>  		name = buf;
>>  	}
>> 
> 
> Thanks for catching this. Maybe just use devm_kasprintf() here?

Ah yes, that would be much better! V2 coming up, thanks for the 
suggestion.

Regards,

Stephen
