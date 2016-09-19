From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: dts: am335x-* Add blue-and-red-wiring propery
 to lcdc nodes
Date: Mon, 19 Sep 2016 16:14:58 -0700
Message-ID: <20160919231458.5t5a547kynqcooch@atomide.com>
References: <cover.1474025756.git.jsarha@ti.com>
 <20160916150242.vbvpuokftychkdfz@atomide.com>
 <f8124caf-9752-c970-fd41-404ea4d983a9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f8124caf-9752-c970-fd41-404ea4d983a9-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [160919 00:31]:
> On 09/16/16 18:02, Tony Lindgren wrote:
> > * Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> [160916 04:50]:
> >> > These patches complete the am335x LCDC color errata fix[1]. The
> >> > functional patches are now queued for v4.9.
> >> > 
> >> > The patch for am335x-boneblack.dts is delayed until v4.10 or v4.9-rc
> >> > phase to avoid conflickt with BBB HDMI audio DTS patch that slipped
> >> > into tda998x pull request.
> >> > 
> >> > [1] http://www.spinics.net/lists/devicetree/msg141246.html
> > OK. Are these safe to merge even if the dts changes get merged before
> > the driver changes? Or does it break something if merged out of order?
> 
> Yes, they are safe. The new property just simply is not interpreted and
> everything works as before.

OK applying into omap-for-v4.9/dt-v2 thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
