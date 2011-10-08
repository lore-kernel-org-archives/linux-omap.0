From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde
 support
Date: Sat, 08 Oct 2011 14:14:27 +0530
Message-ID: <4E900D6B.5030006@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>	<87d3e8juqm.fsf@ti.com> <87vcs0ifgn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:58020 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751148Ab1JHIog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Oct 2011 04:44:36 -0400
Received: by ywm39 with SMTP id 39so4975681ywm.32
        for <linux-omap@vger.kernel.org>; Sat, 08 Oct 2011 01:44:33 -0700 (PDT)
In-Reply-To: <87vcs0ifgn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 08 October 2011 04:20 AM, Kevin Hilman wrote:
> Kevin Hilman <khilman@ti.com> writes:
> 
>> Hi Santosh,
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>>> suspend (S2R), CPU hotplug and CPUidle.
>>
>> Just noticed when doing some final build/sanity testing that there are a
>> few of compile/link warnings/problems when the kernel is built without
>> CONFIG_PM
>>
>> Some warnings:
>>
>> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:203:13: warning: 'irq_save_context' defined but not used
>> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:270:13: warning: 'irq_save_secure_context' defined but not used
>>
Sory I missed it in my builds.

[...]

> Please just cleanup the wakeupgen compile warnings and update your
> branch.
> 
Done !!
Updated branch : for_3_2/omap4-mpuss-pm_2

Regards
Santosh


