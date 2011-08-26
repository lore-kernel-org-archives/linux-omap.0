From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 09/12] OMAP: dmtimer: use mutex instead of
 spinlock
Date: Fri, 26 Aug 2011 21:04:12 +0530
Message-ID: <4E57BCF4.8030709@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:35606 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab1HZPeU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 11:34:20 -0400
Received: by mail-gx0-f179.google.com with SMTP id 1so2593988gxk.10
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 08:34:19 -0700 (PDT)
In-Reply-To: <1310731501-13078-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Since the spinlock is not used in any interrupt context we can
> replace it with mutex instead.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Patch looks good but change log doesn't reflect it.
Do you want to say that below API's are not used from
interrupt context, so mutex should be good enough ?

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh

