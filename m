From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
Date: Sat, 02 Jul 2011 12:36:28 +0300
Message-ID: <1309599388.1846.12.camel@deskari>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	 <1309552901-8944-18-git-send-email-b-cousson@ti.com>
	 <1309598037.1846.3.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40176 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072Ab1GBJgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 05:36:35 -0400
Received: by bwd7 with SMTP id 7so4291711bwd.2
        for <linux-omap@vger.kernel.org>; Sat, 02 Jul 2011 02:36:32 -0700 (PDT)
In-Reply-To: <1309598037.1846.3.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 2011-07-02 at 12:13 +0300, Tomi Valkeinen wrote:
> Hi Benoit,
> 
> On Fri, 2011-07-01 at 22:41 +0200, Benoit Cousson wrote:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Add missing DSS optional clocks to HWMOD data for OMAP4xxx.
> > 
> > Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > [b-cousson@ti.com: Remove a comment and update the subject]
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> 
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

Even after removing the "fck"s from the hwmod data, I see:

[    0.218200] omap_device: omapdss_dss: fck already exist
[    0.218231] omap_device: omapdss_dss: sys_clk already exist
[    0.218231] omap_device: omapdss_dss: tv_clk already exist
[    0.218292] omap_device: omapdss_dss: video_clk already exist

I think those come from the clock44xxx_data.c. I believe those are more
or less exact duplicates from the driver's point of view? If so, I guess
the ones in clockdata could be removed after adding those to hwmod data?

I also see that the main_clk for all dss hwmods is dss_dss_clk. Is that
correct? In some earlier version the clocks were a bit different, and,
at least according to TRM pictures, correct. For example, rfbi didn't
have a main_clk at all, hdmi's main_clk was dss_48mhz_clk etc. Was that
changed on purpose?

I've tested all the branches from 1 to 7 on OMAP4 SDP, and I'm able to
boot all of them (branch 7 needed merging the mmc branch), and I was
able to start the dss driver. I also merged my latest dss pmruntime
branch, which worked fine.

I still need to test OMAP2/3, and the different outputs on OMAP4 (only
DSI is tested so far).

 Tomi


