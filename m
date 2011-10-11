From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Tue, 11 Oct 2011 10:00:25 -0700
Message-ID: <87k48b79au.fsf@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
	<87ty7ghgiw.fsf@ti.com> <4E93EBC2.1060103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46584 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754923Ab1JKRAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 13:00:30 -0400
Received: by mail-qy0-f172.google.com with SMTP id 32so3360575qyk.3
        for <linux-omap@vger.kernel.org>; Tue, 11 Oct 2011 10:00:28 -0700 (PDT)
In-Reply-To: <4E93EBC2.1060103@ti.com> (Santosh Shilimkar's message of "Tue,
	11 Oct 2011 12:39:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Monday 10 October 2011 11:31 PM, Kevin Hilman wrote:
>> Hi Santosh,
>> 
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>>> suspend (S2R), CPU hotplug and CPUidle.
>> 
>> There are a few more compile errors when doing OMAP1-only builds.
>> You'll need a way to eliminate the secure calls for OMAP1.
>> 
>> This series causes a couple build errors when doing OMAP1-only builds
>> (I used omap1_defconfig):
>> 
> OK. Thanks for catching it.
>
>> First:
>> 
>> /work/kernel/omap/pm/arch/arm/plat-omap/common.c:24:30: fatal error: mach/omap-secure.h: No such file or directory
>> 
>> And trying creating a dummy header to see if it would continue to build gives:
>> 
>> /work/kernel/omap/pm/arch/arm/plat-omap/common.c: In function 'omap_reserve':
>> /work/kernel/omap/pm/arch/arm/plat-omap/common.c:70:2: error: implicit declaration of function 'omap_secure_ram_reserve_memblock'
>> make[2]: *** [arch/arm/plat-omap/common.o] Error 1
>> make[1]: *** [arch/arm/plat-omap] Error 2
>> 
> For OMAP1 build, omap_secure_ram_reserve_memblock() definition is
> needed since common.c is built for OMAP1 as well.
> The trivial change in the end of this email fixes the omap1 build.

Looks good.

> Have folded that change in original patch and updated the OMAP4
> PM branch - for_3_2/omap4-mpuss-pm_2

Thanks.

> Regards
> Santosh
> P.S : Even with this fix, omap1_defconfig build breaks because of USB.
> I removed USB from build to check rest of the build and it was
> fine then.

OK.

Kevin
