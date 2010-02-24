From: Philip Balister <philip@balister.org>
Subject: Re: DMA example
Date: Wed, 24 Feb 2010 14:31:09 -0800
Message-ID: <4B85A8AD.5060206@balister.org>
References: <4B857F2F.7000201@balister.org> <20100224203555.GT28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:21638 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758178Ab0BXWbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 17:31:15 -0500
In-Reply-To: <20100224203555.GT28173@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/24/2010 12:35 PM, Tony Lindgren wrote:
> * Philip Balister<philip@balister.org>  [100224 11:31]:
>> I am trying to setup a dma operation to copy memory from GPMC
>> address space into RAM. The only examples using the omap-dma api use
>> hardware triggers.
>>
>> When I start a transfer, I end up with a DMA transaction error when
>> I start the transfer.
>>
>> Does anyone have a good example of a software transfer? Currently, I
>> am tracing the omap dma api to see how things map into the registers
>> ....
>
> Enjoy the GPMC timings. I recommend attaching a logic analyzer there
> to verify the things are right for the key lines if you have chance.
>
> Hmm I thought the hardware triggers were optional in at least
> drivers/usb/musb/tusb6010_omap.c.. Maybe I don't remember correctly.

GPMC is easy :)

Basically, I have a device attached to a GPMC chip select and I need to 
read/write to it. The GPNC bit is fine, we'd just like to use the DMA 
controller to move the data.

Philip
