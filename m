From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: Re: [PATCH v2] ARM: OMAP4460: cpuidle: Extend PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD
 on cpuidle
Date: Fri, 15 Nov 2013 18:02:13 +0200
Message-ID: <52864585.6030206@linaro.org>
References: <1382467484-16957-1-git-send-email-grygorii.strashko@ti.com> <5266CCE3.1090801@ti.com> <20131114183535.GL10317@atomide.com> <20131115153608.GX10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38383 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3KOQCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 11:02:16 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so1152557eek.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Nov 2013 08:02:15 -0800 (PST)
In-Reply-To: <20131115153608.GX10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, open list <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 11/15/2013 05:36 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [131114 10:36]:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [131022 12:09]:
>>> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
>>> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC ..."
>>> need to be applied not only when system is booting, but when MPUSS hits
>>> OSWR state through CPUIdle too. Without this WA the same issue is
>>> reproduced now on boards PandaES and Tablet/Blaze with SOM OMAP4460
>>> when CONFIG_CPU_IDLE is enabled.
>>> After MPUSS has enterred OSWR and waken up:
>>> - GIC distributor became disabled forever
>>> - scheduling is not performed any more
>>>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Reported-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Applying into omap-for-v3.13/fixes thanks.
> 
> Hmm looks like this breaks the build with randconfigs at least
> with the attached .config, so dropping for now.

Hi Tony
Have you forgot to attach .config?

> arch/arm/mach-omap2/built-in.o: In function `omap_enter_idle_coupled':
> :(.text+0xb48c): undefined reference to `pm44xx_errata'

I assume that .config doesn't have CONFIG_SMP enabled while
pm44xx_errata is defined in omap-smp.c.
I think it should be a separate patch to move pm44xx_errata somewhere
else, so this patch will remain the same.

Btw, do we need omap_enter_idle_coupled() in UP?

-- 
Taras Kondratiuk
