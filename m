From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Thu, 18 Oct 2012 14:18:20 +0530
Message-ID: <507FC254.8030500@ti.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210180644170.15666@utopia.booyaka.com> <1350549436.2143.47.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab2JRIsd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 04:48:33 -0400
In-Reply-To: <1350549436.2143.47.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero, paul,

On Thursday 18 October 2012 02:07 PM, Tero Kristo wrote:
> On Thu, 2012-10-18 at 06:48 +0000, Paul Walmsley wrote:
>> On Thu, 18 Oct 2012, Paul Walmsley wrote:
>>
>>> Here are some basic OMAP test results for Linux v3.7-rc1.
>>> Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
>>
>> A few additional observations missing from the original message.
>>
>>> Failing tests: needing investigation
>>> ------------------------------------
>>>
>>> Boot tests:
>>>
>>> * 2420n800: boot hangs during UART initialization
>>>    - http://lkml.org/lkml/2012/9/11/454
>>>    - Various attempts at fixes posted; etiology known; issue still unresolved
>>>
>>> * CM-T3517: L3 in-band error with IPSS during boot
>>>    - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
>>>    - Longstanding issue; does not occur on the 3517EVM
>>>
>>> * 3517EVM & CM-T3517: boot hangs with NFS root
>>>    - Likely some Kconfig, board file, and PM issues with EMAC
>>>
>>> * CM-T3517: boot hangs with MMC boot
>>>    - Due to missing MMC setup in board file
>>
>> * 4430es2panda: clockevents problems early in boot
>>    - boots with dummy_timer
>>    - no one-shot mode so no-HZ is likely to fail
>
> I have a fix for this problem, however I am seeing this on omap4460
> panda. The root cause seems to be that local timer init for OMAP is
> using wrong interrupt number. It adds a wrong offset to the interrupt
> (OMAP_INTC_START) which should be omitted. Will send a patch soon along
> with a new version of core ret set.
>
This one is already fixed by [1] and Tony has sent pull request[1] to
arm-soc maintainers for 3.7-rc1 which includes the fix.

regards
santosh

[1] https://patchwork.kernel.org/patch/1587621/
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg78045.html


