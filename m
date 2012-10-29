From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 04/20] OMAPDSS: DISPC: fix dispc_mgr_lclk_rate for DIGIT
 output
Date: Mon, 29 Oct 2012 15:20:25 +0530
Message-ID: <508E5161.2060202@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56422 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277Ab2J2Jul (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 05:50:41 -0400
In-Reply-To: <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 24 October 2012 02:58 PM, Tomi Valkeinen wrote:
> dispc_mgr_lclk_rate() cannot currently be called with DIGIT channel
> parameter, even if dispc_ovl_lclk_rate() can. Fix this by making

It's called dispc_plane_lclk_rate() right now.

> dispc_mgr_lclk_rate() handle DIGIT channel also.

Did you see a bug with this? Or is this just a cleanup?

Archit
