From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH fixes] [OMAP1] Add missing clocks for OMAP 7xx
Date: Sun, 20 Dec 2009 15:35:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912201532500.12561@utopia.booyaka.com>
References: <1261326904-31656-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55246 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZLTWfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Dec 2009 17:35:24 -0500
In-Reply-To: <1261326904-31656-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Cory,

On Sun, 20 Dec 2009, Cory Maccarrone wrote:

> This change adds in some missing clocks that were needed as a result
> of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
> mach-omap1/clock_data.c).
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>

Thanks, queued for .33-rcX.  -- although I don't think this had anything 
to do with the clock_data.c conversion.  At least,

git diff 6f62b58dd4e697a23a308f5b77781394949d333e.. arch/arm/mach-omap1/clock.c

doesn't show a CK_7XX for either ck_dpll1 or api_ck in the original file.


- Paul
