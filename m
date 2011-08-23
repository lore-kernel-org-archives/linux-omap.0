From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 17/22] gpio/omap: fix bankwidth for OMAP7xx MPUIO
Date: Tue, 23 Aug 2011 19:58:42 +0530
Message-ID: <4E53B91A.1070509@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-18-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57606 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294Ab1HWO2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:28:52 -0400
Received: by mail-yi0-f51.google.com with SMTP id 12so122483yib.38
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:28:50 -0700 (PDT)
In-Reply-To: <1312455893-14922-18-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> In all OMAP1 SoCs, the MPUIO bank width is 16 bits. But, in OMAP7xx,
> it is wrongly initialised to 32. Fix this.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks like a proper BUG fix.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
