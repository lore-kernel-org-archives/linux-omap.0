From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 00/10] I2C updates
Date: Fri, 24 Feb 2012 15:01:45 +0530
Message-ID: <4F475901.10005@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:43466 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756123Ab2BXJbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:31:51 -0500
Received: by mail-yw0-f53.google.com with SMTP id j72so1069747yhj.12
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2012 01:31:50 -0800 (PST)
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khali@linux-fr.org, Kevin Hilman <khilman@ti.com>, Ben Dooks <ben-linux@fluff.org>

On Friday 10 February 2012 07:29 PM, Shubhrajyoti D wrote:
> This patch series colates the various i2c updates into
> a series.  Since it is collection of various patches
> the version info is not retained, however most of them undergone
> multiple versions.
If there are no further comments can this be queued.

> This is rebased to linus head commit 63082402968f4b73f10b28a8ac1f3da821aeb82d
>
> The patch series does the following 
>
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - I2C register restore only if context if the context is lost
> - Bus busy recovery mechanism.
> - the reset is not done in init.
>
> Tested on omap4sdp and omap3sdp. 
>
>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
>
> Jon Hunter (1):
>   I2C: OMAP: Correct I2C revision for OMAP3
>
> Shubhrajyoti D (8):
>   I2C : OMAP : make omap_i2c_unidle/idle functions depend on
>     CONFIG_PM_RUNTIME
>   OMAP : I2C : Remove reset at init
>   OMAP: I2C: I2C register restore only if context is lost
>   OMAP: I2C: Fix the interrupt clearing in OMAP4
>   OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
>   OMAP: I2C: Optimise the remove code
>   OMAP: I2C: Fix the error handling
>   I2C: OMAP: Don't check if wait_for_completion_timeout() returns less
>     than zero
>
> Vikram Pandita (1):
>   I2C: OMAP: Recover from Bus Busy condition
>
>  drivers/i2c/busses/i2c-omap.c |  173 ++++++++++++++++++++++++-----------------
>  1 files changed, 101 insertions(+), 72 deletions(-)
>

