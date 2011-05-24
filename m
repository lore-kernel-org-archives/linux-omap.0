From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [GIT PULL] OMAP DSS updates for 2.6.40
Date: Tue, 24 May 2011 15:38:05 +0900
Message-ID: <20110524063803.GC11986@linux-sh.org>
References: <1306151004.1871.36.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:35440 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab1EXGiK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 02:38:10 -0400
Content-Disposition: inline
In-Reply-To: <1306151004.1871.36.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>

On Mon, May 23, 2011 at 02:43:24PM +0300, Tomi Valkeinen wrote:
> Here are the OMAP Display Subsystem updates for 2.6.40.
> 
> Most of the patches are OMAP4 related, either fixing the old code to
> allow us to implement new OMAP4 features, or implementing those new
> features. Other bigger changes are ULPS power management feature and
> moving the DSS header file from arch/arm/plat-omap/include to
> include/video.
> 
Pulled and pushed out, thanks. There were a couple of conflicts, so you
may want to doublecheck to make sure nothing was inadvertently broken.
