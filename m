From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP34xx
Date: Sat, 4 Feb 2012 18:54:53 +0000
Message-ID: <20120204185453.GB17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53780 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab2BDSy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 13:54:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Does someone want to try building and running Linux on (eg) an OMAP34xx
platform before I post my next email message on this subject, and
maybe send me a bunch of patches required to fix stuff, to be applied
to my tree _and_ _then_ forwarded to Linus next Friday.

So, think of this as your last chance, and you'll get the picture about
how pissed off I am with the - yet again - current poor state of OMAP
in mainline, which seems to happen every merge window.

Consider this: when Linus started using a PowerPC platform, the PowerPC
people quickly realized that pushing patches upstream which broke stuff
was a really bad idea, because they got publically flamed for such
actions especially when stuff was not obviously tested.

This is no different... and this is _not_ my original email which I have
queued up with the real hot flames in over this.  This is the toned down
version.  The flames won't get sent if OMAP gets fixed quickly - and if
testing improves to stop this constant cycle of regressions at every
merge window.

Thanks.
