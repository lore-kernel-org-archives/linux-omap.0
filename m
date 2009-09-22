From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ehci: fix ehci pin mux init
Date: Mon, 21 Sep 2009 17:47:58 -0700
Message-ID: <20090922004758.GE27699@atomide.com>
References: <1246617561-8644-1-git-send-email-ajay.gupta@ti.com> <20090703104715.GA4323@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49971 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZIVAr6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 20:47:58 -0400
Content-Disposition: inline
In-Reply-To: <20090703104715.GA4323@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Ajay Kumar Gupta <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [090703 03:47]:
> On Fri, Jul 03, 2009 at 12:39:21PM +0200, ext Ajay Kumar Gupta wrote:
> > EHCI pin mux init fucntion is still using old #ifdef
> > which are not defined anymore.This causes pin mux init to
> > always set TLL settings and thus EHCI PHY mode doesn't work.
> > 
> > Fixing this issue by using phy_mode parameter to initialize
> > mux settings.
> > 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Adding this to ehci branch.

Tony
