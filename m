From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 00:24:05 +0000
Message-ID: <20120207002405.GA18209@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49160 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab2BGAYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 19:24:19 -0500
Content-Disposition: inline
In-Reply-To: <4F306016.9010203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
> In theory that patch should not be even needed.

In theory that change is needed to fix the obviously broken code which
is there at the moment.

So, irrespective of whether OF gets permanently enabled or not, that ifdef
needs to go.

But, forcing OF on at this point probably isn't a good idea (who knows
what else is lurking there) and there's a fairly simple and tested fix
for this as I've shown in my OMAP patch.

That, I feel, is likely to have less side effects than force enabling
USE_OF.
