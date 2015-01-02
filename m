From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: AM43xx: hwmod: set DSS submodule parent
 hwmods
Date: Fri, 2 Jan 2015 22:49:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501022249230.27058@utopia.booyaka.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com> <1418985914-9027-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37660 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbbABWuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jan 2015 17:50:00 -0500
In-Reply-To: <1418985914-9027-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 19 Dec 2014, Tomi Valkeinen wrote:

> Set DSS core hwmod as the parent for all the DSS submodules. This fixes
> the boot time DSS reset, removing the following warnings:
> 
> omap_hwmod: dss_dispc: cannot be enabled for reset (3)
> omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, queued for v3.19-rc.

Note that I cannot test this patch due to lack of a AM43xx board here.


- Paul
