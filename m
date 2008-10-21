From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: PATCH 2/2 OMAP: HSMMC: Disable the mmc clocks when not needed
Date: Tue, 21 Oct 2008 17:25:12 +0300
Message-ID: <20081021142512.GA27397@angel.research.nokia.com>
References: <20081021124306.GA11845@angel.research.nokia.com> <20081021124624.GA11859@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64446 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbYJUOZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 10:25:27 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9LEPOXq026509
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 17:25:25 +0300
Received: from jlavi by angel.research.nokia.com with local (Exim 4.69)
	(envelope-from <jlavi@angel.research.nokia.com>)
	id 1KsIAa-00083w-R2
	for linux-omap@vger.kernel.org; Tue, 21 Oct 2008 17:25:12 +0300
Content-Disposition: inline
In-Reply-To: <20081021124624.GA11859@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tue, Oct 21, 2008 at 03:46:24PM +0300, Jarkko Lavinen wrote:
+static void omap_mmc_clks_disable(struct mmc_omap_host *host)
+{
+       unsigned long flags;
+
+       spin_lock_irqsave(&host->clk_lock, flags);
....
+       host->clks_enabled = 0;
+
+       return;
+}

Talking to myself here, but you just forgot spin_unlock_irqrestore()
from above.

Also I think one should enable the clocks in omap_mmc_set_ios() before 
touching the MMC controller registers.  And shut down the clocks when 
powering down.

Cheers
Jarkko
