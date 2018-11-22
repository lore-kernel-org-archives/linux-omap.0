From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Thu, 22 Nov 2018 10:31:31 +0200
Message-ID: <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, rmk+kernel@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On 20/11/2018 23.04, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Nov 20, 2018 at 09:28:37AM +0200, Peter Ujfalusi wrote:
>> On 19/11/2018 20.46, Aaro Koskinen wrote:
>>> On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
>>>> When the channel is configured for slave operation the LCH_TYPE needs to be
>>>> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>
>>> I don't have the documentation, but based on what omap_udc driver (still
>>> using the legacy OMAP DMA API) does this seems to be correct.
>>
>> They are hard to fine, true. From the omap1710 TRM:
>>
>> Logical channel types (LCh types) supported are:
>> - LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
>> - LCh-P for synchronized transfers (mostly peripheral transfers)
>> - LCh-PD similar to LCh-P but runs on a dedicated physical channel
>> - LCh-G for graphical transfers/operations
>> - LCh-D for display transfers
> 
> (I found a public document "OMAP5912 Multimedia Processor Direct
> Memory Access (DMA) Support Reference Guide", documenting these; easy
> to confuse with "OMAP5910 Dual-Core Processor System DMA Controller
> Reference Guide".)
> 
>> Looking at other part it looks like hat LCH-2D channel mode can happily
>> service a peripheral. LCH-P supports the same features as LCH-2D, but it
>> lacks support for Single/Double-indexed addressing mode on the
>> peripheral port side.
>>
>> So, this patch might not be needed at all. Can you test the omap_udc
>> with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D
>>
>> If USB works, then we can just drop this patch.
> 
> Unfortunately omap_udc does not seem to work at all anymore with DMA on
> my 770 setup. :-(
> 
> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> API were too annoying and flooding the console. And now that I tried
> using DMA again with g_ether, it doesn't work anymore. The device get's
> recognized on host side, but no traffic goes through. Switching back to
> PIO makes it to work again.

After some tinkering I got omap_udc working with DMA (not DMAengine,
yet) on 770 - using nfsroot. Configuring the channels to OMAP_DMA_LCH_2D
works as expected.

This patch can be dropped.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
