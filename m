From: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch v3 0/3] ARM: dts: am43x-vpfe/ov2659.patch
Date: Mon, 13 Jan 2020 10:54:14 -0600
Message-ID: <20200113165413.i6nbi2i7xyue4fti@ti.com>
References: <20191211140720.10539-1-bparrot@ti.com>
 <20191212174123.GF35479@atomide.com>
 <c4ae58dc-3c81-f493-a665-6926baa0f04c@ti.com>
 <20191213152938.GK35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191213152938.GK35479-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote on Fri [2019-Dec-13 07:29:38 -0800]:
> * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [191213 07:43]:
> > On 12/12/2019 19:41, Tony Lindgren wrote:
> > > * Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [191211 06:04]:
> > > > This patch series adds the missing camera endpoint (ov2659) as well as
> > > > the required source clocks nodes for the sensor.
> > > > 
> > > > On the am437x-sk-evm the camera sensor is sourced from clkout1 but that
> > > > clock nodes/tree was removed as it was unsed at the time, we are
> > > > re-adding the needed clock nodes here.
> > > 
> > > Tero, it seems I can already pick this series?
> > 
> > I believe it is ready if you approve the clkout1 clock patch.
> 
> OK yeah looks fine.
> 
> > > Or ou want to queue the changes to am43xx-clocks.dtsi along with all
> > > your other clock patches?
> > 
> > Well, I have actually never queued any omap2+ dts patches myself, and I
> > don't think there would be too many of those coming for next merge either.
> 
> OK will queue this series then. For the other ones from Benoit
> looks like we need an immutable clock branch before I can apply
> anything.

Tony, Tero,

Are these merged anyware now?
I still don't see any of these on linux-next?

And by "these" I mean this one and both
 ARM: dts: dra7: add vpe nodes
 ARM: dts: dra7: add cal nodes

Regards,
Benoit

> 
> Regards,
> 
> Tony
