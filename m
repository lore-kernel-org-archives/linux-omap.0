From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 0/9] Consolidate cpuidle functionality
Date: Mon, 05 Mar 2012 17:43:07 +0100
Message-ID: <4F54ED1B.3070404@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org> <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62119 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab2CEQnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:43:17 -0500
Received: by bkcik5 with SMTP id ik5so3349584bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:43:16 -0800 (PST)
In-Reply-To: <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

On 03/01/2012 09:57 PM, Rob Lee wrote:
> On Wed, Feb 29, 2012 at 6:42 PM, Robert Lee<rob.lee@linaro.org>  wrote:
>> This patch series moves various functionality duplicated in platform
>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
>> disabling was removed as it appears that all calls into
>> cpuidle_call_idle will have already called local_irq_disable().
>>
>
> I'm told that I forgot to add the Acks from the previous v6 to this version:
>
> Acked-by: Jean Pihet<j-pihet@ti.com>  (v6)
> Tested-by: Jean Pihet<j-pihet@ti.com>  (v6, omap3)
> Tested-by: Amit Daniel<amit.kachhap@linaro.org>  (v6, Exynos4)
> For the generic cpuidle changes:
> Reviewed-by: Deepthi Dharwar<deepthi@linux.vnet.ibm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
