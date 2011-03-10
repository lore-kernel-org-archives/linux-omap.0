From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Thu, 10 Mar 2011 15:21:03 -0800
Message-ID: <87ei6eftpc.fsf@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47508 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753939Ab1CJXVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 18:21:10 -0500
Received: by pvg12 with SMTP id 12so368414pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 15:21:05 -0800 (PST)
In-Reply-To: <1299627948-20040-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 9 Mar 2011 05:15:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framework
> is not completely up and running.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

To make this series more readable, all the system_timer related
additions added in this patch (varialbles and functions) should not be
here since they are not used.  Instead, they should be added in the
patch that uses them.

Kevin
