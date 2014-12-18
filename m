From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Fwd: next boot: 101 boots: 89 pass, 12 fail (next-20141216)
Date: Thu, 18 Dec 2014 07:31:12 +0530
Message-ID: <CAKohpokWe+MGNM7N8recCsV7O6pFDdJ89QKnqyj9TK_WRtW7yQ@mail.gmail.com>
References: <E1Y0lcK-00026B-7I@ip-10-35-177-41.ec2.internal>
	<CAMAWPa98kyaUJpt=GLw4cH7fkg+8BkrA0kds=H-2-4fWXy_tqw@mail.gmail.com>
	<54909E30.4040300@ti.com>
	<CAKohponYEqhPjZmk_WH+TbNPLHEM5HWxta7CLUoM5+2iHYw_zw@mail.gmail.com>
	<CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44394 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaLRCBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 21:01:12 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so493525obc.8
        for <linux-omap@vger.kernel.org>; Wed, 17 Dec 2014 18:01:12 -0800 (PST)
In-Reply-To: <CAMAWPa-_OZC3ynKYxbtXK4=z-z720JxXigT23umscMTm8VWAzA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>

On 17 December 2014 at 22:46, Kevin Hilman <khilman@kernel.org> wrote:
> So this looks like a bug that has been hiding, but just exposed
> because cpufreq-cpu0 (now cpufreq-dt) was not getting built-in since
> before v3.18.
>
> On omap4-panda-es, v3.18 with multi_v7_defconfig + CPUFREQ_DT enabled,
> I see this:
>
> [    2.062103] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
> freq: 699977 KHz
> [    2.070404] cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial
> frequency changed to: 700000 KHz
>
> No BUG.  But, in next-20141216,
>
> [    2.083953] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted
> freq: 699977 KHz
> [    2.091949] cpu cpu0: failed to set clock rate: -22
> [    2.097045] cpufreq: __target_index: Failed to change cpu frequency: -22
>
> And then the BUG.
>
> So the BUG() itself isn't the problem with this regression.  There's
> been a fair amount of changes in the OMAP clk driver (including some
> other regressions), so I suspect the culprit to be lying somewhere in
> the recent OMAP clock changes.

Yeah. I agree..
