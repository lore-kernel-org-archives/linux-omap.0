From: Peter Barada <peterb@logicpd.com>
Subject: Problems with 2.6.29-rc8 and SDRAM on LDP
Date: Sun, 22 Mar 2009 12:41:21 -0400
Message-ID: <1237740082.23022.9.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:56992 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752844AbZCVQlY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Mar 2009 12:41:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm basing a port of 2.6.29-rc8 (khilmans's PM branch) off of the LDP
configuration, and in arch/arm/mach-omap2/board-ldp, the call to
init_common_hw passes in four NULLs which cause the kernel to oops on
startup in omap2_sdrc_get_params, most likely because there is no
sdrc_params for it to sift through.

I tried to use the mt46j32m32lfc_sdrc_params(as in omap3beagle.c), but
that dies after the message "Reprogramming the SDRC" with a unhandled
fault, but no traceback.  I think this may be due to the OMAP2520LV SOM
board I'm using has a MT29C2G24MAKLAJG-6 IT instead of the MT46J32M32LFC
part, and SDRAM is all mucked up.

I assume that I have to create a sdram-mt29c262maklajg.h file that
contains the sdrc_params to use, but can anyone explain the differences
between the 5 entries in the array it would contain?  I know they are
tied to OPP levels, but "rate" seems to go down as the OPP level goes
up.  This doesn't make sense to me as I'd expect the rate to go up with
OPP level.  What am I missing?

-- 
Peter Barada <peterb@logicpd.com>
