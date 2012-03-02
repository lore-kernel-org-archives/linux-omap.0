From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [GIT PULL 3/5] First set of omap1 related changes
Date: Fri, 02 Mar 2012 18:20:38 +0100
Message-ID: <35028515.2H84FQMe6Y@acer>
References: <0Mfo5g-1RocQt3wlY-00NttP@mx.kundenserver.de> <3378572.m1z82NvySs@acer> <20120301233101.GC18901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51056 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218Ab2CBR2R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 12:28:17 -0500
In-Reply-To: <20120301233101.GC18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 1 Mar 2012 15:31:01 Tony Lindgren wrote:
> 
> I've pushed ams-delta branch that's based on -rc5 merged
> with what Arnd pulled yesterday as -rc1 has i2c-omap.c
> a compile bug for omap1. I've applied these two patches
> there as the second one depends on what got pulled:
> 
> ARM: OMAP1: ams-delta: clean up init data section assignments
> ARM: OMAP1: ams-delta: fix incorrect section tags

Thanks!

> Looks like your patch "ARM: OMAP1: ams-delta: set up regulator
> over modem reset GPIO pin" causes the following error with
> CONFIG_DEBUG_SECTION_MISMATCH=y:
> 
> arch/arm/mach-omap1/board-ams-delta.c:273:36: error:
> modem_nreset_config causes a section type conflict
> 
> So care to update and repost that (and possibly the following
> two patches) with your missing fixes?

OK, I will, in a couple of days.

Thanks,
Janusz
