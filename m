From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/2] arm: dts: add support for am437x sk
Date: Tue, 1 Jul 2014 05:50:42 -0700
Message-ID: <20140701125041.GP28884@atomide.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <20140630164543.GA31442@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140630164543.GA31442-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, r.sricharan-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140630 09:47]:
> Hi,
> 
> On Mon, Jun 23, 2014 at 01:20:57PM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > here's v3 of am437x sk support. Patches tested on top of next-20140617.
> > 
> > Note that this series was tested with the following extra patches:
> > 
> > http://marc.info/?l=linux-omap&m=140299431732700&w=2
> > http://marc.info/?l=linux-omap&m=140300146503126&w=2
> > http://marc.info/?l=linux-omap&m=140299231232123
> > http://marc.info/?l=linux-omap&m=140310472709968&w=2
> > http://marc.info/?l=linux-omap&m=140310471409959&w=2
> > 
> > A branch is also available with all these patches at [1].
> > 
> > [1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=am437x-starterkit
> > 
> > Felipe Balbi (2):
> >   arm: dts: am4372: let boards access all nodes through phandles
> >   arm: dts: add support for AM437x StarterKit
> 
> ping on this series, it has been tested by several folks and still no
> updates from anybody in the DT land.

Thanks applying both into omap-for-v3.17/dt branch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
