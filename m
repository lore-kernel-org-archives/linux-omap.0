From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: configure regulators for Gumstix Pepper
Date: Sun, 28 Jun 2015 23:47:17 -0700
Message-ID: <20150629064717.GR4156@atomide.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-3-git-send-email-arun@gumstix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433441299-18887-3-git-send-email-arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org> [150604 11:10]:
> From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Boot process is halting in midway because some of the necessary voltage
> regulators are deemed unused and subsequently powered off, leading to
> a completely unresponsive system.

OK that needs to be fixed for v4.2-rc series.
 
> Most of the device nodes had correct voltage regulator attachments.
> Yet these nodes had to set stricter enforcement on them through
> 'regulator-boot-on' and 'regulator-always-on' to function correctly.

That's a lot of regulators marked as regulator-always-on. Could
you please update the description what consumers are using them
so we know why they are all needed always-on?
 
> Signed-off-by: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>From Adam, sent by Arun, signed by Ash? Can you please check
that too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
