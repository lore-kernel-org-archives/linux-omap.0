From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: Fix the dt return condition in
 pm_late_init()
Date: Fri, 8 Feb 2013 15:34:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081533270.28008@utopia.booyaka.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49829 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab3BHPeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 10:34:10 -0500
In-Reply-To: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 8 Feb 2013, Santosh Shilimkar wrote:

> Commit 1416408d {ARM: OMAP2+: PM: share some suspend-related functions
> across OMAP2, 3, 4} moved suspend code to common place but now with
> that change, for DT build on OMAP4, suspend hooks are not getting
> registered which results in no suspend support.
> 
> The DT return condition is limited to PMIC and smartreflex
> initialization and hence restrict it so that suspend ops gets
> registered.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, queued here with Felipe's Reviewed-by: along with the other OMAP4 
PM fixes.

- Paul
