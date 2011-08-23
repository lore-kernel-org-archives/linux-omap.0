From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 22/22] gpio/omap: remove omap_gpio_save_context overhead
Date: Tue, 23 Aug 2011 20:12:14 +0530
Message-ID: <4E53BC46.7050309@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-23-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:60813 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab1HWOmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:42:21 -0400
Received: by mail-yx0-f172.google.com with SMTP id 17so175252yxj.17
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:42:19 -0700 (PDT)
In-Reply-To: <1312455893-14922-23-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Context is now saved dynamically in respective functions whenever and
> whichever registers are modified. This avoid overhead of saving all
> registers context in the runtime callback.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Nice.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh
