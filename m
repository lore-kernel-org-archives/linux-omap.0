From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
Date: Fri, 13 Nov 2015 06:54:53 -0800
Message-ID: <20151113145452.GD2517@atomide.com>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
 <87egg54td4.fsf@saruman.tx.rr.com>
 <20151104164120.GO12910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151104164120.GO12910@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [151104 08:38]:
> On Wed, Nov 04, 2015 at 10:33:27AM -0600, Felipe Balbi wrote:
> > Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> writes:
> > 
> > > The eDMA3 TPTC does not need any software configuration, but it is a
> > > separate IP block in the SoC. In order the omap hwmod core to be able to
> > > handle the TPTC resources correctly in regards of PM we need to have a
> > > driver loaded for it.
> > > This patch will add a dummy driver skeleton without probe or remove
> > > callbacks provided.
> > >
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> > > Reported-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > 
> > This fixes the problem I also reported on linux-omap [1]
> > 
> > Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > 
> > [1] http://marc.info/?l=linux-omap&m=144665429032014&w=2
> 
> Great, I was about to point you to this series, I will push this in -next
> now

Soungd good to me, thanks for fixing it up Peter.

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
