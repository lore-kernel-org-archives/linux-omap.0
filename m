From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] ARM: OMAP2+: PRCM cleanup series for 3.17
Date: Thu, 17 Jul 2014 00:12:26 -0700
Message-ID: <20140717071225.GE18374@atomide.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48239 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753452AbaGQHNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 03:13:50 -0400
Content-Disposition: inline
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140704 07:12]:
> Hi,
> 
> Here's a small PRCM cleanup series against 3.16-rc1, meant for 3.17
> if at all possible. Basically some cleanup to remove the direct CM/PRM
> register accesses outside PRCM drivers. This set is touching the OMAP2/
> OMAP3 code only. This series is part of the ongoing work to make PRCM
> a separate driver.
> 
> Testing done:
> - omap2430-sdp : boot
> - omap3-beagle : boot, suspend/resume (ret), suspend/resume (off)
> 
> Working branch:
> - tree: https://github.com/t-kristo/linux-pm.git
> - branch: for-v3.17/cm-prm-cleanup

Great seems to work for me for my omap3 off-idle test cases,
so pulling this into omap-for-v3.17/soc.

Regards,

Tony
