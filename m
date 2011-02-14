From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] RETU fetch IRQ via struct resource
Date: Mon, 14 Feb 2011 15:22:42 -0800
Message-ID: <20110214232242.GS20795@atomide.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
 <20110214190001.GT2549@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40097 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1BNXWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 18:22:48 -0500
Content-Disposition: inline
In-Reply-To: <20110214190001.GT2549@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110214 10:58]:
> Hi,
> 
> On Thu, Feb 10, 2011 at 12:21:17PM +0200, Felipe Balbi wrote:
> > here are 4 very quick patches to grab IRQ
> > via struct resource. Now all these changes
> > need to be ported to Tahvo. I'm not sure
> > I'll have any time to look at that for a
> > while, though.

OK, great those four are working. I've applied them
to the cbus branch.
 
> Want me to re-send all patches or you can pull from my cbus branch to
> test ?

Hmm well maybe send the new ones? Then I can pull assuming you
rebase on the cbus branch. That's usable now too and up to v2.6.38-rc4.
 
> Any taker for fixing tahvo ? All you have to do is port the changes done
> in retu to tahvo. Tahvo is a lot simpler than retu though.

It will be at least few weeks before I can do anything except
look and merge patches..

Tony
