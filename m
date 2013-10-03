From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] hwspinlock/omap: add support for dt nodes
Date: Thu, 3 Oct 2013 11:19:09 -0700
Message-ID: <20131003181909.GT8949@atomide.com>
References: <1378230767-54931-1-git-send-email-s-anna@ti.com>
 <20131003180546.GP8949@atomide.com>
 <524DB48B.7020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524DB48B.7020906-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [131003 11:25]:
> Tony,
> 
> On 10/03/2013 01:05 PM, Tony Lindgren wrote:
> > * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [130903 11:00]:
> >> HwSpinlock IP is present only on OMAP4 and other newer SoCs,
> >> which are all device-tree boot only. This patch adds the
> >> base support for parsing the DT nodes, and removes the code
> >> dealing with the traditional platform device instantiation.
> > 
> > Great, this should be safe for Ohad to queue:
> > 
> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > 
> 
> There is a v2 of this series [1] that adds additional SoC support as
> well. It currently has some comments [2] & [3] from Mark Rutland on the
> DT bindings. I am looking into that at the moment and it may change this
> patch as well (the DT parse portion of it in
> drivers/hwspinlock/omap_hwspinlock).

OK, yeah I noticed there's some pending comments. Feel free to keep my
ack for the arch/arm/mach-omap2 removal parts, those won't likely
change.

Regards,

Tony
 
> [1] http://marc.info/?l=linux-omap&m=137944644112727&w=2
> [2] http://marc.info/?t=137944636400005&r=1&w=2
> [3] http://marc.info/?t=137944636400004&r=1&w=2
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
