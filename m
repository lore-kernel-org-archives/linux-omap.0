From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
Date: Fri, 17 Dec 2010 11:32:23 +0000
Message-ID: <20101217113223.GC9937__10661.0114373781$1292585645$gmane$org@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49249 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0LQLdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 06:33:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Rubini <rubini@unipv.it>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.>
Cc: linux-arm-kernel@lists.infradead.org

Here is the entire set of clocksource and sched_clock patches which
have been previously posted.  There's a couple of small tweaks in a
few of the patches (such as adding notrace to OMAP clocksource read
functions), and this also shows the proper ordering of these patches.

Still looking for acks or tested-by's for these patches.
