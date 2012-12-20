From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] two trivial omap build error fixes for v3.8 merge
	window
Date: Thu, 20 Dec 2012 15:01:05 +0000
Message-ID: <20121220150105.GA28275@n2100.arm.linux.org.uk>
References: <20121219171828.GP4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34934 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab2LTPBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 10:01:17 -0500
Content-Disposition: inline
In-Reply-To: <20121219171828.GP4989@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 19, 2012 at 09:18:28AM -0800, Tony Lindgren wrote:
> Here's few more trivial build fixes caused by the merge
> conflicts.

If Olof isn't able to pull this stuff in tonight, I'll pull it into my
tree and send it up with my stuff.  I'll also see about picking up
on the previous one with the common.c vram.h fix too.

I'm not sure what Olof's plans are, but I know Arnd isn't around at
the moment, and Olof was travelling a couple of days ago and hasn't
reappeared since.  I don't think we can leave these fixes any longer
as OMAP has been broken in mainline for at least the last four days
and we're nearing the end of the merge window.
