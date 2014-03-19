From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] dma: edma: fix incorrect SG list handling
Date: Wed, 19 Mar 2014 15:50:20 +0530
Message-ID: <53296F64.10308@ti.com>
References: <1395057448-22904-1-git-send-email-nsekhar@ti.com>	<alpine.DEB.2.02.1403170854570.9730@jringle-ubuntu>	<5326F2BF.6040702@ti.com>	<alpine.DEB.2.02.1403170913110.9730@jringle-ubuntu>	<20140318152840.GD1976@intel.com> <5328946C.3010508@ti.com> <53291F72.9060504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38664 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759166AbaCSKUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 06:20:31 -0400
In-Reply-To: <53291F72.9060504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>, Vinod Koul <vinod.koul@intel.com>, Jon Ringle <jon@ringle.org>
Cc: DMA Engine Mailing List <dmaengine@vger.kernel.org>, "Ringle, Jonathan" <Jonathan.Ringle@gridpoint.com>, Dan Williams <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux DaVinci Mailing List <davinci-linux-open-source@linux.davincidsp.com>

On Wednesday 19 March 2014 10:09 AM, Sekhar Nori wrote:
> On Wednesday 19 March 2014 12:16 AM, Joel Fernandes wrote:
>> On 03/18/2014 10:28 AM, Vinod Koul wrote:
>>> where is this patch, somehow am not able to find in my inbox or archives...
>>>
>>
>> I found it archived here:
>> http://comments.gmane.org/gmane.linux.davinci/28569
>>
>> Patch doesn't breaking anything for > MAX_NR_SG list size on AM335x, so
>> it looks good.
>>
>> Acked-by: Joel Fernandes <joelf@ti.com>
> 
> Joel, thanks for the ack.
> 
> Vinod, Looks like the vger and Intel spam filters dropped the patch. I
> will try again.

Okay, I see see the patch in dmaengine list archives now and hopefully
it has reached Vinod too.

I think the issue last time around was that From: and Return-Path:
headers ended up having different addresses.

Thanks,
Sekhar

