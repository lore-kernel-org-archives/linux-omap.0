From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] cbus: tahvo: Remove dead code from tahvo-usb.c
Date: Wed, 20 Apr 2011 09:12:43 -0700
Message-ID: <20110420161243.GD10402@atomide.com>
References: <1303201193-11516-1-git-send-email-jhnikula@gmail.com>
 <20110419100511.GB28899@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41429 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754048Ab1DTTwQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 15:52:16 -0400
Content-Disposition: inline
In-Reply-To: <20110419100511.GB28899@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [110419 03:02]:
> On Tue, Apr 19, 2011 at 11:19:53AM +0300, Jarkko Nikula wrote:
> > Looks like this code was ever used. It was added by commit
> > fe3702054f6412aea04373ceb9d27a4a417ff3f0 "OMAP: Fix USB on Nokia 770"
> > that can be found from linux-omap history if needed.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> FWIW:
> 
> Reviewied-by: Felipe Balbi <balbi@ti.com>

Both applied to the cbus branch.

Tony
