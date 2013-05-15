From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 0/6] ARM; OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
Date: Wed, 15 May 2013 20:30:52 +0530
Message-ID: <5193A324.8090703@ti.com>
References: <1366973695-2088-1-git-send-email-rnayak@ti.com> <87ppxhxixu.fsf@linaro.org> <20130510140200.GA11267@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49613 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759184Ab3EOPB6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 May 2013 11:01:58 -0400
In-Reply-To: <20130510140200.GA11267@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

On Friday 10 May 2013 07:32 PM, Nishanth Menon wrote:
> On 11:09-20130426, Kevin Hilman wrote:
>> Rajendra Nayak <rnayak@ti.com> writes:
>>
>> [...]
>>
>>> OMAP UART IP needs manual idle modes based on functional state of the
>>> IP. Currently this is handled by the driver with function pointers
>>> implemented in platform code.
>>>
>>> This however breaks in case of device tree because of missing
>>> idle handling. 
>>>
>>> The series tries to address the issue and tries to remove complete
>>> sysc handling from serial driver.
>>
>> Other than the minor nit about the order of the series for bisect, 
>>
>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>>
>> Also tested this on OMAP4/Panda where I was having the sluggish console
>> issues using DT boot, and and can confirm that this fixes the problem:
>>
>> Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda
>>
> I saw the same let of console sluggishness on SDP4430, Panda, Panda-ES
> as well on latest linus master.
> 
> For reference, I have rebased the series to latest master and fixes the
> sequencing:
> https://github.com/nmenon/linux-2.6-playground/commits/push/uart-fixes-sidle-3.10
> based on:
> master 70eba42 Merge tag 'please-pull-pstore' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux
> 
> Rajendra,
> Would you be able to repost this series so that we can get this into
> 3.10-rc2+?

Tony/Paul,

I just posted the v3 of these out [1] based off 3.10-rc1. Can we pull these in into -rc since
these actually fix the console sluggishness introduced in this merge window (we always had issues
with UART sidle handling with DT but never saw issues in mainline because of some static deps which got
removed this merge window  I guess which would otherwise hide the issue).

regards,
Rajendra

[1] http://marc.info/?l=linux-omap&m=136862939928398&w=2

> 

