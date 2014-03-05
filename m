From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] ARM: dts: OMAP3630+: Add ABB device nodes
Date: Wed, 5 Mar 2014 11:49:43 -0800
Message-ID: <20140305194943.GF7599@atomide.com>
References: <1391039177-25284-1-git-send-email-nm@ti.com>
 <20140305194745.GE7599@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140305194745.GE7599-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [140305 11:51]:
> * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140129 15:48]:
> > Now that clock nodes have been merged to master,
> > refresh of the series meant for all TI platforms using ABB.
> > Originally posted [1], I will restart with v1.
> 
> Thanks applying all except for the crossbar ones into
> omap-for-v3.15/dt.
> 
> Please resend the last three patches once the dependencies
> are merged to mainline kernel as otherwise the interrupt
> nubers are all wrong without the crossbar driver related
> code.

Oops, should have replied this to the pending patches
thread instead, please ignore.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
