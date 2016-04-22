From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 22 Apr 2016 15:24:15 -0700
Message-ID: <20160422222415.GN5995@atomide.com>
References: <20160413152829.GQ5995@atomide.com>
 <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com>
 <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com>
 <5710C10A.6040908@ti.com>
 <20160415151651.GP5995@atomide.com>
 <571145F6.2040508@ti.com>
 <20160418235152.GZ5995@atomide.com>
 <571A2357.3060006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571A2357.3060006-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160422 06:15]:
> 
> From the documents it is also clear that McBSPLP.sidetone is using the
> McBSPLP's ICLK, but what is not explained in the TRM is that there are
> internal clocks going from McBSP to sidetone for the data bus between them.
> The iclk is needed so the core can kind of run independently from the clocks
> coming from McBSPLP (for data exchange between the two modules).
> If McBSP is not configured these clocks are not running which renders the
> sidetone non operational.

THe McBSP ick is not coming from McBSP, it's coming from the L4
interconnect. Both McBSP are just consumers for that same clock.
AFAIK there is no clock line going from McBSP to the sidetone.

> I can send a cut down series to fix the current sidetone hwmod (main_clk and
> prevent it to look at the PRCM bit) plus reworking the pdata callback so we
> can support both legacy and DT boot.

OK sounds good to me :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
