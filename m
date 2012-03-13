From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 12/12] ARM: OMAP2+: board-omap4-*: Do not use anymore
 TWL6030_IRQ_BASE in board files
Date: Tue, 13 Mar 2012 22:35:22 +0100
Message-ID: <4F5FBD9A.4030607@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com> <1330707024-23730-13-git-send-email-b-cousson@ti.com> <20120313170756.GK12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab2CMVfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 17:35:44 -0400
In-Reply-To: <20120313170756.GK12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 3/13/2012 6:07 PM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [120302 08:19]:
>> With the introduction of dynamically allocated IRQ in the twl6030 driver,
>> the board files can no longer rely of static IRQ defines like before.
>>
>> Retrieve the value dynamically allocated from the mmc ->  twl6030 init
>> callback.
>>
>> Note: The Panda board does not seems to use the card detect IRQ.
>
> Looks like this one is safe to merge via MFD and does not seem to
> cause any merge conflicts.
>
> This one should be folded into patch 08/12 to avoid boot issues
> for between patches 08 and 12 in this series. Other than that:

In fact there is no need to merge them. They should just be at the 
beginning of the series.

The first patch...
  mfd: twl6030-irq: Return twl6030_mmc_card_detect IRQ for board setup

-       return 0;
+
+       return twl6030_irq_base + MMCDETECT_INTR_OFFSET;

...will just return the proper interrupt number instead of 0, but at 
that time, the board is still using the static TWL6030_IRQ_BASE + 
MMCDETECT_INTR_OFFSET value.

Only the next one...
  ARM: OMAP2+: board-omap4-*: Do not use anymore TWL6030_IRQ_BASE in 
board files
...will switch from the static to the value returned by 
twl6030_mmc_card_detect and then it keeps working.

> Acked-by: Tony Lindgren<tony@atomide.com>

Cool, I'll send the pull request to Samuel ASAP.

Thanks,
Benoit
