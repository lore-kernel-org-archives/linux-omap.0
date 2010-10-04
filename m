From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap: devices: Avoid merge conflict between ASoC and
 OMAP hwmod changes
Date: Mon, 4 Oct 2010 08:04:43 -0700
Message-ID: <20101004150442.GC1505@opensource.wolfsonmicro.com>
References: <1286193893-22131-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51189 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753489Ab0JDPE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:04:29 -0400
Content-Disposition: inline
In-Reply-To: <1286193893-22131-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On Mon, Oct 04, 2010 at 03:04:53PM +0300, Jarkko Nikula wrote:
> Upcoming ASoC multi-component and OMAP hwmod changes will conflict
> in arch/arm/mach-omap2/devices.c. Avoid this by moving a little bit
> include statement introduced by ASoC Multi-Component Support patch.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
