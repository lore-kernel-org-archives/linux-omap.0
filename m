From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Mon, 17 Jan 2011 15:23:18 -0800
Message-ID: <20110117232318.GJ4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.00.1101171702510.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42985 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1AQXXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:23:35 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101171702510.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [110117 14:02]:
> On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:
> 
> > Rather than turning off CPU domain switching when the build architecture
> > includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> > turn it on when it's required to support a CPU architecture.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
