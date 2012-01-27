From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Fri, 27 Jan 2012 21:36:05 +0100
Message-ID: <4F230AB5.1050607@ti.com>
References: <4F22DEF2.5000807@ti.com> <74CDBE0F657A3D45AFBB94109FB122FF178E123E7A@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52704 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab2A0UgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jan 2012 15:36:19 -0500
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E123E7A@HQMAIL01.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/27/2012 7:13 PM, Stephen Warren wrote:
> Cousson, Benoit wrote at Friday, January 27, 2012 10:29 AM:
>> Add some basic helpers to retrieve a DMA controller device_node
>> and the DMA request line number.
>>
>> For legacy reason another API will export the DMA request number
>> into a Linux resource of type IORESOURCE_DMA.
>> This API is usable only on system with an unique DMA controller.
>
> This binding looks reasonable to me; it's pretty much exactly what I
> was expecting the custom Tegra I2S binding might evolve into. A couple
> comments inline...

Well, that does not surprise me since this is your Tegra I2S binding 
that made me think that it should be time to define that generic DMA 
binding we've been waiting for a while :-)

>> diff --git a/Documentation/devicetree/bindings/dma/dma.txt
>
>> +* DMA client
>> +
>> +Client drivers should specify the DMA request numbers using a phandle to
>> +the controller + the DMA request number on that controller.
>> +
>> +Required properties:
>> +    - dma-request: List of pair phandle + dma-request per line
>> +    - dma-request-names: list of strings in the same order as the dma-request
>> +      in the dma-request property.
>
> I think property dma-request-names should be optional; some drives will
> simply request by index and hence the property won't be needed. Same as
> the common clock binding.

Yes, indeed, and it is optional in the code. I wrongly added that in the 
"required" paragraph. I'll fix that.

>> diff --git a/drivers/of/dma.c b/drivers/of/dma.c
>
>> +int of_get_dma_request(struct device_node *np, int index,
>> +		       struct device_node **ctrl_np)
>> +{
>> +	int ret = -EINVAL;
>> +	struct of_phandle_args dma_spec;
>> +
>> +	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
>> +					 index,&dma_spec);
>> +	if (ret) {
>> +		pr_debug("%s: can't parse dma property\n", __func__);
>> +		goto err0;
>> +	}
>> +
>> +	if (dma_spec.args_count>  0)
>> +		ret = dma_spec.args[0];
>
> Doesn't that force #dma-cells>  0? What about a DMA controller that only
> supports a single DMA request, in which case you might want #dma-cells==0?

OK, if such DMA controller exist, it will make sense.

> Having an of_xlate for the controller would be useful here in general:
>
> Is a single int really enough here?
>
> Some DMA controllers have N channels that can be used for arbitrary
> things. You may need to specify the DMA request once when allocating the
> channel, or maybe individual for each transfer if it can vary. Other
> controllers may need a special channel ID for each type of request. There
> are probably more cases I haven't thought of.

In my naive view of the DMA controller the channel is something that 
will be handled and allocated by the DMA controller upon driver request. 
So this is not something that is necessarily HW related, and thus should 
not be described in DT.
But, maybe I'm missing your point.

> So in general, I think this API should return some kind of cookie that's
> meaningful to the DMA controller, and this should be provided back to
> the DMA controller with every API that might need it; channel allocation,
> DMA transfer request, etc.

Forgive my ignorance, but the only DMA controller I've been using for a 
while is the OMAP2+ SDMA, hence this simplistic API that fit perfectly 
the OMAP need.

So I guess that having an xlate function like GPIO and IRQ will make 
sense if we have to handle these kind of variants.

> I suppose a controller may be able to represent that cookie in a single
> int, but perhaps not, e.g. if a binding needs #dma-cells=4 for some
> reason. Perhaps returning a void* here would be better, coupled with
> of_put_dma_request() to allow the controller to free it if required?
>
> That'd allow individual controller bindings to specify e.g. HW FIFO
> width, wrap, FIFO levels for HW flow control, ...
> (I vaguely recall that dmaengine addresses some of this already, but
> unfortunately I'm not very familiar with it yet)

Me neither, but do we have to handle all this parameters in DT? I guess 
that most of the configuration will still be under driver responsibility 
for the channel. The DMA controller itself can clearly defined a bunch 
of parameters to expose its capabilities, but again so far I do not have 
any clue about all these fancy DMA controller variants. Some flexibility 
will clearly be needed, but how far should we go?

The goal of that RFC was to start gathering some feedback to understand 
the requirements for the DMA bindings, so at least I have a couple of 
new ones now :-).

>> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
>
>> +#ifdef CONFIG_OF_GPIO
>
> CONFIG_OF_DMA

Oops, some leftover from the of_gpio.h copy-paste.

Thanks for the good feedback,
Benoit
