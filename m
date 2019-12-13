From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] ARM: dts: am437x-gp-evm: add HDMI support
Date: Fri, 13 Dec 2019 14:33:20 +0200
Message-ID: <3900f4b3-4604-cb64-ebdd-ae168ef1d2fb@ti.com>
References: <20191125131100.9839-1-tomi.valkeinen@ti.com>
 <20191212172104.GY35479@atomide.com> <20191212173110.GA35479@atomide.com>
 <d09526b2-8435-bef2-0489-0c3c8173d451@ti.com>
 <20191213104204.GB4860@pendragon.ideasonboard.com>
 <2f5cfca4-d36d-da2d-59ba-b76669daeded@ti.com>
 <20191213114207.GC4860@pendragon.ideasonboard.com>
 <36d8dde1-1a76-5a5f-2a41-8bc52dfcf2fa@ti.com>
 <20191213122845.GD4860@pendragon.ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191213122845.GD4860@pendragon.ideasonboard.com>
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
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/12/2019 14:28, Laurent Pinchart wrote:

>> So... In the DT file, we would have multiple endpoints in the same output port in DSS, one going to
>> the panel, one to the SiI9022? omapdrm could then create two encoders, one abstracting the DPI
>> output and the connection to the panel, one abstracting the DPI output and SiI9022?
> 
> That's the idea, yes.
> 
>> And then someone would need to handle the GPIO, and set it based on the output used. These kind of
>> gpios are always difficult, as they don't belong anywhere =).
> 
> https://lore.kernel.org/lkml/20191211061911.238393-5-hsinyi@chromium.org/
> 
> Still, the infrastructure in omapdrm would need quite a bit of work.
> We're just about to get a helper layer for linear pipelines merged, and
> we already need to go one step further :-)

Alright, sounds like this will be doable in the future. So let's drop this and the epos HDMI patches 
for now.

This does sound like quite a bit of work, as you say, so I have no idea when we can get there (on 
the omapdrm side). In the minimum we should first get the big omapdrm rework done, in order to avoid 
nasty conflicts.

Thanks for educating me =).

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
