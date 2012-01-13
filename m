From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] usb: musb: drop superfluous pm_runtime calls around musb_shutdown
Date: Fri, 13 Jan 2012 11:02:48 +0530
Message-ID: <4F0FC200.1020602@ti.com>
References: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57404 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759Ab2AMFc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 00:32:57 -0500
In-Reply-To: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>

On Thursday 12 January 2012 06:51 PM, Grazvydas Ignotas wrote:
> Since commit 4f9edd2d7e8d "usb: musb: Fix the crash issue during reboot"
> musb_shutdown() does pm_runtime_get_sync/pm_runtime_put by itself, so
> this no longer needs to be done by the caller. Also, musb_exit_debugfs()
> doesn't access the device, so just drop those runtime_pm calls.
>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Looks good to me
Reviewed-by: Shubhrajyoti D <shubhrajyoti@ti.com>
