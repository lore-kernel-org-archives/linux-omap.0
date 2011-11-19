From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Remove empty io.h
Date: Fri, 18 Nov 2011 16:29:16 -0800
Message-ID: <20111119002916.GZ31337@atomide.com>
References: <1320755982-27005-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10110 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750988Ab1KSA3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:29:18 -0500
Content-Disposition: inline
In-Reply-To: <1320755982-27005-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org

* Thomas Weber <weber@corscience.de> [111108 04:05]:
> The file arch/arm/mach-omap2/io.h is empty, so we can remove it.

Thanks applying into fixes.

Tony
 
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/io.h
> 
> diff --git a/arch/arm/mach-omap2/io.h b/arch/arm/mach-omap2/io.h
> deleted file mode 100644
> index e69de29..0000000
> -- 
> 1.7.7.2
> 
