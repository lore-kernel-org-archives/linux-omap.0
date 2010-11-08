From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
Date: Mon, 8 Nov 2010 18:05:53 -0500
Message-ID: <4CD88251.4060400@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>	<1289006396-27230-3-git-send-email-omar.ramirez@ti.com>	<4CD5A96D.1000806@ti.com> <AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49634 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab0KHXEu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 18:04:50 -0500
In-Reply-To: <AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11/7/2010 11:00 AM, Ramirez Luna, Omar wrote:
> On Sat, Nov 6, 2010 at 2:15 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>>
>>> Add mmu hwmod data for iva2 and isp.
>>
>> s/iva2/iva/
>
> Where this terminology can be found? I'm basing this naming on what
> was there or TRM. For omap3 there is no such thing as iva, it is iva2.

IVA2 means IVA v2, before we had an IVA (v1) then IVA v1.1...

The goal is to use the same name for the IP with similar functionality 
across OMAPs version in order to have generic code in the driver.

IVA, IVA2, IVAHD are all doing similar things, so the only way to 
identify the same functionality is by using the same name.
Thanks to the rev field, you can differentiate the various version 
during device creation.
That will allow you to query the hwmod on every version of OMAPs using 
the same "iva" name. Otherwise you will have to use the cpu_is_omap_XXX 
to select iva, iva2 or ivahd depending of the SoC.

Does that make sense to you?

Benoit
