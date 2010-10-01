From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] omap: zoom2: fix build break due to ASoC changes
Date: Fri, 1 Oct 2010 13:36:05 -0700
Message-ID: <20101001203605.GE21157@opensource.wolfsonmicro.com>
References: <1285965011-17384-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37764 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752375Ab0JAUf6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 16:35:58 -0400
Content-Disposition: inline
In-Reply-To: <1285965011-17384-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Sat, Oct 02, 2010 at 02:00:11AM +0530, Anand Gadiyar wrote:
> Commit f0fba2ad1b6 (ASoC: multi-component - ASoC
> Multi-Component Support) in linux-next as of 20101001
> broke omap builds with the following errors.

Acked-by: Mark Brown <brooonie@opensource.wolfsonmicro.com>

since it fixes build breakage but it looks like it'll result in reduced
functionality so a nicer fix would be good.
