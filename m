From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
Date: Mon, 5 Nov 2012 12:25:40 +0100
Message-ID: <5097A234.7070504@ti.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com> <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com> <5094D648.80608@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58813 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2KELZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 06:25:52 -0500
In-Reply-To: <5094D648.80608@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On 11/03/2012 09:31 AM, Kevin Hilman wrote:
> On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
>> When booting with DT the OF core can fill up the resources provided
>> within
>> the DT blob.
>> The current way of handling the DT boot prevents us from removing
>> hwmod data
>> for platforms only suppose to boot with DT (OMAP5 for example) since
>> we need
>> to keep the whole hwmod database intact in order to have more
>> resources in
>> hwmod than in DT (to be able to append the DMA resource from hwmod).
>>
>> To fix this issue we just examine the OF provided resources:
>> If we do not have resources we use hwmod to fill them.
>> If we have resources we check if we already able to recive DMA
>> resource, if
>> no we only append the DMA resurce from hwmod to the OF provided ones.
>>
>> In this way we can start removing hwmod data for devices which have their
>> resources correctly configured in DT without regressions.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>ke
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Benoit, feel free to take this one as well.

Thanks, I'll do.

Regards,
Benoit

