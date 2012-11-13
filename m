From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 8/8] ARM: OMAP: Move plat/dmtimer.h to plat-omap/dmtimer.h
Date: Tue, 13 Nov 2012 16:54:20 -0600
Message-ID: <50A2CF9C.1040902@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com> <1352830403-1706-9-git-send-email-jon-hunter@ti.com> <20121113222613.GM6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291Ab2KMWye (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 17:54:34 -0500
In-Reply-To: <20121113222613.GM6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/13/2012 04:26 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121113 10:15]:
>> Move plat/dmtimer.h to plat-omap/dmtimer.h in order to support a single
>> zImage for ARM devices.
> 
> Let's skip this one for now as it turns out this solution won't
> work either for multiplatform without adding nasty hacks to
> arch/arm/Makefile to include arch/arm/plat-omap.
> 
> Sorry I don't have any real solution in mind other than making
> the remaining dmtimer.h users to use Linux generic timer functions,
> or pass the dmtimer functions in platform_data for now.

Ok, no problem. Are you happy with the others?

One thing that we could do, is not include the dmtimer driver in the
multi-platform build for now. I believe that only the dsp/iva/gfx is
using this driver currently.

I believe that there are some issues with building the kernel without
the dmtimer and so I can look into fixing that.

Is there a way to not include dmtimer with multi-platform but still
enable in omap2plus_defconfig? Or are we planning to kill
omap2plus_defconfig too?

Cheers
Jon
