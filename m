From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: OMAP: Move plat/dmtimer.h to
 plat-omap/dmtimer.h
Date: Tue, 13 Nov 2012 14:26:13 -0800
Message-ID: <20121113222613.GM6801@atomide.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-9-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34962 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753798Ab2KMW0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 17:26:16 -0500
Content-Disposition: inline
In-Reply-To: <1352830403-1706-9-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121113 10:15]:
> Move plat/dmtimer.h to plat-omap/dmtimer.h in order to support a single
> zImage for ARM devices.

Let's skip this one for now as it turns out this solution won't
work either for multiplatform without adding nasty hacks to
arch/arm/Makefile to include arch/arm/plat-omap.

Sorry I don't have any real solution in mind other than making
the remaining dmtimer.h users to use Linux generic timer functions,
or pass the dmtimer functions in platform_data for now.

Regards,

Tony
