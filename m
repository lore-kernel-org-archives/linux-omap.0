From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix build break by moving omap_smc1 into a
 separate .S
Date: Thu, 11 Mar 2010 09:35:19 -0800
Message-ID: <20100311173519.GH2900@atomide.com>
References: <1268292826-1937-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50256 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab0CKRd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 12:33:57 -0500
Content-Disposition: inline
In-Reply-To: <1268292826-1937-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100310 23:30]:
> This patch moves omap_smc1 function to a seperate omap44xx-smc.S file
> and sets compile flags as -Wa,-march=armv7-a.

Thanks for doing this, I'll add it to omap-fixes.

Regards,

Tony
