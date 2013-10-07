From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: check for module address space during
 init
Date: Mon, 7 Oct 2013 17:04:18 -0500
Message-ID: <52532FE2.3070702@ti.com>
References: <1380819546-53631-1-git-send-email-s-anna@ti.com> <5253257A.2070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49129 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab3JGWFN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Oct 2013 18:05:13 -0400
In-Reply-To: <5253257A.2070301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 10/07/2013 04:19 PM, Nishanth Menon wrote:
> On 10/03/2013 11:59 AM, Suman Anna wrote:
>> The hwmod init sequence involves initializing and idling all the
>> hwmods during bootup. If a module class has sysconfig, the init
>> sequence utilizes the module register base for performing any
>> sysc configuration.
>>
>> The module address space is being removed from hwmod database and
>> retrieved from the <reg> property of the corresponding DT node.
>> If a hwmod does not have its corresponding DT node defined and the
>> memory address space is not defined in the corresponding
>> omap_hwmod_ocp_if, then the module register target address space
>> would be NULL and any sysc programming would result in a NULL
>> pointer dereference and a kernel boot hang.
>>
>> Handle this scenario by checking for a valid module address space
>> during the _init of each hwmod, and leaving it in the registered
>> state if no module register address base is defined in either of
>> the hwmod data or the DT data.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> This patch helps break the dependencies between hwmod entries and
>> corresponding DT entries (especially on OMAP5, where most of the
>> address spaces are already cleaned up and the current data files
>> have minimal entries) and fixes any boot issues due to missing
>> addresses. See for reference,
>> http://marc.info/?t=138005421400003&r=1&w=2
>>
>> Tested on BeagleXM, Panda4, BeagleBone Black and Panda5 using
>> Tero's v7 clk DT patches and Benoit's for-3.13/dts on top of
>> 3.12-rc3
>>
>>  arch/arm/mach-omap2/omap_hwmod.c | 29 +++++++++++++++++++----------
>>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> Mandatory to have this patch for OMAP5uEVM to boot after Tero's v7 [1]
> series is merged else the delta between dts and hwmod entries cause
> OMAP5 platforms to croak and die - at least worked around as seen in
> [2] :(
> 
> Tested-by: Nishanth Menon <nm@ti.com>
> 
> [1] http://marc.info/?t=138009899400001&r=1&w=2
> [2] OMAP5uEVM: http://pastebin.com/jtEMwTY5
> 

This patch should also help Paul to be able to pick up the OMAP5
hwspinlock hwmod data [3] and would yield a similar warning without
its corresponding DT node as in Nishant's log [2]. Obviously, both
hwmod and DT need to be present for the associated driver to work, but
atleast it doesn't hang the boot.

regards
Suman

[3] http://marc.info/?l=linux-omap&m=138055666108306&w=2
