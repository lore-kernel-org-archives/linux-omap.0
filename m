From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/4] ARM: dts: am437x-gp-evm: add HDMI support
Date: Fri, 13 Dec 2019 14:28:45 +0200
Message-ID: <20191213122845.GD4860@pendragon.ideasonboard.com>
References: <20191125131100.9839-1-tomi.valkeinen@ti.com>
 <20191212172104.GY35479@atomide.com>
 <20191212173110.GA35479@atomide.com>
 <d09526b2-8435-bef2-0489-0c3c8173d451@ti.com>
 <20191213104204.GB4860@pendragon.ideasonboard.com>
 <2f5cfca4-d36d-da2d-59ba-b76669daeded@ti.com>
 <20191213114207.GC4860@pendragon.ideasonboard.com>
 <36d8dde1-1a76-5a5f-2a41-8bc52dfcf2fa@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <36d8dde1-1a76-5a5f-2a41-8bc52dfcf2fa@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On Fri, Dec 13, 2019 at 02:04:30PM +0200, Tomi Valkeinen wrote:
> On 13/12/2019 13:42, Laurent Pinchart wrote:
> > On Fri, Dec 13, 2019 at 12:56:31PM +0200, Tomi Valkeinen wrote:
> >> On 13/12/2019 12:42, Laurent Pinchart wrote:
> >>
> >>>> I think the correct way would be to have DRM framework understand that we have two displays, which
> >>>> are mutually exclusive, and the display pipeline drivers would have the means to switch the gpio.
> >>>> And that the display setup could be communicated properly to the userspace, and the userspace would
> >>>> understand it. I don't think any of those exists.
> >>>
> >>> Isn't this what possible_clones in drm_encoder is for ? It notifies
> >>> userspace of mutual exclusions between encoders.
> >>
> >> Hmm, how would that work here? Isn't encoder cloning about having two encoders, which take the input
> >> from the same video source, and then outputting to two displays?
> > 
> > That's the idea. If you have one encoder for HDMI and one for the panel,
> > you can mark them as non-clonable, and then only one of the two can be
> > active at a time.
> 
> We have a single DPI output from the SoC. That goes to the panel, or to SiI9022 bridge, depending on 
> the GPIO switch.
> 
> So... In the DT file, we would have multiple endpoints in the same output port in DSS, one going to 
> the panel, one to the SiI9022? omapdrm could then create two encoders, one abstracting the DPI 
> output and the connection to the panel, one abstracting the DPI output and SiI9022?

That's the idea, yes.

> And then someone would need to handle the GPIO, and set it based on the output used. These kind of 
> gpios are always difficult, as they don't belong anywhere =).

https://lore.kernel.org/lkml/20191211061911.238393-5-hsinyi@chromium.org/

Still, the infrastructure in omapdrm would need quite a bit of work.
We're just about to get a helper layer for linear pipelines merged, and
we already need to go one step further :-)

-- 
Regards,

Laurent Pinchart
