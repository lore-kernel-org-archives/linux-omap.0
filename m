From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP totally fucked?
Date: Tue, 6 Mar 2012 15:08:26 +0000
Message-ID: <20120306150826.GA15392@n2100.arm.linux.org.uk>
References: <20120303180428.GA10293@atomide.com> <20120303183225.GA17710@n2100.arm.linux.org.uk> <20120303190140.GB19248@atomide.com> <20120303192839.GB17710@n2100.arm.linux.org.uk> <20120303200123.GB10293@atomide.com> <20120303202810.GC10293@atomide.com> <20120303203448.GD10293@atomide.com> <20120303205200.GC17710@n2100.arm.linux.org.uk> <20120303212101.GF10293@atomide.com> <4F56261A.3090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35827 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893Ab2CFPIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:08:38 -0500
Content-Disposition: inline
In-Reply-To: <4F56261A.3090002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Tue, Mar 06, 2012 at 03:58:34PM +0100, Cousson, Benoit wrote:
> We added that to avoid cluttering the drivers with a bunch of #ifdef  
> CONFIG_OF as proposed by Grant and Rob... and most drivers adaptation  
> were done having that assumption.
> So if we removed that today, it will be like removing the IRQDOMAIN  
> define during the last merge window, it will break when the drivers DT  
> adaptation will be pulled.

But aren't the OF interfaces stubbed out in linux/of.h when DT support
is disabled?

Or are you saying that we're heading for a situation where _existing_
drivers stop working when OF isn't enabled?
