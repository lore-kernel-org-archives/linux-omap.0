From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 08:57:38 -0700
Message-ID: <20170829155738.GB6008@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
 <201708291135.v7TBZCHH020827@dflxv15.itg.ti.com>
 <20170829121041.dweciryplio5i4jr@earth>
 <e0c6447f-5a0f-b43a-7087-5ee37af2a1c1@ti.com>
 <20170829143453.GV6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170829143453.GV6008-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170829 07:35]:
> * Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [170829 05:25]:
> > Maybe. At the moment we have this in TI's tree for DRA7:
> > 
> > gpu: gpu@56000000 {
> > 	compatible = "ti,dra7-sgx544", "img,sgx544";

I'll leave out "img,sgx544" as that's the generic component
that's really a child of this interconnect target module.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
