From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Tue, 20 Mar 2012 15:54:45 +0100
Message-ID: <4F689A35.2080305@atmel.com>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <20120317094059.7C2333E08E2@localhost> <4F6734DD.3020203@atmel.com>
 <20120319144517.C19E93E05A5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120319144517.C19E93E05A5@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/19/2012 03:45 PM, Grant Likely :
> On Mon, 19 Mar 2012 14:30:05 +0100, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>> On 03/17/2012 10:40 AM, Grant Likely :
>>> On Thu, 15 Mar 2012 09:38:10 +0100, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>>> +struct of_dma {
>>>> +	struct list_head of_dma_controllers;
>>>> +	struct device_node *of_node;
>>>> +	int of_dma_n_cells;
>>>> +	int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
>>>> +};
>>>
>>> This _xlate is nearly useless as a generic API.  It solves the problem for
>>> the specific case where the driver is hard-coded to know which DMA engine
>>> to talk to, but since the returned data doesn't provide any context, it
>>> isn't useful if there are multiple DMA controllers to choose from.
>>
>> You mean, if there is no DMA controller phandle specified in the
>> property?
> 
> No; I'm assuming that dma-channel properties will alwasy have a
> phandle to the dma controller node.
> 
>> I think that it is not the purpose of this API to choose a DMA
>> controller, Nor to provide a channel. The only purpose of this API is to
>> give a HW request to be used by a DMA slave driver. This slave should
>> already have a channel to use and a controller to talk to.
> 
> Then where is the function that finds the reference to the DMA
> controller?  I don't understand why it would be useful to decode that
> separately.
> 
>>> The void *data pointer must be replaced with a typed structure so that
>>> context can be returned.
>>
>> I am not sure to follow you entirely... How do I address the fact that
>> several types of request value can be returned then?
>>
>> BTW, can we imagine a phandle property with a sting as a argument?
>> should it be written this way?
>> dma-request = <&testdmac1>, "slave-rx", "slave-tx";
> 
> No, I'm not suggesting that.  Mixing phandles and strings in a single
> property is possible but ugly.  The phandle-args pattern which uses
> zero or more cells as arguments should be used.
> 
>>
>> If yes, the of_parse_phandle_with_args() is not working on this type...
> 
> Right; of_parse_phandle_with_args() should do the job.
> 
>>
>> (I realize that there seems to be no way out for a generic API: maybe we
>> should move to one or two cases to address and concentrate on them).
> 
> The way I read this patch, the xlate function returns a single
> integer representing the DMA request number, but it doesn't provide
> any data about *which* dma controller is associated with that channel.
> The result of xlate needs to be something like a dma_chan reference
> that identifies both the DMA engine and the channel/request on that
> dma engine.
> 
> [...]
>>>> +/**
>>>> + * of_dma_xlate_onenumbercell() - Generic DMA xlate for direct one cell bindings
>>>> + *
>>>> + * Device Tree DMA translation function which works with one cell bindings
>>>> + * where the cell values map directly to the hardware request number understood
>>>> + * by the DMA controller.
>>>> + */
>>>> +int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec, void *dma_req)
>>>> +{
>>>> +	if (!dma_spec)
>>>> +		return -EINVAL;
>>>> +	if (WARN_ON(dma_spec->args_count != 1))
>>>> +		return -EINVAL;
>>>> +	*(int *)dma_req = dma_spec->args[0];
>>>
>>> Following on from comment above; the void *dma_req parameter is dangerous.  How
>>> does this function know that it has been passed an int* pointer?
>>
>> Well, that is a drawback that comes from having to address generic
>> cases.
> 
> Not if you do it right.  If a specific data structure is returned,
> then there can be context attached as to what the data means and which
> dma controller knows how to parse it.
> 
>> But anyway, if the DMA controller decide to register a .xlate()
>> function that returns an integer, the slave driver that will ask a
>> "request line" to this DMA controller will be aware that an integer has
>> to be passed to of_get_dma_request().
> 
> The problem still remains; I don't see how the dma slave can figure
> out *which* dma controller it needs to talk to.

Is not it what the phandle to the dma controller is made for?

Bye,
-- 
Nicolas Ferre
