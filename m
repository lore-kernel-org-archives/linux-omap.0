From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH ] omap4: Move SOC specific code from board file
Date: Tue, 11 May 2010 17:12:10 -0700
Message-ID: <20100512001209.GT13931@atomide.com>
References: <1272695817-5973-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49436 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0ELAMJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 20:12:09 -0400
Content-Disposition: inline
In-Reply-To: <1272695817-5973-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100430 23:32]:
> This patch moves OMAP4 soc specific code from 4430sdp board file.
> The change is necessary so that newer board support can be added
> with minimal changes. This will be also problematic for
> multi-board, multi-omap builds.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> (Because veger issue this one never made to the list )
> Boot tested with regular and multi-omap defconfig on OMAP4430 and
> OMAP3430 SDPs. Needs Tony's sram fix to make multi-omap boot on OMAP4.

I'll apply this into omap for-next.

Regards,

Tony
