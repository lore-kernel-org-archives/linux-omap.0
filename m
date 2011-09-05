From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 22/25] OMAP4: PM: Add power domain statistics support
Date: Mon, 05 Sep 2011 16:13:08 +0530
Message-ID: <4E64A7BC.1090500@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-23-git-send-email-santosh.shilimkar@ti.com> <4E649F8C.4090800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45969 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871Ab1IEKnN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:43:13 -0400
Received: by mail-gw0-f48.google.com with SMTP id 22so3282307gwj.7
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:43:13 -0700 (PDT)
In-Reply-To: <4E649F8C.4090800@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Monday 05 September 2011 03:38 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 04-09-2011 17:54, Santosh Shilimkar wrote:
>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>> ---
>> arch/arm/mach-omap2/omap-mpuss-lowpower.c | 5 +++++
>> 1 files changed, 5 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index 4dd9d0f..0bc7610 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> [...]
>> @@ -270,6 +272,7 @@ int omap4_enter_lowpower(unsigned int cpu,
>> unsigned int power_state)
>> scu_pwrst_prepare(cpu, power_state);
>> l2x0_pwrst_prepare(cpu, save_state);
>>
>> +
>
> Stray newline?
>
I noticed this later after scanning it on the list.
Will remove it.

Regards
Sntosh
