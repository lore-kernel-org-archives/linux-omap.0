From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: cpuidle: Add description field to each C-state.
Date: Thu, 03 Mar 2011 17:41:19 -0800
Message-ID: <1299202879.3989.499.camel@vence>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
	 <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51310 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759095Ab1CDBlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 20:41:23 -0500
Received: by mail-vx0-f172.google.com with SMTP id 33so2194592vxg.17
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 17:41:22 -0800 (PST)
In-Reply-To: <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2011-02-11 at 20:42 +0530, Santosh Shilimkar wrote:
> Add a description field to each idle C-state. This helps to give
> better data with PowerTop and one don't have to refer to the code
> to link what Cx means from system point of view while analysing
> PowerTop data.
> 
> No functional change.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Looks good, queuing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin


