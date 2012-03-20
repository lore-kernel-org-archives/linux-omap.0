From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
Date: Tue, 20 Mar 2012 10:00:10 +0100
Message-ID: <4F68471A.4010502@ti.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com> <20120319191743.GB9859@atomide.com> <4F67B9F9.1030906@ti.com> <20120319233910.GF9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34933 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965000Ab2CTJAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 05:00:17 -0400
In-Reply-To: <20120319233910.GF9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

On 3/20/2012 12:39 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [120319 16:00]:
>> Hi Tony,
>>
>> On 3/19/2012 8:17 PM, Tony Lindgren wrote:
>>> * Tarun Kanti DebBarma<tarun.kanti@ti.com>   [120319 05:09]:
>>>> These two patches incorporate changes to OMAP1 and OMAP2 platforms
>>>> board files whereby older references to OMAP_GPIO_IRQ macro are
>>>> now replaced with gpio_to_irq(), thereby getting rid of static
>>>> irq references.
>>>>
>>>> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
>>>> Commit: 9a0cee711448335ec43eae83272495e9334c0098
>>>
>>> Can you please tell the exact two commits causing this
>>> breakage?
>>
>> Well, this is the GPIO DT + SPARSE_IRQ series I have done. It
>> appears that the boards I have were already using properly
>> gpio_to_irq() and thus were working fine with this series.
>>
>> But this is unfortunately not the case of most OMAP2 and 3 legacy
>> boards that were still using an old OMAP way of converting GPIO to
>> IRQ and were never modified to take advantage of the gpiolib stuff.
>>
>> So if these patches are apply before the GPIO DT + SPARSE_IRQ
>> series, there will be no breakage at all.
>>
>> All the cleanup we have never done before will hurt us at some point
>> when we will start using more extensively newer fmwk (DT,
>> sparse_irq, dmaengine...). It was not done on purpose, but this GPIO
>> series highlighted this remaining static broken mapping inside OMAP
>> boards.
>
> Yes I understand. But still, which patch(s) cause the issue
> so we can put that in the changelog for the fixes?

OK, here they are:
25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
384ebe1 gpio/omap: Add DT support to GPIO driver

Tarun,

You should indeed add the references in your cover letter.

>>> I'm baffled how despite all the effort for previnting
>>> issues like this this still happen. These all seem valid
>>> fixes and clean up things, but how come this was not seen
>>> earlier?
>>
>> Maybe because there are much more boards inside mach-omap2 directory
>> than inside my cubicle... :-(
>
> Well somehow we need to make sure that patches get properly
> tested on a reasonable selection of boards. This pretty much
> breaks things for 21 boards out of the 51 board-*.c files :(

What is too bad is that one broken board was enough to figured out the 
issue and fix all the other ones. I just did not have that one :-(

Regards,
Benoit
