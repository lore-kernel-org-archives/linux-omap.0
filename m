From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Tue, 22 Mar 2016 12:29:52 -0700
Message-ID: <20160322192951.GP9329@atomide.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
 <56EFB31C.9090103@ti.com>
 <20160321202107.GO9329@atomide.com>
 <56F107FF.8080006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F107FF.8080006-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160322 01:54]:
> Tony,
> 
> On 03/21/16 22:21, Tony Lindgren wrote:
> > Hi,
> > 
> > * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160321 01:39]:
> >>
> >> This is also interesting:
> >> McBSP2 sidetone is in region 39 and 40 (module and L4 interconnect) which is
> >> unique in case of OMAP34xx and OMAP35xx, but it is overlapping with GPIO6 on
> >> OMAP36xx. Not sure what are the implications.
> > 
> > Hmm GPIO6 is in a different L4 segment though? Maybe
> > you did not account for the segments?
> > 
> > 0x49000000 + 0x20000 + 0x2000/0x4000/0x6000 for McBSP
> > 0x49000000 + 0x50000 + 0x8000 for GPIO6
> > 
> > Or maybe I don't understand at which physical address the
> > overlap is? :)
> 
> The addresses are not overlapping, but the Region Numbers for GPIO6 and McBSP2
> sidetone in Table 9-114 "Region Allocation for
> L4-Per Interconnect". But only in case of OMAP36xx

Oh OK, yeah the TRM region numbers are wrong, they skip unused
entries compared to the hardware AP table :) Basically the
TRM AP region numbering is useless and wrong.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
