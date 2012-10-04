From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: Fix wrong include for McPDM
Date: Thu, 4 Oct 2012 18:47:46 +0100
Message-ID: <20121004174746.GR4360@opensource.wolfsonmicro.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
 <1349339236-3622-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58876 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932214Ab2JDRrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 13:47:48 -0400
Content-Disposition: inline
In-Reply-To: <1349339236-3622-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Oct 04, 2012 at 11:27:15AM +0300, Peter Ujfalusi wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> McPDM needs platt/cpu.h for omap_rev and not omap_hwmod.h.
> Drivers must not include omap_hwmod.h at, it will be
> private to mach-omap2 soon. Fix the problem before other
> drivers will also start including omap_hwmod.h.

This doesn't apply, don't know what it was generated against...
