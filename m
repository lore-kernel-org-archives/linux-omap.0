From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Mon, 2 Nov 2015 15:34:05 +0530
Message-ID: <20151102100405.GJ21326@localhost>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
 <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMg0KsHnbF8hEYPZ8bY8wz9fC0_m7-KS4A6kB__nUi9kAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 02, 2015 at 01:21:19AM -0800, Olof Johansson wrote:
> Hi,
> 
> 1) This seems to have broken BBB in -next for me, bisected down to this patch.
> 
> For bootlog:
> http://arm-soc.lixom.net/bootlogs/next/next-20151102/bbb-arm-omap2plus_defconfig.html
> 
> 2) Please avoid merging DT/platform code in your driver tree, Vinod,
> at least without an ack from the platform maintainer. It can be a a
> huge mess if they end up causing conflicts, so we always ask to merge
> the DT changes through the platform maintainer (Tony in this case) by
> default.

I did warn when applying that I am doing so without ACK on ARM code, noone
said a thing!

I knew Tony was following the work by Peter so assumed he must have been okay
with it otherwise would have spoken for ~couple of weeks these were in
review

Anyway now that we have a regression, I can revert this patch if that fixes,
please confirm, but might break edma... peter?

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
