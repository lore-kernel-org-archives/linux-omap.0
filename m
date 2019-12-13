From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: am437x-gp-evm: add HDMI support
Date: Fri, 13 Dec 2019 11:24:02 +0200
Message-ID: <d09526b2-8435-bef2-0489-0c3c8173d451@ti.com>
References: <20191125131100.9839-1-tomi.valkeinen@ti.com>
 <20191212172104.GY35479@atomide.com> <20191212173110.GA35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191212173110.GA35479@atomide.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/12/2019 19:31, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [191212 17:21]:
>> Hi,
>>
>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [191125 05:11]:
>>> Add HDMI support for AM437x GP EVM. The HDMI uses SiI9022 HDMI encoder,
>>> and is mutually exclusive with the LCD. The choice between LCD and HDMI
>>> is made by booting either with am437x-gp-evm.dtb or
>>> am437x-gp-evm-hdmi.dtb.
>>
>> So Linux kernel needs a new board device tree file to toggle a GPIO line
>> to switch between LCD mode and HDMI?
>>
>> That does not sound very user friendly for something that's supposed
>> to be hot pluggabe :)

True. We've had this for a long time in the TI kernel. I don't know how to implement this better, 
except perhaps with DT overlays, but that's essentially the same method.

>>> +/* Override SelLCDorHDMI from am437x-gp-evm.dts to select HDMI */
>>> +&gpio5 {
>>> +	p8 {
>>> +		output-low;
>>> +	};
>>> +};
>>
>> How about just leave the gpio unconfigured and document that a userspace
>> tool or /sys/kernel/debug/gpio is needed to toggle between the modes?

That sounds much worse than two dts files. How does X or weston know about the gpio?

And the "external" gpio wouldn't work well with DRM. We need to add all the displays at probe time, 
so we'd have LCD and HDMI. The gpio makes one of those operable, but only the external parts. The 
display controller has just one output, and we'd have a conflict there too as both displays would be 
connected to that single output. And as the display controller driver doesn't know about the gpio, 
it would fail "randomly" for one of the displays if the other one is already enabled by the userspace.

I think the correct way would be to have DRM framework understand that we have two displays, which 
are mutually exclusive, and the display pipeline drivers would have the means to switch the gpio. 
And that the display setup could be communicated properly to the userspace, and the userspace would 
understand it. I don't think any of those exists.

So, the only good solution I have figured out is to just say that we have a single display at 
runtime, defined by the dt file.

On some boards (k2g-evm, if I recall right) we have similar HW setup, but with a physical switch. We 
use the same method there, with two dts files. Again, if I recall right, the switch setting can be 
seen by the SW, so if there's a better solution to the AM4 case, probably similar could be used with 
k2g-evm, where the drivers would react to the user changing the switch.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
