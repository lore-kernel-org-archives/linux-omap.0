From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
Date: Sat, 9 Jul 2011 02:24:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107090224100.15984@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>  <1309552901-8944-18-git-send-email-b-cousson@ti.com> <1309598037.1846.3.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60884 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab1GIIYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 04:24:39 -0400
In-Reply-To: <1309598037.1846.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Sat, 2 Jul 2011, Tomi Valkeinen wrote:

> This patch adds "fck" opt-clocks for DSS. After your patch set
> for_3.1/5_auto_fck_clkdev, in which you create "fck" automatically, I
> see:
> 
> [    0.218231] omap_device: omapdss_dss: fck already exist
> [    0.218261] omap_device: omapdss_dss: fck already exist
> [    0.218261] omap_device: omapdss_dss: sys_clk already exist
> [    0.218261] omap_device: omapdss_dss: tv_clk already exist
> [    0.218322] omap_device: omapdss_dss: video_clk already exist
> [    0.218627] omap_device: omapdss_dispc: fck already exist
> [    0.219329] omap_device: omapdss_venc: fck already exist
> [    0.219635] omap_device: omapdss_dsi1: fck already exist
> [    0.219970] omap_device: omapdss_dsi2: fck already exist
> [    0.220336] omap_device: omapdss_hdmi: fck already exist
> 
> So I think the "fck" clocks in this patch should be removed. I only
> added them for compatibility, as I didn't have the automatic "fck"
> creation patch in my tree.

Thanks Tomi, I've gone ahead and removed these.


- Paul
