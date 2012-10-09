From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c
 to be OMAP2+ only for now
Date: Tue, 9 Oct 2012 14:47:36 -0700
Message-ID: <20121009214736.GH12552@atomide.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
 <20121008221333.GZ13011@atomide.com>
 <alpine.DEB.2.00.1210092008370.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28214 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756932Ab2JIVrk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 17:47:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210092008370.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

* Paul Walmsley <paul@pwsan.com> [121009 13:12]:
> 
> OK if you want to leave it there, it's fine with me.  Looks like it 
> should go into drivers/ at some point though?

Yes it should be just a regular device driver
eventually at some point. But no rush, let's first
get the dependencies between device drivers and core
omap code removed by removing the remaining mach and
plat includes.

Regards,

Tony
