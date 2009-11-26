From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
Date: Thu, 26 Nov 2009 14:44:38 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008504837F@dlee01.ent.ti.com>
References: <B852767254C5C94EBB1040EE0EFA060084FBDD1D@dlee01.ent.ti.com>
 <20091124.105047.226798314.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbZKZUof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 15:44:35 -0500
In-Reply-To: <20091124.105047.226798314.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "imre.deak@nokia.com" <imre.deak@nokia.com>, "Shah, Bhavin" <bshah@ti.com>

Hi,

>-----Original Message-----
>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Tuesday, November 24, 2009 2:51 AM
>To: Ramos Falcon, Ernesto
>Cc: linux-omap@vger.kernel.org; Ramirez Luna, Omar; imre.deak@nokia.com;
>Shah, Bhavin
>Subject: Re: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
>
>Hi Ernesto,
>
>From: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
>Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
>Date: Mon, 23 Nov 2009 21:12:08 +0100
>
>> From f28ec22e48a9b61ac00b7711e035e117bdc71aeb Mon Sep 17 00:00:00 2001
>> From: Ernesto Ramos <ernesto@ti.com>
>> Date: Mon, 23 Nov 2009 12:16:45 -0600
>> Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
>inputs.
>>
>> Move the error checking to kernel to address usecases
>> accessing kernel API directly.
>
>"memory_check_vma()" wasn't implemented for normal ioctl parameter
>checking, but one for bridge cache operations with kernel crash risk,
>especially with the following patch:
>
>  http://marc.info/?l=linux-omap&m=125810716419520&w=2
>
>This is because these memory area is expected that:
>
>  - its pages have been already populated.
>  - its pages shouldn't be swapped out.
>
>Otherwise there's risk of kernel crash at these cache operation,
>although "find_vma()" and "follow_page()" may be a bit heavier
>operation.
>

The intention with this patch is to further strengthen the dsp bridge driver.
I already executed some test cases to measure performance and the impact seems to be ~ 0.3% for a big amount of memory maps and flush memory commands, the latency impact is not even noticeable.

>For most of the normal cases, which just checks ioctl parameters,
>normal "access_ok()" would be enough. If it tries to access kernel
>address, just it returns error to userland. If it tries to access
>invalid address in user address space, the process dies with
>SIGSEGV. I think that normally it's ok that a process dies because of
>invalid address access rather than performance degrade.
>

I intended to use access_ok() for the purpose to check ioctl parameters, however, access_ok() seems not to work, I was able to send any invalid address to the bridge driver and no errors where reported. It seems that access_ok is rejecting only addresses that belong to the kernel space but the user would be able to send invalid address anyway.

>So I think that "memory_check_vma()" doesn't fit for normal ioctl
>parameter checking("copy_from_user"/"copy_to_user"), but "access_ok()"
>would work in most of normal cases.
>
>In macros, __cp_fm_usr()/__cp_to_usr(), adding "access_ok()" checking
>for pointers may work fine, I guess.
>

access_ok() is already called within copy_to_user() but the verification is being done after most of the processing is done, the intentions is to add these checks before any processing happens, and as I mentioned before access_ok does not work for all cases.

>> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>> ---
>>  arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +-
>>  drivers/dsp/bridge/pmgr/wcd.c                 |  263
>+++++++++++++++++++++++--
>>  drivers/dsp/bridge/rmgr/proc.c                |   42 ----
>>  3 files changed, 249 insertions(+), 59 deletions(-)
