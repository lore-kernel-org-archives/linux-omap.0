From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: State of LDP3430 platform
Date: Wed, 19 Jan 2011 15:43:39 +0200
Message-ID: <20110119154339.9f20759b.jhnikula@gmail.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
	<20101206181913.GH8345@atomide.com>
	<alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
	<20101207083720.GB18336@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
	<alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
	<20110115000301.GT4957@atomide.com>
	<alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
	<20110115233744.GA18159@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
	<4D3309F9.8090900@gmail.com>
	<alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57971 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1ASNnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 08:43:45 -0500
Received: by fxm20 with SMTP id 20so891697fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 05:43:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Tue, 18 Jan 2011 12:36:26 -0700 (MST)
Paul Walmsley <paul@pwsan.com> wrote:

> This is due to the recent ARM init_sched_clock() changes and the late
> initialization of the counter_32k clock source.  More information here:
> 
>    http://marc.info/?l=linux-omap&m=129513468605208&w=2
> 
> Fix by initializing the counter_32k clocksource during the machine timer
> initialization.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Thomas Weber <weber@corscience.de>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
Thanks Paul. My tested-by is late as this in already in your pull
request but wanted to comment that this makes the mainline working on
omap3 after commit 211baa7
"ARM: sched_clock: allow init_sched_clock() to be called early"

-- 
Jarkko
