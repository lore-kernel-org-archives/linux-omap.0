From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Enable/disable sidetone block auto
 clock gating for omap3
Date: Sat, 19 Mar 2016 19:37:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603191932240.6629@utopia.booyaka.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com> <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458296929-718-4-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 18 Mar 2016, Peter Ujfalusi wrote:

> OMAP3's McBSP2 and McBSP3 module have integrated sidetone block with
> dedicated SYSCONFIG register. The sidetone is operating from the maain
> McBSP module's ICLK. For normal operation the sidetone clock auto idle
> support needs to be disabled when it is activated.
> Note: This is not enough to avoid choppy sidetone because this AUTOIDLE
> bit is controlling only the clock auto idle from the McBSP to the sidetone
> block. If the McBSP_ICLK is idling, the sidetone clock is going to do the
> same.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Mark, please drop this patch for the time being, until the SoC integration 
issues can be sorted out first.  It's best to wait a little while before 
applying patches like these so folks have a chance to comment on their 
correctness first.

We used to handle this problem in the OMAP hwmod SoC integration layer 
with a flag that forced the interface clock to stay active as long as the 
underlying IP blocks were active.  However I can't find that flag right 
now in the current data, so maybe it got accidentally or inadvertently 
removed at some point in time in the past.  The right way to fix this 
would be to add that flag back in, rather than messing with the SoC 
integration registers from the McBSP drivers.


thanks


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
