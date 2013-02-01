From: Paul Walmsley <paul@pwsan.com>
Subject: Existing queued v3.8-rc fixes postponed to v3.9
Date: Fri, 1 Feb 2013 04:22:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302010415370.32268@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56268 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab3BAEWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 23:22:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: t-kristo@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi,

so, v3.8-rc6 is out, and based on Linus' release message:

http://marc.info/?l=linux-kernel&m=135968304820921&w=2

he only wants to see patches that "fix major security issues, big 
user-reported regressions, or nasty oopses".

So as a result the fixes that you've recently sent will be deferred to the 
v3.9 merge window.

...

As far as the OMAP4 PM stuff goes, I'm pretty disappointed that v3.8 is 
going to be released with non-obvious bootloader dependencies for 
full-chip power management.  Let's get the warning patch written and 
posted right away so it can go in during the v3.9 merge window.


- Paul
