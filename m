From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add am57xx-beagle-x15
Date: Thu, 6 Nov 2014 08:48:44 -0800
Message-ID: <20141106164843.GY31454@atomide.com>
References: <1415290702-11353-1-git-send-email-nm@ti.com>
 <20141106163207.GF16896@saruman>
 <545BA3E6.90105@ti.com>
 <545BA513.2090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <545BA513.2090907-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tom Rini <trini-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gerald-xujr6ya/RELK0SuXxyvBAPegYHeGw8Jk@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [141106 08:44]:
> On 11/06/2014 10:37 AM, Tom Rini wrote:
> 
> >>> device_type = "memory"; +		reg = <0x80000000 0x40000000>; /* 1GB
> >>> to start. Target 2GB */
> >>
> >> 1GiB ? Why would you put this here btw ? u-boot fills this one up.
> > 
> > Yes, it should either be the full and correct value or 0x0 (like a
> > number of PowerPC platforms do) so it's clear something else gives us
> > the right value here.
> 
> Honest mistake, my bad.. I thought I cleaned up the patch! Sigh!!! i
> will repost with proper 2GB. it is better that way in case being used
> with "other bootloaders" which are not exactly too good like u-boot.

Can you also describe why all the always-on regulators are needed?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
