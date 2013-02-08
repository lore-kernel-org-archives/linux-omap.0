From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
Date: Fri, 8 Feb 2013 21:04:09 +0530
Message-ID: <51151AF1.20202@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com> <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com> <20130208152607.GJ23979@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48889 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab3BHPc4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:32:56 -0500
In-Reply-To: <20130208152607.GJ23979@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

On Friday 08 February 2013 08:56 PM, Felipe Balbi wrote:
> On Fri, Feb 08, 2013 at 08:41:46PM +0530, Santosh Shilimkar wrote:
>> Current CPU PM code code make use of common cpu_suspend() path for all the
>> CPU power states which is not optimal. In fact cpu_suspend() path is needed
>> only when we put CPU power domain to off state where the CPU context is lost.
>>
>> Update the code accordingly so that the expensive cpu_suspend() path
>> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> some numbers showing the benefit would be cool...
>
The numbers depends on CPU clock you are running generally. The main
issue is, for the shallow power states where we were not loosing
CPU context or Caches, we were doing all the book keeping. States
like INA are of 6-8 uS and above overhead is quite significant
their.

Regards
Santosh

