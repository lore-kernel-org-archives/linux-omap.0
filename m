From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH RFC] usb: musb: fail unaligned DMA transfers on v1.8 and
 above
Date: Mon, 08 Nov 2010 11:51:55 +0530
Message-ID: <4CD79703.6010503@ti.com>
References: <1288502759-18618-1-git-send-email-gadiyar@ti.com> <AANLkTimAmGNtH3OTF9+G55jVYrokwe6bqENhaxHmtdv+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46273 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994Ab0KHGWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 01:22:05 -0500
In-Reply-To: <AANLkTimAmGNtH3OTF9+G55jVYrokwe6bqENhaxHmtdv+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Felipe Balbi <balbi@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Mike Frysinger <vapier@gentoo.org>, hemahk@ti.com

On 10/31/2010 3:29 PM, Ming Lei wrote:
> 2010/10/31 Anand Gadiyar<gadiyar@ti.com>:
>> The Inventra DMA engine in version 1.8 and later of the MUSB
>> controller cannot handle DMA addresses that are not aligned
>> to a 4 byte boundary. It ends up ignoring the last two bits
>> programmed in the DMA_ADDR register. This is a deliberate
>> design change in the controller and is documented in the
>> programming guide.
>>
>> Earlier versions of the controller could handle these
>> accesses just fine.
>>
>> Fail dma_channel_program if we see an unaligned address when
>> using the newer controllers, so that the caller can carry out
>> the transfer using PIO mode.
>> (Current callers already have this backup path in place).
>>
>> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Cc: Ming Lei<tom.leiming@gmail.com>
>> Cc: Ajay Kumar Gupta<ajay.gupta@ti.com>
>> Cc: Mike Frysinger<vapier@gentoo.org>
>
> Tested-by: Ming Lei<tom.leiming@gmail.com>
>
> This patch is verified OK about g_ether function on beagle xM board,
> but the revised patch "usb: musb: gadget: Unmapping the dma buffer
> when switching to PIO mode" [1] should be applied first.
>
>> ---
>> Patch based on linux-next as of 20101029.
>>
>> I believe Blackfin is also affected by this, but I'm not sure how
>> they're working around this. Mike?
>
> MUSB on Blackfin will fallback to PIO too, so no any working around
> for it, right?
>

I meant Blackfin should also have hit this issue so far. I'm making
a change based on the MUSB revision - so this change will affect 
Blackfin for sure - they use revision 1.9 and 2.0 I think. So I'm just 
wondering if they really are affected, or they've simply never hit this 
scenario before.

- Anand
