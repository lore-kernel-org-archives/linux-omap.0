From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 07/10] ARM: OMAP5: clock data: Add OMAP54XX full clock
 tree and headers
Date: Thu, 31 Jan 2013 17:19:46 +0530
Message-ID: <510A5A5A.9090708@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-8-git-send-email-santosh.shilimkar@ti.com> <51095A65.9070102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33619 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab3AaLty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 06:49:54 -0500
In-Reply-To: <51095A65.9070102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

On Wednesday 30 January 2013 11:07 PM, Jon Hunter wrote:
>
> On 01/18/2013 09:27 AM, Santosh Shilimkar wrote:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Add the clock tree related data for OMAP54xx platforms.
>
> [snip]
>
>> +	CLK("omap_timer.1",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.2",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.3",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.4",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.5",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.6",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.7",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.8",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.9",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.10",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>> +	CLK("omap_timer.11",	"32k_ck",		&sys_32k_ck,	CK_54XX),
>
> I have been trying to get away from having so many aliases for the same
> clock for timers. Here we should replace all of the above and just have ...
>
> +	CLK(NULL,	"timer_32k_ck",		&sys_32k_ck, CK_54XX),
>
> For more details see [1].
>
>> +	CLK("omap_timer.1",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.2",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.3",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.4",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.9",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.10",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.11",	"sys_ck",		&sys_clkin,	CK_54XX),
>> +	CLK("omap_timer.5",	"sys_ck",		&dss_syc_gfclk_div,	CK_54XX),
>> +	CLK("omap_timer.6",	"sys_ck",		&dss_syc_gfclk_div,	CK_54XX),
>> +	CLK("omap_timer.7",	"sys_ck",		&dss_syc_gfclk_div,	CK_54XX),
>> +	CLK("omap_timer.8",	"sys_ck",		&dss_syc_gfclk_div,	CK_54XX),
>> +};
>
> These aliases will not work with device-tree because the device-name is
> formatted <addr>.<device>. Hence, when configuring a the timer parent
> clock via the dmtimer driver it will fail. So it should be more like ...
>
> +	CLK("4ae18000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("48032000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("48034000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("48036000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("40138000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("4013a000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("4013c000.timer",	"timer_sys_ck",	&sys_clkin, CK_54XX),
> +	CLK("4013e000.timer",	"timer_sys_ck",	&dss_syc_gfclk_div, 	
> CK_54XX),
> +	CLK("4803e000.timer",	"timer_sys_ck",	&dss_syc_gfclk_div, CK_54XX),
> +	CLK("48086000.timer",	"timer_sys_ck",	&dss_syc_gfclk_div, CK_54XX),
> +	CLK("48088000.timer",	"timer_sys_ck",	&dss_syc_gfclk_div, CK_54XX),
>
> For more details see [2].

Thanks Jon. I will update the autogen scripts to generate these
accordingly.

>
> If you would like to test the dmtimer driver on omap5, then you can grab
> my omap-test module [3], build it (see README), load it and then ...
>
> # echo 1 > /sys/kernel/debug/omap-test/timer/all
>
> This will perform some basic tests on all the dmtimers. I would do it
> myself, but there appears to be several issues getting this to boot on
> an ES1.0 (which is probably expected).

Right. This is ES2.0 data, so won't boot on an ES1.0 device.

regards,
Rajendra

>
> Cheers
> Jon
>
> [1] http://www.spinics.net/lists/linux-omap/msg71272.html
> [2] https://patchwork.kernel.org/patch/1204351/
> [3] https://github.com/jonhunter/omap-test
>

