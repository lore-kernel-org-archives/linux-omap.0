From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Feb 2013 10:50:57 -0700
Message-ID: <512E4781.8050701@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <512D3FE6.1010300@wwwdotorg.org> <512D490B.70900@ti.com> <512D4FC4.2060505@wwwdotorg.org> <512D5C58.4090500@ti.com> <CAAwP0s3rbExrSf-W325uCPfMO=Zk9LefRP0VD4JC1tg_sxS_gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48311 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760049Ab3B0RvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Feb 2013 12:51:01 -0500
In-Reply-To: <CAAwP0s3rbExrSf-W325uCPfMO=Zk9LefRP0VD4JC1tg_sxS_gQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>

On 02/26/2013 08:57 PM, Javier Martinez Canillas wrote:
> On Wed, Feb 27, 2013 at 2:07 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>> On 02/26/2013 06:13 PM, Stephen Warren wrote:
>>> On 02/26/2013 04:45 PM, Jon Hunter wrote:
...
>>>> One issue I see is that by not calling gpio_request, then potentially
>>>> you could have someone request a gpio via gpio_request() and someone
>>>> trying to use it as an interrupt source via request_irq(). Now obviously
>>>> that represents a bug because there is only one physical gpio, but I
>>>> gather it is something we need to protect against.
>>>
>>> I'm not sure it's really that much of an issue, but presumably the
>>> solution is for a combined GPIO+IRQ driver to simply call gpio_request
>>> internally from within some irq_chip function. It looks like struct
>>> irq_chip doesn't have a request/free, but perhaps they could be added to
>>> solve this?
>>
>> Yes I was wondering if we could do something like that. That would work,
>> may be that's what we should propose.
> 
> Something like that would definitely solve the GPIO request issue but
> we still have the issue that the current OMAP GPIO controller binding
> does not support #interrupt-cells = <2>.

The binding documentation in
Documentation/devicetree/bindings/gpio/gpio-omap.txt indicates that it
does. If this doesn't work in practice, it's a driver bug that can
presumably be easily fixed. And no need to change any ABI definitions:-)

BTW, I notice in that binding document that the description of the two
cells for #interrupt-cells is actually part of the description of the
"interrupt-controller" property; it should be moved up one line really.
