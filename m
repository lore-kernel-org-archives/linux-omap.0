From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v6] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Thu, 02 Dec 2010 09:58:10 +0200
Message-ID: <4CF75192.3090705@nokia.com>
References: <1291229228-4438-1-git-send-email-manjugk@ti.com> <4CF6AD2C.4020907@nokia.com> <20101202061139.GA5645@GLPP-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:34756 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab0LBH7W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 02:59:22 -0500
In-Reply-To: <20101202061139.GA5645@GLPP-machine>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/12/10 08:12, ext G, Manjunath Kondaiah wrote:
> * Adrian Hunter<adrian.hunter@nokia.com>  [2010-12-01 22:16:44 +0200]:
>
>> On 01/12/10 20:47, ext G, Manjunath Kondaiah wrote:
>>> Certain errata in OMAP2+ processors will require forcing
>>> master standby to "no standby" mode before completing on going
>>> operation. Without this, the results will be unpredictable.
>>>
>>> Since current implementation of PM run time framework does not support
>>> changing sysconfig settings during middle of the on going operation,
>>> these API's will support the same. One API will force the device's
>>> sysconfig mstandby mode settings to "no standby" and other API will
>>> release "no standby" mode and sets it to "smart standby" or "no
>>> standby? depending on HWMOD_SWSUP_MSTANDBY value.
>>>
>>> These API's should be used by device drivers only incase of
>>> erratum applicable to their modules if there is no other methods
>>> to resolve.
>>>
>>> These API's are required for multiple DMA errata which require
>>> putting DMA controller in no mstandby mode before stopping dma.
>>>
>>> The applicable errata:
>>> 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
>>> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
>>> through config port while in Standby.
>>>
>>> 2. Erratum ID: i541
>>> sDMA FIFO draining does not finish. Applicable to all omap2+ except
>>> omap4.
>>>
>>> 3. Erratum ID:i88
>>> The sDMA to be put in no mstandby mode before disabling the channel
>>> after completing the data transfer operation.
>>> Applicable only for OMAP3430 ES1.0
>>>
>>> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
>>> omap_hwmod.h
>>>
>>> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>>
>>> ---
>>> Change summary:
>>> v3: Review comments incorporated for:
>>> https://patchwork.kernel.org/patch/282212/
>>> v4: added mutex changes
>>> v5: typo fixes for errata and erratum
>>> v6: fixed oh increment bug and also mutex(missing in v5)
>>>
>>>   arch/arm/mach-omap2/omap_hwmod.c              |   47 +++++++++++++++++++-
>>>   arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>>>   arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>>>   arch/arm/plat-omap/omap_device.c              |   60 +++++++++++++++++++++++++
>>>   4 files changed, 111 insertions(+), 2 deletions(-)
>>>
>>
>> Does not seem to handle overlapping requests to set/clear
>> midle mode.
>
> We can have use count so that we can avoid register access during
> middle of operation if mstandby mode is already changed to "no standby"
> mode.

Exactly

>
>>
>> Also, there is a mutex but don't these functions get called
>> sometimes in interrupt context?
>
> I feel we should leave this to caller of these API's. The caller should
> make sure that, he disables interrupts if it is used in interrupt context.

How does that help?  It seems to me that a mutex cannot be used for this.

>
> -Manjunath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

