From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH] of: DMA helpers: manage generic requests specification
Date: Mon, 5 Mar 2012 14:14:22 +0100
Message-ID: <4F54BC2E.3040702@ti.com>
References: <4F22DEF2.5000807@ti.com> <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com> <74CDBE0F657A3D45AFBB94109FB122FF17BDDF217B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab2CENOz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 08:14:55 -0500
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF217B@HQMAIL01.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>

On 2/29/2012 9:54 PM, Stephen Warren wrote:
> Nicolas Ferre wrote at Wednesday, February 29, 2012 7:54 AM:
>> By making DMA controllers register a generic translation
>> function, we allow the management of any type of DMA requests
>> specification.
>> The void * output of an of_dma_xlate() function that will be implemented
>> by the DMA controller can carry any type of "dma-request" argument.
>>
>> The DMA client will search its associated DMA controller in the list
>> and call the registered of_dam_xlate() function to retrieve the
>> request values.
>>
>> One simple xlate function is provided for the "single number" type
>> of request biding.
>>
>> This implementation is independent from dmaengine so it can also be
>> used by legacy drivers.
>
> At a high level this seems along the right lines.
>
> The big issue I see is the lack of type-safety in of_get_dma_request()'s
> out_data pointer: The DMA xlate function will assume it points at some
> particular type, and the client is responsible for allocating that
> correct type. However, it's "user"-supplied device tree data that hooks
> the two together, and there could easily be mismatches, thus causing
> the xlate function to trash memory.
>
> Could each DMA controller (or type of out_data) have some enum in the
> kernel that the client passes in, and the DMA engine validates matches
> its expectations, to prevent this kind of thing?

Beside u32 and string, do we know what kind of parameters we can expect 
to retrieve?
Because we can potentially reduce the scope to these two types only.

> enum DMA_PARAMS_TYPE {
>      FOO_DMA_PARAMS,
>      BAR_DMA_PARAMS,
>      ...
> };
>
> struct foo_dma_params { ... };
>
> struct foo_dma_params params;
>
> of_get_dma_request(np, 0,&params, FOO_DMA_PARAMS);
>
> and inside xlate():
>
> if (params_type != FOO_DMA_PARAMS)
>      return -EINVAL;
>
> For the dmaengine case, I assume there'd be a single DMA_PARAMS_TYPE
> value for the dmaengine specifier type, and the dmaengine core would
> take care of making sure everything matched somehow.

Regards,
Benoit
