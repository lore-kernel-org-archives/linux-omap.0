From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Help needed with remaining plat headers
Date: Fri, 21 Sep 2012 12:06:42 +0300
Message-ID: <505C2E22.9020001@compulab.co.il>
References: <20120920232907.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:60790 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2IUJGy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 05:06:54 -0400
In-Reply-To: <20120920232907.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 09/21/12 02:29, Tony Lindgren wrote:
> Hi all,
> 
> With the recent pull request I sent for v3.7, we now have pretty
> much all the mach includes fixed up for omap2+ for single zImage
> support.
> 
> We still have quite a few plat headers that we need to sort
> out manually.
> 
> Please take a look at the following list, and reply to this
> thread if you are working on patches moving one of the headers
> in the list so we can coordinate things. The rules are simple
> for most of them:
> 
> 1. For driver related data, the header should now be in
>    include/linux/platform_data/*.h
> 
> 2. For mach-omap2 specific things, the headers should be
>    in arch/arm/mach-omap2.
> 
> 3. Drivers should not include anything from plat or mach.
> 
> I'll be looking into getting rid of cpu.h etc for v3.8 merge
> window, but won't be looking much at the driver related
> headers. So some help would be appreciated here :)
> 
> Regards,
> 
> Tony
> 
> 
> $ ls arch/arm/plat-omap/include/plat/

[...]

> timex.h

I'll try to deal with this one,
as it is related to the work I currently do for CONFIG_OMAP_32K_TIMER removal.
Probably for v3.8 merge window.

-- 
Regards,
Igor.
