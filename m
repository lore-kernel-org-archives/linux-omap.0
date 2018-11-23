From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Fri, 23 Nov 2018 13:54:12 +0200
Message-ID: <cca7279a-2f93-ee43-0f1a-8f04d2e7b694@ti.com>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
 <20181123002549.GO6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123002549.GO6920@n2100.armlinux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 23/11/2018 2.25, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 12:24:26AM +0200, Aaro Koskinen wrote:
>> Hi,
>>
>> On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
>>> On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
>>>> On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
>>>>> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
>>>>> API were too annoying and flooding the console. And now that I tried
>>>>> using DMA again with g_ether, it doesn't work anymore. The device get's
>>>>> recognized on host side, but no traffic goes through. Switching back to
>>>>> PIO makes it to work again.
>>>>
>>>> A solution to that would be to do what the warning message says, and
>>>> update the driver to the DMAengine API.
>>
>> Fully agreed, but I was busy debugging other more serious issues, and
>> just wanted to get a reliable ssh or USB serial access to the device
>> without any extra noise, so switching to PIO using a module parameter
>> is probably what most users do in such situations.
>>
>>> Here's a partial conversion (not even build tested) - it only supports
>>> OUT transfers with dmaengine at the moment.
>>
>> Thanks, I'll take a closer look and try to do some testing hopefully
>> during the weekend.
> 
> The patch was more for Peter to take a peek at - there's definitely
> some bits missing in the dmaengine driver (like the write to the
> LCH_CTRL register) that would need to be fixed somehow.
> 
> However, it's worth noting that there is exactly one user of
> omap_set_dma_channel_mode(), which is omap-udc, which means any DMA
> channel made use of by omap-udc will have the LCH_CTRL register
> modified to LCH_P, and it will remain that way even if someone else
> subsequently makes use of the same channel.  That's rather suspicious
> to me... maybe we can just initialise all LCH_CTRL registers to LCH_P
> in the dmaengine driver in that case!  If not, then there's a bug
> right there.

Hrm, right. memcpy will break if we take a channel which was used by
omap_udc at some point as LCH_P is not capable of dealing with it.

With this patch it should be fine as we configure the LCH_CTRL to P or
2D depending on the transfer type (slave vs non-slave).
But, we might just set the lch to 2D regardless as it works for slave
and memcpy channels fine.

> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
