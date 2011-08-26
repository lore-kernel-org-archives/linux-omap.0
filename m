From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 01/12] OMAP2+: dmtimer: add device names to
 flck nodes
Date: Fri, 26 Aug 2011 19:45:22 +0530
Message-ID: <4E57AA7A.6060106@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59333 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab1HZOPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 10:15:33 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so3348474gxk.31
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 07:15:32 -0700 (PDT)
In-Reply-To: <1310731501-13078-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
> retrieved by doing a clk_get with the corresponding device pointers or
> device names.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---

Looks good to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
