From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2 2/2] ARM: dts: am57xx-beagle-x15: Add thermal map to
 include fan and tmp102
Date: Thu, 26 Mar 2015 12:03:12 -0700
Message-ID: <20150326190311.GE10805@atomide.com>
References: <1427139579-4215-1-git-send-email-nm@ti.com>
 <1427139579-4215-3-git-send-email-nm@ti.com>
 <20150324151736.GE29155@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150324151736.GE29155-ld4jwAGwUXQP5tpWdHSM3tPlBySK3R6THiGdP5j34PU@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150324 08:17]:
> On Mon, Mar 23, 2015 at 02:39:39PM -0500, Nishanth Menon wrote:
> > BeagleBoard-X15 has capability for a fan and has an onboard TMP102
> > temperature sensor as well. This allows us to create a new thermal
> > zone (called, un-imaginatively "board"), and allows us to use some
> > active cooling as temperatures start edge upward in the system by
> > creating a new alert temperature (emperically 50C) for cpu.
> > 
> > NOTE: Fan is NOT mounted by default on the platform, in such a case,
> > all we end up doing is switch on a regulator and leak very minimal
> > current.
> > 
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applying both of these into omap-for-v4.1/fixes-not-urgent thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
