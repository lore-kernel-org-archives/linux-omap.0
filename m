From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 9 Oct 2013 10:43:51 +0530
Message-ID: <5254E60F.80009@ti.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com> <5254DB86.4000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42730 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3JIFPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 01:15:02 -0400
In-Reply-To: <5254DB86.4000104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: joelf@ti.com, Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On Wednesday 09 October 2013 09:58 AM, Joel Fernandes wrote:
> On 10/01/2013 10:04 AM, Daniel Mack wrote:
>> This patch makes the edma driver resume correctly after suspend. Tested
>> on an AM33xx platform with cyclic audio streams.
>>
>> The code was shamelessly taken from an ancient BSP tree.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 133 insertions(+)
>>

..snip..
..snip..
> 
>> +		edma_cc[j]->context.ch_map =
>> +			kzalloc((sizeof(unsigned int) *
>> +				 edma_cc[j]->num_channels), GFP_KERNEL);
>> +		edma_cc[j]->context.que_num =
>> +			kzalloc((sizeof(unsigned int) * 8), GFP_KERNEL);
> 
> Can these allocations be moved to the suspend path? For systems that don't
> suspend/resume even once, I feel we shouldn't allocate memory that we don't use.
> These allocations are better to do there.

AFAIK, Suspend/resume should be quick. Allocating and deallocating on
every iterating would be useless and time consuming.

Also this task is one time and quick.

Are there any systems (Linux based for now) which doesn't
suspend/resume? I believe the probability is very less.

regards
Gururaja

> 
> -Joel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

