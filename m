From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 0/4] i2c: omap: few more patches
Date: Tue, 07 Aug 2012 16:57:51 +0530
Message-ID: <5020FBB7.3030308@ti.com>
References: <1344262737-6662-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35933 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059Ab2HGL16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 07:27:58 -0400
Received: by yenq6 with SMTP id q6so4514565yen.39
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 04:27:57 -0700 (PDT)
In-Reply-To: <1344262737-6662-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de

On Monday 06 August 2012 07:48 PM, Felipe Balbi wrote:
> Just a few extra patches on top of the earlier series I sent.
>
> With these patches, we have threaded irq support and autosuspend support for
> i2c-omap driver.
Thanks for the patches.
>
> All patches boot tested with pandaboard.
Tested-by: Shubhrajyoti <shubhrajyoti@ti.com>

On omap4sdp and omap3sdp
also on omap3 did some basic power testing.
> Felipe Balbi (4):
>   i2c: omap: always return IRQ_HANDLED
>   i2c: omap: switch to threaded IRQ support
>   i2c: omap: remove unnecessary pm_runtime_suspended check
>   i2c: omap: switch over to autosuspend API
>
>  drivers/i2c/busses/i2c-omap.c | 53 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>

