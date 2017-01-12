From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: cppi41: Fix list not empty warning on
 runtime suspend
Date: Thu, 12 Jan 2017 09:47:56 -0800
Message-ID: <20170112174756.GI2630@atomide.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-2-abailon@baylibre.com>
 <20170109183416.GJ2630@atomide.com>
 <20170112170900.GG2630@atomide.com>
 <ac236cf1-d1e1-8f1f-fb62-b63cabf746d6@ti.com>
 <e17b04c8-037c-fc6d-84b8-60f968de3b4f@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e17b04c8-037c-fc6d-84b8-60f968de3b4f-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170112 09:42]:
> This solves the issue but I still have a bad playback quality.
> I don't remember if I have spoken about it so I will describe it.
> When I play audio (with your patch or mine), the music cut a lot.
> The issue go away when the MUSB driver is built in PIO mode only.
> Some experimentation I made today let me think it is related to
> PM runtime.
> I guess I should probably start another thread about that.

OK interesting. We may be able to fix that just by requesting
PM QoS for the audio device. See a fix for similar issue in thread
"[PATCH v6] ASoC: omap-mcbsp: Add PM QoS support for McBSP to
prevent glitches".

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
