From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2] usb: musb: MUSB_OTG should depend on PM
Date: Mon, 23 Jun 2008 14:15:17 +0300
Message-ID: <20080623111517.GI4414@gandalf.research.nokia.com>
References: <1213182432-23952-1-git-send-email-felipe.balbi@nokia.com> <1213182432-23952-2-git-send-email-felipe.balbi@nokia.com> <20080623111348.GR7741@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27928 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbYFWLQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2008 07:16:19 -0400
Content-Disposition: inline
In-Reply-To: <20080623111348.GR7741@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Mon, Jun 23, 2008 at 02:13:49PM +0300, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080611 14:09]:
> > Current musb Kconfig causes cyclic depency on x86
> > arch. The best fix is to depend on PM in order to
> > build on OTG mode.
> > 
> > Anyone interested in reproducing the error in your
> > linux-omap trees, just make ARCH=x86 menuconfig
> 
> I guess this is now obsolete with Dave's HAS_CLK patch?

Yes, it was removed already :-)

-- 
	- Balbi
