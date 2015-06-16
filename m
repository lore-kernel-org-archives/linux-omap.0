From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
Date: Wed, 17 Jun 2015 00:04:07 +0200
Message-ID: <CAJZ5v0hO+Rbcyq8Gcpecdw9rGW1Qdhrmj6X6TVtRpLOxQKW+=g@mail.gmail.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
	<1431115050-23693-2-git-send-email-balbi@ti.com>
	<20150616214032.GA4313@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34966 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbbFPWEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2015 18:04:09 -0400
In-Reply-To: <20150616214032.GA4313@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Jun 16, 2015 at 11:40 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
>> by adding the missing MODULE_ALIAS(), cpufreq-dt
>> can be autoloaded by udev/systemd.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> looks like this wasn't applied anywhere. Viresh, can you apply this
> patch please ?

I've overlooked it, sorry about that.  Applied now, thanks!


>> ---
>>  drivers/cpufreq/cpufreq-dt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index bab67db54b7e..528a82bf5038 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
>>  };
>>  module_platform_driver(dt_cpufreq_platdrv);
>>
>> +MODULE_ALIAS("platform:cpufreq-dt");
>>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>>  MODULE_DESCRIPTION("Generic cpufreq driver");
>> --
>> 2.4.0.rc3
>>
>
> --
> balbi
