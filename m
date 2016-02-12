From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Fri, 12 Feb 2016 14:21:45 -0800
Message-ID: <20160212222144.GN19432@atomide.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160209215210.GB27284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160209215210.GB27284-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160209 13:53]:
> On Mon, Feb 08, 2016 at 02:46:27PM +0530, Keerthy wrote:
> > OMAP5 has 3 thermal zones cpu, core and multimedia.
> > On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> > and iva. Currently cpu, core and multimedia are being added via dt
> > and the other 2 are getting added via kernel. Add the missing thermal
> > domains in dt so as give the correct trip numbers, type and temperatures.
> > 
> > Tested on DRA7-EVM.
> 
> For the series:
> 
> Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applying all into omap-for-v4.6/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
