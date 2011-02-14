From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] omap2plus: omap4: Set NR_CPU to 2 instead of
 default 4
Date: Mon, 14 Feb 2011 13:09:18 -0800
Message-ID: <20110214210918.GJ20795@atomide.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
 <1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56111 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab1BNVJV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 16:09:21 -0500
Content-Disposition: inline
In-Reply-To: <1297510187-31547-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 03:28]:
> The omap2plus_defconfig picks default NR_CPU value as 4 which isn't
> correct for OMAP4430. Available CPUs are ony 2, so fix the same.

I'll queue this for the upcoming merge window.

Tony
