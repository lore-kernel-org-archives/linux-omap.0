From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 02/12] OMAP4: hwmod data: add dmtimer version
 information
Date: Fri, 26 Aug 2011 20:51:33 +0530
Message-ID: <4E57B9FD.7010301@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60687 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753464Ab1HZPVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 11:21:40 -0400
Received: by mail-yw0-f53.google.com with SMTP id 5so3938269ywb.40
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 08:21:39 -0700 (PDT)
In-Reply-To: <1310731501-13078-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
> while the rest of the timers, 3-9, 11 are version 2 timers.
> The version information is required by the driver so that they
> could be handled correctly by it.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> ---
Since Benoit has already acked it, you can remove the CC.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh


