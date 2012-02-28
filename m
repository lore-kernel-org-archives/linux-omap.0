From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/6] gpio/omap: Cleanup and adaptation to Device Tree
Date: Tue, 28 Feb 2012 11:02:16 +0100
Message-ID: <4F4CA628.40202@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com> <87linnrbt8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48762 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab2B1KCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:02:21 -0500
In-Reply-To: <87linnrbt8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2/28/2012 2:22 AM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Hi Grant,
>>
>> Here are a couple of GPIO cleanup + the DT adaptation patches.
>> This update (compared to v1 [1]) is adding an extra fix for SPARSE_IRQ support
>> and add the second cell in the binding for GPIO IRQ type that was missing
>> previously whereas the driver does support it.
>
> For the OMAP GPIO changes,
>
> Reviewed-by: Kevin Hilman<khilman@ti.com>

Thanks Kevin.

> However, I had some problems trying to merge this to test it.
>
> I'm also curious how/who we should merge this.  Since it depends on
> stuff that Grant is queueing (or has queued), I suppose it should go
> through his tree.

Yes, that was my plan.
I will probably removed the DTS patches and sent that to Tony to avoid 
the merge conflict that will happen since we should merge i2c, gpio, spi 
and mmc during merge window in the same omapX.dtsi files.

>> This series is based on 3.3-rc4 + for_3.4/dt_base branch to get
>> the needed cleanup and fixes for OMAP.
>>
>> The interrupt controller support is using irq_domain_add_legacy for
>> the moment and will be updated next to use irqchip irq_domain.
>
> It appears your current dt_gpio branch is based on some older version of
> your dt_irq_domain branch than the one you just submitted for a pull request.

Indeed... I was waiting Tony to create a stable branch I can use to base 
the other OMAP series. But neither GPIO nor SPI has any dependency with 
core OMAP stuff so I can push at lest GPIO them without that.

>> It requires the irq_domain generalization and refinement series
>> available at:
>>    git://git.secretlab.ca/git/linux-2.6 irqdomain/next
>>
>> It requires as well Tarun's GPIO cleanup series available at:
>>    git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9
>
> Rather than Tarun's branch, can you use Grant's GPIO branch, which has
> the final version he pulled from my for_3.4/gpio/runtime-pm-cleanup
> branch.  Tarun's branch causes some merge conflicts with what Grant has
> already merged.

Yes, that was the plan as well. I've just rebased on top of Grant's 
gpio/next branch, and will send a pull request to Grant.

Thanks,
Benoit
