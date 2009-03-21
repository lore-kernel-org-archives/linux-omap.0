From: dfoley <dfoley@telus.net>
Subject: omap3evm mmc problem
Date: Fri, 20 Mar 2009 21:58:54 -0700
Message-ID: <gq1s6e$ssu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59199 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbZCUE7K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Mar 2009 00:59:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LktIZ-0007Xp-0N
	for linux-omap@vger.kernel.org; Sat, 21 Mar 2009 04:59:07 +0000
Received: from d75-157-37-52.bchsia.telus.net ([75.157.37.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 21 Mar 2009 04:59:07 +0000
Received: from dfoley by d75-157-37-52.bchsia.telus.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 21 Mar 2009 04:59:07 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Does anyone else get these mmc errors or know why on the OMAP 3530 Development board ?

mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
regulator: Unable to get requested regulator: vmmc
mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect
mmci-omap-hs mmci-omap-hs.0: late init error
mmci-omap-hs mmci-omap-hs.0: Probe Failed

I'm using the current git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6

