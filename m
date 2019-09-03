From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved
 channel ranges
Date: Tue, 3 Sep 2019 13:19:45 +0300
Message-ID: <15d5dc03-d6ca-f438-f37a-e71298abda95@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
 <20190823125618.8133-5-peter.ujfalusi@ti.com> <20190829224728.GA1198@bogus>
 <a4c5688b-cbeb-5059-5351-11d9ae1b25d5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4c5688b-cbeb-5059-5351-11d9ae1b25d5@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 30/08/2019 8.37, Peter Ujfalusi wrote:
> Rob,
> 
> On 30/08/2019 1.47, Rob Herring wrote:
>> On Fri, Aug 23, 2019 at 03:56:17PM +0300, Peter Ujfalusi wrote:
>>> Similarly to paRAM slots, channels can be used by other cores.
>>>
>>> Add optional property to configure the reserved channel ranges.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> index 4bbc94d829c8..1198682ada99 100644
>>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>>> @@ -42,6 +42,9 @@ Optional properties:
>>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>>>  		the driver, they are allocated to be used by for example the
>>>  		DSP. See example.
>>> +- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
>>> +		the driver, they are allocated to be used by for example the
>>> +		DSP. See example.
>>
>> Based on the other thread, I think extending dma-channel-mask to a 
>> uint32-array makes sense here.
> 
> Yes, that is the reason I have asked on that and I'm in progress of
> converting the edma driver to use the dma-channel-mask.
> Just need to do some shuffling in the driver to get the mask in a form
> usable by the driver.
> 
> I'll send an updated series early next week.

How should the dma-channel-mask uint31-array should be documented and used?

Basically some EDMA have 32, some 64 channels. This is fine.
Let's say I want to mask out channel 0-4 and 24-27

This would look like in case of EDMA with 32 channels:
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xf0fffff0>;
};

How this should look like in case when I have 64 channels?
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xf0fffff0>, <0xffffffff>;
};

When I read the u32s then
chan_mask[0] is for channel 0-31 (LSB is channel 0)
chan_maks[1] is for channel 32-63 (LSB is channel 32)

Or:
&edma {
	/* channel 0-4 and 24-27 is not to be used */
	dma-channel-mask = <0xffffffff>, <0xf0fffff0>;
};

chan_maks[0] is for channel 32-63 (LSB is channel 32)
chan_mask[1] is for channel 0-31 (LSB is channel 0)

Do you have pointer on already established notion on how to document and
handle this?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
