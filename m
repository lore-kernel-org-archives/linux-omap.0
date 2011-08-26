From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 10/12] OMAP: dmtimer: mark clocksource and
 clockevent timers reserved
Date: Fri, 26 Aug 2011 21:14:21 +0530
Message-ID: <4E57BF55.7020503@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51489 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679Ab1HZPo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 11:44:28 -0400
Received: by mail-gx0-f177.google.com with SMTP id 2so4283514gxk.22
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 08:44:28 -0700 (PDT)
In-Reply-To: <1310731501-13078-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> In driver probe use sys_timer_reserved to identify which all timers
> have already been used for clocksource and clockevent. Mark all those
> timers as reserved so that no one else can use them.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Looks fine.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh
