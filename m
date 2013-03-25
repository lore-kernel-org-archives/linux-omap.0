From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 00/18] ARM: OMAP5: PM: Add MPUSS suspend and CPUidle
 support
Date: Mon, 25 Mar 2013 17:40:53 +0530
Message-ID: <51503ECD.8060101@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <51503933.9060106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42870 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756633Ab3CYMJJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 08:09:09 -0400
In-Reply-To: <51503933.9060106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Monday 25 March 2013 05:16 PM, Lokesh Vutla wrote:
> Hi Santosh,
> 
> On Monday 25 March 2013 03:34 PM, Santosh Shilimkar wrote:
>> Kevin,
>>
>> Here is the refreshed version(v2) of the OMAP5 PM suspport which was posted
>> earlier (March 1st 2013). Patch-set incorporates comments from Nishant
>> Menon (Thanks for review NM) and his acked-by tags. I would like to get this
>> queued for 3.10 merge window if you are ok with the series.
>>
>> Series is built on top of my pull requests [1] [2] [3] sent to Tony and your
>> 'for_3.10/pm/cleanup' branch. For testing, I have created a branch [4]
>> which put together all the needed dependencies, fixes which should make it
>> to 3.10 merge window.
>>
>> Series adds OMAP5 MPUSS power management support for system wide suspend
>> and CPUidle. Its heavy re-use from OMAP4 and hence only ~400 odd lines are
>> needed to add OMAP5 PM support on top of existing OMAP4 PM support.
>>
>> OMAP5 adds a mercury retention feature which is an enhancement of
>> existing retention feature to reduce the leakage. No change in
>> programming model except one time enabling of mercury retention
>> during init.
>>
>> One more notable change in OMAP5 vs OMAP4 devices, CPUx power domains
>> support retention state which lets you hit MPUSS and Core retention with
>> very low latency C-states.
>>
>> Tested on OMAP4430 SDP, OMAP4460 Panda, OMAP5430 SDP and OMAP5432 Panda
>> devices with suspend and CPUIdle. Rootfs is mounted over ramdisk since
>> the mmc and nfs based fs needs DMA engine patches. For suspend wakeup,
>> I used Sourav's couple of serial wakeup wip patches from the lists.
> 
> I did the following build tests on [1]:
>     -> Native omap2plus build
>     -> Omap2 only build
>     -> Omap3 only build
>     -> Omap4 only build
>     -> Omap5 only build
>     -> AM33XX only build.
>     -> omap1_defconfig
> 
Thanks for the build coverage.

> And also did functional testing on [2] where omap5_pm branch[1] is merged.
>     On OMAP5430 EVM:     Suspend to RAM (UART wakeup)
>                          CPU_IDLE
>     On OMAP4430 SDP:     Suspend to RAM (UART wakeup)
>                          CPU_IDLE
Excellent.

> Note:
> 1) Disabled SMP for doing build test on Omap2/3 only builds.
I noticed this one as well.

> 2) If we enable CPU_IDLE on OMAP4430, debug message flood from reset_ctrl_regs() will appear.
>     As this is already disussed and a patch is already sent on Mainline
>     Will get more info on this here[3]
> 
Yep. I applied the patch while testing. The patch is already in RMK's queue as per Will D.

> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
>
Thanks a bunch for detailed testing and your tested-by tag.

Regards,
Santosh

> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux for_3.10/omap5_pm
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git testing/3.10/omap5_int
> [3] https://lkml.org/lkml/2013/3/13/50
> 

