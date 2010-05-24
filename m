From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Mon, 24 May 2010 20:01:26 +0530 (IST)
Message-ID: <54347.192.168.10.88.1274711486.squirrel@dbdmail.itg.ti.com>
References: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
    <87pr0le65b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45585 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab0EXOba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 10:31:30 -0400
In-Reply-To: <87pr0le65b.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org



> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Patch series is based on remotes/origin/pm-wip/govindraj
>> branch from Kevin's PM tree.
>>
>> Patches are tested with 3430SDP.
>> Have updated 2420/2430 hwmod data files
>> it would be great if some one can test the same.
>
> Hi Govindraj,
>
> This series looks great.  I've added it to pm-wip/uart for broader testing,
> but there were a couple minor issues I pointed out.

I think you are referring to uart4 crash on 3630,
addressed the same:

http://marc.info/?l=linux-omap&m=127470579930240&w=2


>
> Feel free to send fixes on top of pm-wip/uart and I will merge/fold them
> in.

Sure.

>
> FYI, the way I am testing is taking pm-wip/uart and merging with
> current PM branch and testing using omap3_defconfig.
>

Thanks, will try to do one around of testing in the same manner.


> Kevin
>
>> Govindraj.R (6):
>>   Serial: Clean up set_uart_globals.
>>   Serial: Add UART4 hwmod data.
>>   Serial: Modify OMAP3 hwmod data file with uart data.
>>   Serial: Add UART hwmod data for 2420.
>>   Serial: Add UART hwmod data for 2430.
>>   Serial: Update UART HWMOD layer.
>>
>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  184 ++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  184 ++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 +++++++++-
>>  arch/arm/mach-omap2/prcm-common.h          |    2 +
>>  arch/arm/mach-omap2/serial.c               |   38 +++----
>>  arch/arm/plat-omap/common.c                |   17 ---
>>  arch/arm/plat-omap/include/plat/common.h   |    1 -
>>  arch/arm/plat-omap/include/plat/dma.h      |    2 +
>>  arch/arm/plat-omap/include/plat/irqs.h     |    2 +
>>  9 files changed, 449 insertions(+), 47 deletions(-)
>


