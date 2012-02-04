From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 11:01:09 -0800
Message-ID: <20120204190109.GL20333@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42916 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2BDTBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 14:01:11 -0500
Content-Disposition: inline
In-Reply-To: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 10:24]:
> Does someone want to try building and running Linux on (eg) an OMAP34xx
> platform before I post my next email message on this subject, and
> maybe send me a bunch of patches required to fix stuff, to be applied
> to my tree _and_ _then_ forwarded to Linus next Friday.
> 
> So, think of this as your last chance, and you'll get the picture about
> how pissed off I am with the - yet again - current poor state of OMAP
> in mainline, which seems to happen every merge window.
> 
> Consider this: when Linus started using a PowerPC platform, the PowerPC
> people quickly realized that pushing patches upstream which broke stuff
> was a really bad idea, because they got publically flamed for such
> actions especially when stuff was not obviously tested.
> 
> This is no different... and this is _not_ my original email which I have
> queued up with the real hot flames in over this.  This is the toned down
> version.  The flames won't get sent if OMAP gets fixed quickly - and if
> testing improves to stop this constant cycle of regressions at every
> merge window.

Do you have the patches applied already queued up in arm-soc fixes
branch?

Regards,

Tony
