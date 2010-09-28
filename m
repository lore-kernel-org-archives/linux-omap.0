From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] omap: zoom2: Fix ASoC multi-component build
 breakage by removing dead code
Date: Tue, 28 Sep 2010 14:03:12 -0700
Message-ID: <20100928210311.GK3117@atomide.com>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53836 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab0I1VDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:03:24 -0400
Content-Disposition: inline
In-Reply-To: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [100923 09:05]:
> ASoC Multi-Component Support patch removes #if 0 in board-zoom2.c that was
> used to protect some uncompiling dead code. Remove that code as it seems to
> be here quite some time since commit 479f12c.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Vikram Pandita <vikram.pandita@ti.com>

I assume you guys want to merge this via ASoC patches.

Acked-by: Tony Lindgren <tony@atomide.com>

