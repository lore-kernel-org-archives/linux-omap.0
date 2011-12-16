From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP4: hwmod: Don't wait for the idle status
 if modulemode is not supported
Date: Fri, 16 Dec 2011 11:47:11 -0800
Message-ID: <20111216194711.GH32251@atomide.com>
References: <alpine.DEB.2.00.1112160553300.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47679 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1LPTrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 14:47:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160553300.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com

* Paul Walmsley <paul@pwsan.com> [111216 04:23]:
> From: Benoit Cousson <b-cousson@ti.com>
> 
> If the module does not have any modulemode, the _disable_module function
> will do nothing. There is then no point waiting for a idle status change.
> 
> It will remove the following warnings.
> 
> [    0.331848] omap_hwmod: dmm: _wait_target_disable failed
> [    0.339935] omap_hwmod: emif_fw: _wait_target_disable failed
> [    0.348358] omap_hwmod: l3_main_1: _wait_target_disable failed
> [    0.356964] omap_hwmod: l3_main_2: _wait_target_disable failed
> [    0.365600] omap_hwmod: l4_abe: _wait_target_disable failed
> [    0.373931] omap_hwmod: l4_cfg: _wait_target_disable failed
> [    0.382263] omap_hwmod: l4_per: _wait_target_disable failed
> [    0.391113] omap_hwmod: l4_wkup: _wait_target_disable failed
> [    0.399536] omap_hwmod: dma_system: _wait_target_disable failed
> [    0.408325] omap_hwmod: dss_core: _wait_target_disable failed
> [    0.416839] omap_hwmod: dss_dispc: _wait_target_disable failed
> [    0.425445] omap_hwmod: dss_dsi1: _wait_target_disable failed
> [    0.433990] omap_hwmod: dss_dsi2: _wait_target_disable failed
> [    0.442504] omap_hwmod: dss_hdmi: _wait_target_disable failed
> [    0.451019] omap_hwmod: dss_rfbi: _wait_target_disable failed
> [    0.459564] omap_hwmod: dss_venc: _wait_target_disable failed
> [    0.489471] omap_hwmod: mailbox: _wait_target_disable failed
> [    0.505920] omap_hwmod: spinlock: _wait_target_disable failed
> 
> Note: For such module, the state is managed automatically by HW according
> to clock domain transition. It is then not possible to wait for idle even
> later in the _idle function since the status will change at clock domain
> boundary.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> [paul@pwsan.com: renamed fns to indicate that they are OMAP4-only; moved
>  _wait_target_disable() into _disable_module(), removing duplicate code]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
> Should apply cleanly on top of "[PATCH v4] ARM: OMAP2+: hwmod: Add a new 
> flag to handle hwmods left enabled at init".

Applying into fixes-non-critical-part2, seems to merge fine with
the patch above in the uart branch.

Regards,

Tony
