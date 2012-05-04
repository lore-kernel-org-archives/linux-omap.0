From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: panda: add statics to remove warnings
Date: Fri, 4 May 2012 12:29:03 -0700
Message-ID: <20120504192903.GQ5613@atomide.com>
References: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
 <20120424171630.GQ3739@atomide.com>
 <1335356951.2799.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48498 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2EDT3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 15:29:06 -0400
Content-Disposition: inline
In-Reply-To: <1335356951.2799.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120425 05:32]:
> On Tue, 2012-04-24 at 10:16 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120423 00:43]:
> > > Add statics to board-omap4-panda.c's internal functions and data
> > > structures to remove warnings.
> > 
> > Care to update with the warnings produced?
> 
> Ah, sure. Updated patch below:
> 
> From e96ddeb7d783d48a15a32f8ef5a7bae3089f66b9 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Wed, 28 Mar 2012 11:38:58 +0300
> Subject: [PATCH] OMAP4: panda: add statics to remove warnings
> 
> Add statics to board-omap4-panda.c's internal functions and data
> structures to remove sparse warnings:
> 
> arch/arm/mach-omap2/board-omap4panda.c:234:29: warning: symbol
> 'omap_panda_wlan_data' was not declared. Should it be static?
> arch/arm/mach-omap2/board-omap4panda.c:441:24: warning: symbol
> 'omap4_panda_dvi_device' was not declared. Should it be static?
> arch/arm/mach-omap2/board-omap4panda.c:451:12: warning: symbol
> 'omap4_panda_dvi_init' was not declared. Should it be static?
> arch/arm/mach-omap2/board-omap4panda.c:512:13: warning: symbol
> 'omap4_panda_display_init' was not declared. Should it be static?

Thanks adding to fixes-non-critical.

Tony
