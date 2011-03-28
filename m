From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: twl4030_wdt: Watchdog device registration
	issue fix
Date: Mon, 28 Mar 2011 23:07:26 +0200
Message-ID: <20110328210726.GE3974@infomag.iguana.be>
References: <1299012474-4993-1-git-send-email-j-keerthy@ti.com> <AANLkTinVtNtoAh_AnLxC3z2EHzLXdndj27SjR3LD5Z8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:23320 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752543Ab1C1VH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 17:07:28 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinVtNtoAh_AnLxC3z2EHzLXdndj27SjR3LD5Z8d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org

Hi All,

> Hello All,
> 
> Any comments on this patch?
> 
> Regards,
> Keerthy
> 
> On Wed, Mar 2, 2011 at 2:17 AM, Keerthy <j-keerthy@ti.com> wrote:
> > twl4030_wdt driver and omap_wdt driver are registering as misc_device name as
> > "watchdog" and the same minor number WATCHDOG_MINOR( value = 130).
> > There is a conflict since the name and minor were the same for
> > both the misc_device registered by omap_wdt.c as well as twl4030_wdt.c
> >
> > The omap_wdt.c probe is getting called first. Hence it succeeds.
> > twl4030_wdt.c always failed on the minor number comparison check.
> > Now requesting for MISC_DYNAMIC_MINOR as the minor
> > number for twl4030_watchdog and renamed the device name as
> > "twl4030_watchdog".
> >
> > Tested for basic boot up on OMAP4 Blaze and OMAP3630 SDP. OMAP3630 SDP
> > twl4030_wdt registration succeeds.2430SDP boot tested, watchdog registration
> > without errors.
> >
> > Signed-off-by: Keerthy <j-keerthy@ti.com>

NAK. Reason: a watchdog daemon will only be using /dev/watchdog.
The plan is to get the generic watchdog framework in, convert most of the drivers, extend teh generic watchdog framework with a sysfs interface so that we can support multiple watchdogs.

Kind regards,
Wim.

