From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix EMU clock domain always on
Date: Sun, 9 Dec 2012 20:34:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212092033450.351@utopia.booyaka.com>
References: <1354911994-20045-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40264 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934486Ab2LIUen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:34:43 -0500
In-Reply-To: <1354911994-20045-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>

Hi Jon,

On Fri, 7 Dec 2012, Jon Hunter wrote:

> Commit d043d87 (ARM: OMAP2+: clockdomain: bypass clockdomain handling
> when disabling unused clks) skips the decrementing of a clock-domains
> use count if the clocks use count is zero. However, for OMAP4 devices
> this is causing the EMU clock-domain to be stuck ON as the use count is
> not getting decremented correctly.

Thanks for the fix and the great patch description; queued for v3.8-rc.


- Paul
