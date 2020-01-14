From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Configure omap5 AESS
Date: Tue, 14 Jan 2020 13:00:39 -0800
Message-ID: <20200114210039.GT5885@atomide.com>
References: <20200114150937.18304-1-tony@atomide.com>
 <52905C15-A2D1-4372-9781-D602D0B274B6@goldelico.com>
 <20200114164613.GR5885@atomide.com>
 <D51230C4-2642-4388-959F-313A3382AB99@goldelico.com>
 <20200114171634.GS5885@atomide.com>
 <632E66D6-47EF-44CF-BF02-B0F5A215D904@goldelico.com>
 <ACB71118-B121-4CF7-934D-A88654366E8F@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ACB71118-B121-4CF7-934D-A88654366E8F-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [200114 18:40]:
> I have checked our tree and it is already built into a separate module with
> 
> sound/soc/ti/aess/omap-aess-core.c:	{ .compatible = "ti,omap4-aess", },
> 
> So
> 
> > target-module@f1000 {			/* 0x401f1000, ap 32 20.0 */
> > 	...
> > 	aess: aess {
> > 		compatible = "ti,omap4-aess";
> > 		status = "disabled";
> > 	};
> > };
> 
> would be what we will need.

OK good to hear.

Regards,

Tony
