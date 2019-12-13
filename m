From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/4] ARM: dts: am437x-gp-evm: add HDMI support
Date: Fri, 13 Dec 2019 13:42:07 +0200
Message-ID: <20191213114207.GC4860@pendragon.ideasonboard.com>
References: <20191125131100.9839-1-tomi.valkeinen@ti.com>
 <20191212172104.GY35479@atomide.com>
 <20191212173110.GA35479@atomide.com>
 <d09526b2-8435-bef2-0489-0c3c8173d451@ti.com>
 <20191213104204.GB4860@pendragon.ideasonboard.com>
 <2f5cfca4-d36d-da2d-59ba-b76669daeded@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <2f5cfca4-d36d-da2d-59ba-b76669daeded@ti.com>
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

On Fri, Dec 13, 2019 at 12:56:31PM +0200, Tomi Valkeinen wrote:
> On 13/12/2019 12:42, Laurent Pinchart wrote:
> 
> >> I think the correct way would be to have DRM framework understand that we have two displays, which
> >> are mutually exclusive, and the display pipeline drivers would have the means to switch the gpio.
> >> And that the display setup could be communicated properly to the userspace, and the userspace would
> >> understand it. I don't think any of those exists.
> > 
> > Isn't this what possible_clones in drm_encoder is for ? It notifies
> > userspace of mutual exclusions between encoders.
> 
> Hmm, how would that work here? Isn't encoder cloning about having two encoders, which take the input 
> from the same video source, and then outputting to two displays?

That's the idea. If you have one encoder for HDMI and one for the panel,
you can mark them as non-clonable, and then only one of the two can be
active at a time.

-- 
Regards,

Laurent Pinchart
