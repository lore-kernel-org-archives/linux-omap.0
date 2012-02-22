From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: panda: Correct cpu version check for 4430
Date: Wed, 22 Feb 2012 15:04:46 -0800
Message-ID: <20120222230446.GU18185@atomide.com>
References: <1329470861-29795-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40256 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2BVXEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 18:04:49 -0500
Content-Disposition: inline
In-Reply-To: <1329470861-29795-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:56]:
> The cpu_is_omap4430() macro always return with 0. Use the correct
> cpu_is_omap443x() to check for Panda revision.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> 
> Hi,
> 
> Since the depending patches are going via Liam's tree it would be best if we
> can queue this via audio as well.
> Without this patch the audio on Panda 4430 is not working correctly.

Acked-by: Tony Lindgren <tony@atomide.com>
