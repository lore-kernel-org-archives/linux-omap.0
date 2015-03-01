From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: fix deassert hardreset clkdm
 usecounting
Date: Sun, 1 Mar 2015 23:23:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503012322080.9987@utopia.booyaka.com>
References: <1424966760-30917-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41094 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbCAXXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2015 18:23:17 -0500
In-Reply-To: <1424966760-30917-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Thu, 26 Feb 2015, Tero Kristo wrote:

> Deasserting hardreset increases the usecount for the hwmod parent clockdomain
> always, however usecount is only decreased at end in certain error cases.
> This causes software supervised clockdomains to remain always on, preventing
> idle. Fixed by always releasing the hwmods clockdomain parent when exiting
> the function.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Tested-by: Carlos Hernandez <ceh@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks, queued for v4.0-rc fixes.


- Paul
