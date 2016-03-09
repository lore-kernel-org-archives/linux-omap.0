From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 2/6] ASoC: hdmi-codec: Add hdmi-codec for external
 HDMI-encoders
Date: Wed, 09 Mar 2016 16:28:03 +0100
Message-ID: <1457537283.27489.0.camel@pengutronix.de>
References: <cover.1457465383.git.jsarha@ti.com>
	 <6269edecc567c7b1431b023bc812f0309db99273.1457465383.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6269edecc567c7b1431b023bc812f0309db99273.1457465383.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jyri,

Am Dienstag, den 08.03.2016, 22:14 +0200 schrieb Jyri Sarha:
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

Tested on mt8173,
Acked-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

regards
Philipp


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
