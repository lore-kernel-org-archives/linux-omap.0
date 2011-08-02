From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2] OMAP4: I2C: Enable the wakeup in I2C_WE
Date: Tue, 02 Aug 2011 16:16:02 -0700
Message-ID: <877h6v8kwd.fsf@ti.com>
References: <1311953092-12506-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57082 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752966Ab1HBXQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 19:16:06 -0400
In-Reply-To: <1311953092-12506-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Fri, 29 Jul 2011 20:54:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, santosh.shilimkar@ti.com

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Currently for OMAP4 the I2C_WE is not programmed.
> This patch enables the programming for OMAP4.
>
> This patch fixes a bad conflict resolution.
> This effectively restores the following commit
>
> Commit 120bdaa47[i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup] 
>
> which got changed by
>
> Commit a3a7acbc[I2C: OMAP2+: address confused probed version naming] 
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> TODO:
> Currently all the wakeup sources are enabled.
> There is scope of optimising the same. Will revisit it.
> Rebased on Kevin's wip/i2c branch

Actually, this is based on top of your I2C reset series.

Please rebase this onto my for_3.1/i2c-andy branch, and I'll queue it as
a fix for v3.1.

Thanks,

Kevin
