From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Wed, 29 Aug 2012 17:20:39 -0700
Message-ID: <20120830002039.GP1303@atomide.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <cover.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44278 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753968Ab2H3AUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 20:20:44 -0400
Content-Disposition: inline
In-Reply-To: <cover.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: tomi.valkeinen@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Chandrabhanu Mahapatra <cmahapatra@ti.com> [120820 06:26]:
> Hi everyone,
> this patch series aims at cleaning up of DSS of cpu_is checks thereby making it
> more generic.
> 
> The 1st patch cleans up cpu_is checks from DISPC code.
> The 2nd patch removes unused functions from DSS code.
> The 3rd patch cleans up cpu_is checks from DSS code.
> The 4th patch removes cpu_is checks from VENC code.
> The 5th patch disables VENC support on OMAP4.
> The 6th patch removes cpu_is checks from DPI code and replaces it with a
> dss feature.

Good to see this, we need this badly to avoid blocking
single zImage effort on omaps. Can you also please take
a look at the omap dss headers and make sure that
drivers/video/omap code does not do any #include <mach/*.h>
or <plat/*.h>?

The driver specific headers should be now moved to live in
include/linux/platform_data directory instead of the current
arch/arm/*omap*/include/*.

Regards,

Tony
