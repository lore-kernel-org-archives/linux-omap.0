From: "Fernandes, Joel" <joelf@ti.com>
Subject: Re: [PATCH v3] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 9 Oct 2013 06:03:58 +0000
Message-ID: <F774F8C9-0A8F-4B27-8607-874FB0901A78@ti.com>
References: <1380639886-9526-1-git-send-email-zonque@gmail.com>
 <5254DB86.4000104@ti.com>,<5254E60F.80009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab3JIGEb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 02:04:31 -0400
In-Reply-To: <5254E60F.80009@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "neumann@teufel.de" <neumann@teufel.de>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Balbi, Felipe" <balbi@ti.com>

Some temporary issues with my mua so forgive any artifacts in this email.

On Oct 9, 2013, at 12:14 AM, "Hebbar, Gururaja" <gururaja.hebbar@ti.com> wrote:

> On Wednesday 09 October 2013 09:58 AM, Joel Fernandes wrote:
>> On 10/01/2013 10:04 AM, Daniel Mack wrote:
>>> This patch makes the edma driver resume correctly after suspend. Tested
>>> on an AM33xx platform with cyclic audio streams.
>>> 
>>> The code was shamelessly taken from an ancient BSP tree.
>>> 
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> ---
>>> arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 133 insertions(+)
> 
> ..snip..
> ..snip..
>> 
>>> +        edma_cc[j]->context.ch_map =
>>> +            kzalloc((sizeof(unsigned int) *
>>> +                 edma_cc[j]->num_channels), GFP_KERNEL);
>>> +        edma_cc[j]->context.que_num =
>>> +            kzalloc((sizeof(unsigned int) * 8), GFP_KERNEL);
>> 
>> Can these allocations be moved to the suspend path? For systems that don't
>> suspend/resume even once, I feel we shouldn't allocate memory that we don't use.
>> These allocations are better to do there.
> 
> AFAIK, Suspend/resume should be quick. Allocating and deallocating on
> every iterating would be useless and time consuming.

Nobody said allocate and deallocate on every iteration. Allocate once during the first suspend call and then don't have to allocate on subsequent calls.

As for suspend resume being quick, that argument can flipped the other way too, booting should be quick which is far more frequent than suspend/resume. Apart from the fact that we're not allocating useless memory we would never use.

> 
> Also this task is one time and quick.

Exactly.

> 
> Are there any systems (Linux based for now) which doesn't
> suspend/resume? I believe the probability is very less.

Nobody talked about suspend/resume not being supported in Linux so not sure what your argument is here.

regards,

-Joel

> 
> regards
> Gururaja
> 
>> 
>> -Joel
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
