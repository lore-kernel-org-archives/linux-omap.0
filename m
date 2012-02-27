From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Mon, 27 Feb 2012 14:09:41 +0100
Message-ID: <4F4B8095.9010005@atmel.com>
References: <4F22DEF2.5000807@ti.com> <4F44CA82.9060906@atmel.com>
 <4F460EF2.9010000@ti.com> <4F46609C.8080907@atmel.com>
 <4F4661DE.90704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4F4661DE.90704-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/23/2012 04:57 PM, Cousson, Benoit :
> On 2/23/2012 4:51 PM, Nicolas Ferre wrote:
>> On 02/23/2012 11:03 AM, Cousson, Benoit :
>>> Salut Nico,
>>
>> Coucou Benoit ;-)
>>
>>> On 2/22/2012 11:59 AM, Nicolas Ferre wrote:
>>>> On 01/27/2012 06:29 PM, Cousson, Benoit :
>>>>> Add some basic helpers to retrieve a DMA controller device_node
>>>>> and the DMA request line number.
>>>>>
>>>>> For legacy reason another API will export the DMA request number
>>>>> into a Linux resource of type IORESOURCE_DMA.
>>>>> This API is usable only on system with an unique DMA controller.
>>>>
>>>> Hi,
>>>>
>>>> I followed that discussion and I like very much the biding that Benoit
>>>> is proposing. It will help me a lot with my current work on Atmel DMA
>>>> controller.
>>>>
>>>> If I understand correctly, some rework is needed before it can be
>>>> integrated in a stable git tree (I mean before we can base our work on
>>>> top of it). So, in the meantime, what should I do to help and make
>>>> things go forward? to be quite frank, I would be interested to have a
>>>> working DMA enabled device soon ;-)
>>>
>>> Me too, but unfortunately, I was busy trying to add irq_domain and
>>> fixing issues with SPARSE_IRQ on OMAP :-(
>>
>> Been there, loved that ;-)
>>
>>>> Do you think that 3.4 is out of reach?
>>>
>>> Maybe not, from the comments, it looks like we should add a .xlate
>>> callback to allow any custom parsing of the DMA nodes attributes.
>>>
>>> I'll be more than happy, if you can finalize that patch :-)
>>
>> I will try to figure out what I can understand from the irq mechanism of
>> .xlate and try to see if I can implement it on top of your patch.
> 
> In fact that dma code is a big copy/paste of the of/gpio one and gpio
> was already managing .xlate function.
> I removed it because I thought it was useless for the DMA :-)
> 
> You might just have to copy the original code...

The thing is that with gpio, we can rely on the gpio_chip structure for
having a common storage location of such .xlate callbacks.
In our DMA case, I guess that we should not cling to dmaengine
infrastructure because not all of us are using it right now.

So, maybe we should provide some simple "xlate" helpers like the
irqdomain ones. But I fear that a "callback" directly called from the
of_get_dma_request() function is not possible (the gpio code model).

On the other hand, the "cookie" based infrastructure seems a little
overkill to me. It seems that, in this case, we must establish a
relation between the DMA controller code and the device tree DMA
helpers. Please correct me if I am wrong.

Best regards,
-- 
Nicolas Ferre
