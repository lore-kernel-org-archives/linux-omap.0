From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] omap: zoom2: Fix ASoC multi-component build
 breakage by removing dead code
Date: Thu, 23 Sep 2010 17:14:54 +0100
Message-ID: <20100923161454.GA32112@rakim.wolfsonmicro.main>
References: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53437 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753270Ab0IWQO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 12:14:57 -0400
Content-Disposition: inline
In-Reply-To: <1285258314-23721-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, Sep 23, 2010 at 07:11:53PM +0300, Jarkko Nikula wrote:
> ASoC Multi-Component Support patch removes #if 0 in board-zoom2.c that was
> used to protect some uncompiling dead code. Remove that code as it seems to
> be here quite some time since commit 479f12c.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
