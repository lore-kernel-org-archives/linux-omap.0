From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: New build error?
Date: Tue, 7 Apr 2009 20:55:24 +0100
Message-ID: <20090407195524.GA10619@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40142 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbZDGTzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 15:55:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Pierre Ossman <drzeus@drzeus.cx>

Caused by: 4a694dc915c9a223044ce21fc0d99e63facd1d64

    omap_hsmmc: Fix response type for busy after response

Error:

drivers/mmc/host/omap_hsmmc.c: In function 'mmc_omap_xfer_done':
drivers/mmc/host/omap_hsmmc.c:301: error: implicit declaration of function 'mmc_omap_fclk_lazy_disable'

Please submit a fix to Pierre for this, thanks.
