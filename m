From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1
 CPU devices
Date: Fri, 2 Aug 2013 11:18:08 -0400
Message-ID: <51FBCDB0.4070401@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com> <20130802141828.GC2361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53295 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3HBPSn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 11:18:43 -0400
In-Reply-To: <20130802141828.GC2361@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Friday 02 August 2013 10:18 AM, Dave Martin wrote:
> On Thu, Aug 01, 2013 at 02:17:13PM -0400, Santosh Shilimkar wrote:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> The generic code is well equipped to differentiate between
>> SMP and UP configurations.However, there are some devices which
>> use Cortex-A9 MP core IP with 1 CPU as configuration. To let
>> these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
>> the SMP_ON_UP support, we need to additionally check the
>> number the cores in Cortex-A9 MPCore configuration. Without
>> such a check in place, the startup code tries to execute
>> ALT_SMP() set of instructions which lead to CPU faults.
>>
>> The issue was spotted on TI's Aegis device and this patch
>> makes now the device work with omap2plus_defconfig which
>> enables SMP by default. The change is kept limited to only
>> Cortex-A9 MPCore detection code.
> 
> Is there a specific reason why this can't happen for other processors
> such as A5/7/15?
> 
The basic reason behind limiting to A9 was the SCU carrying
the no. of CPU information is specific to A9. A7/A15 have
that information encoded in L2 control register. Since
same code won't work for the other ARM versions and we
don't wanted to pollute the code much without need of it
those versions are not considered.

Regards,
Santosh



