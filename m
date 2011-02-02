From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register(v1)
Date: Wed, 2 Feb 2011 12:24:08 -0800
Message-ID: <20110202202407.GI3322@atomide.com>
References: <1294236201-4114-1-git-send-email-tom.leiming@gmail.com>
 <20110202113717.GC5370@legolas.emea.dhcp.ti.com>
 <20110202115749.GD5370@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20029 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab1BBUYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 15:24:15 -0500
Content-Disposition: inline
In-Reply-To: <20110202115749.GD5370@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: tom.leiming@gmail.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, arm-kernel@lists.infradead.org

* Felipe Balbi <balbi@ti.com> [110202 03:56]:
> On Wed, Feb 02, 2011 at 01:37:17PM +0200, Felipe Balbi wrote:
> > Tony,
> > 
> > On Wed, Jan 05, 2011 at 10:03:21PM +0800, tom.leiming@gmail.com wrote:
> > > From: Ming Lei <tom.leiming@gmail.com>
> > > 
> > > Panda uses both twl6030 otg phy(vbus, id) and internal
> > > phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
> > > twl6030 otg driver working since current otg code only supports
> > > one global transceiver. Otherwise, musb doesn't work without
> > > the remove.
> > > 
> > > Reviewd-by: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> > 
> > Care to queue this together with your fixes
> 
> Without this patch, MUSB doesn't work on pandaboard.

Thanks, applied it to devel-fixes.

Tony
