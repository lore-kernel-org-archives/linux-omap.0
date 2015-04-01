From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v4 3/7] drm/tilcdc: Add support for external tda998x
 encoder
Date: Wed, 1 Apr 2015 23:20:31 +0100
Message-ID: <20150401222030.GD4027@n2100.arm.linux.org.uk>
References: <cover.1427877412.git.jsarha@ti.com>
 <e22d703d6ee5fe02e8c34b78a63f98a4b2ea1f22.1427877412.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e22d703d6ee5fe02e8c34b78a63f98a4b2ea1f22.1427877412.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 01, 2015 at 11:49:27AM +0300, Jyri Sarha wrote:
> Add support for an external compontised DRM encoder. The external
> encoder can be connected to tilcdc trough device tree graph binding.
> The binding document for tilcdc has been updated. The current
> implementation supports only tda998x encoder.
> 
> To be able to filter out the unsupported video modes the tilcdc driver
> needs to hijack the external connectors helper functions. The tilcdc
> installes new helper functions that are otherwise identical to
> orignals, but the mode_valid() call-back check the mode first localy,
> before calling the original call-back. The tilcdc dirver restores the
> original helper functions before it is unbound from the external
> device.

This is where the DRM model is weak - we don't really have a way to
say "this is the set of CRTCs which /can/ be associated with this
connector, can any of the CRTCs accept this mode?" and eliminate
modes which fail that check.

This problem seems to be one which recurrs, so I wonder if it's
something which ought to be solved properly.

It's made slightly more difficult because we don't really know which
connectors could be associated with which CRTCs - that information is
stored at the encoder level (with the encoders possible_crtcs), and
I'm not sure we have a way for generic DRM code to know which encoders
could be associated with which connectors.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
