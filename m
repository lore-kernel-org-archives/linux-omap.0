From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: fix rate prints
Date: Wed, 19 Feb 2014 19:25:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191924520.8777@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43125 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbaBSTZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 14:25:44 -0500
In-Reply-To: <1389944699-27962-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

On Fri, 17 Jan 2014, Tomi Valkeinen wrote:

> Printing with unsigned long rates with %ld gives wrong result if the
> rate is high enough. Fix this by using %lu.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for v3.15. 

There's a series here that converts the OMAP clock code away from signed 
longs for clock rates that was originally intended for v3.14, but it's 
been delayed.


- Paul
