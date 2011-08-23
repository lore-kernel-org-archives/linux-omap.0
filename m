From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 21/22] gpio/omap: skip operations in runtime callbacks
Date: Tue, 23 Aug 2011 20:11:05 +0530
Message-ID: <4E53BC01.9060202@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-22-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:60870 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab1HWOlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:41:12 -0400
Received: by mail-gy0-f181.google.com with SMTP id 8so172740gyg.12
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:41:11 -0700 (PDT)
In-Reply-To: <1312455893-14922-22-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Most operations within runtime callbacks should be skipped when
> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
> *_gpio_request() and *_gpio_free(). We just need clock enable/disable.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
OK.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
