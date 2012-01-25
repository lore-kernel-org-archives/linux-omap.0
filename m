From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after
 dss_core
Date: Wed, 25 Jan 2012 14:23:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251423290.5324@utopia.booyaka.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com> <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47309 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2AYVXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 16:23:46 -0500
In-Reply-To: <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il, sasha_d@emcraft.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>

On Wed, 28 Dec 2011, Ilya Yanok wrote:

> dss_core has to be initialized before any other DSS hwmod. Currently
> this is broken as dss_core is listed in chip/revision specific hwmod
> lists while other DSS hwmods are listed in common list which is
> registered first.
> 
> This patch moves DSS hwmods (except for dss_core) to the separate list
> which is registered last to ensure that dss_core is already registered.
> 
> This solves the problem with BUG() in L3 interrupt handler on boards
> with DSS enabled in bootloader.
> 
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Archit Taneja <archit@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Thanks Ilya, queued for 3.3-rc.


- Paul
