From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 13/24] ARM: omap4: clk: Add 44xx data using common struct
 clk
Date: Tue, 05 Jun 2012 10:05:34 +0530
Message-ID: <4FCD8C96.6010405@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com> <1338552485-31325-14-git-send-email-rnayak@ti.com> <4FCD3357.5090409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:33650 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751441Ab2FEEfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 00:35:42 -0400
Received: by obcni5 with SMTP id ni5so10649141obc.13
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 21:35:41 -0700 (PDT)
In-Reply-To: <4FCD3357.5090409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Jon,

>> +
>> +static const struct clksel_rate div_1_0_rates[] = {
>> +	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_1_rates[] = {
>> +	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_2_rates[] = {
>> +	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_3_rates[] = {
>> +	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_4_rates[] = {
>> +	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>> +
>> +static const struct clksel_rate div_1_5_rates[] = {
>> +	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
>> +	{ .div = 0 },
>> +};
>
> The above clksel_rate structures could be used by OMAP2/3 devices too
> (assuming that the flags is set for OMAP2/3/4 devices). Any reason why
> these cannot be placed in a global header? It could remove quite a bit
> of repetitive code. I know these are auto-generated, but maybe we should
> have the auto-generator spit out the clksel_rate structs to another file
> (ie. a global header).

Well, I did not try doing any further optimizations and tried keeping
the same layout of data files so its easier to review, given the changes
already due to using common struct clk movement. We can certainly do
further optimizations/cleanups on top of this series.
I would really want to keep cleanups/optimizations separate (unless
they are cleanups/optimizations done as part of moving to common clk
itself) from common clk movement series. There are other optimizations
too like getting rid of some unwanted leaf clocks for omap4, moving
handling of clkdms for leaf clks into hwmod for OMAP2/3. But all those
are happening separately and can happen in the existing code without
having it being moved to common clk.

>
> By the way, div_1_3/4/5_rates don't appear to be used in this file.

ok, thanks, will have a look and get rid of it if its really unused.

regards,
Rajendra
>
> Cheers
> Jon

