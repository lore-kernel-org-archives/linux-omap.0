From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: TI81XX: Prepare for addition of
 TI814X support
Date: Wed, 7 Dec 2011 15:17:41 -0800
Message-ID: <20111207231741.GP31337@atomide.com>
References: <1318210796-2357-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15994 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1LGXRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 18:17:45 -0500
Content-Disposition: inline
In-Reply-To: <1318210796-2357-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Hemant Pedanekar <hemantp@ti.com> [111009 18:06]:
> This patch updates existing macros, functions used for TI816X, to enable
> addition of other SoCs belonging to TI81XX family (e.g., TI814X).
> 
> The approach taken is to use TI81XX/ti81xx for code/data going to be common
> across all TI81XX devices.
> 
> cpu_is_ti81xx() is introduced to handle code common across TI81XX devices.
> 
> In addition, ti8168_evm_map_io() is now replaced with ti81xx_map_io() and moved
> in mach-omap2/common.c as same will be used for TI814X and is not board
> specific.

Looks like this series needs a rebase after the map_io and common.h
changes. Can you please rebase against the current omap soc branch at
commit 24a5e092a387e4c8e93f33448da334bd3fd15192?

Regards,

Tony

