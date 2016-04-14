From: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v9 3/7] ASoC: hdmi-codec: Add hdmi-codec
 for external HDMI-encoders
Date: Thu, 14 Apr 2016 13:31:21 +0800
Message-ID: <1460611881.22320.6.camel@mtksdaap41>
References: <cover.1459431292.git.jsarha@ti.com>
	 <636486b25db48fa13ae640516cdebe7bcfea0d23.1459431292.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <636486b25db48fa13ae640516cdebe7bcfea0d23.1459431292.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jyri,

On Thu, 2016-03-31 at 16:36 +0300, Jyri Sarha wrote:
> The hdmi-codec is a platform device driver to be registered from
> drivers of external HDMI encoders with I2S and/or spdif interface. The
> driver in turn registers an ASoC codec for the HDMI encoder's audio
> functionality.
> 
> The structures and definitions in the API header are mostly redundant
> copies of similar structures in ASoC headers. This is on purpose to
> avoid direct dependencies to ASoC structures in video side driver.
> 
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

I successfully tested new version on mt8173. 
Acked-by: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
