From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 14/22] gpio/omap: use pinctrl offset instead of macro
Date: Tue, 23 Aug 2011 18:57:26 +0530
Message-ID: <4E53AABE.8070603@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-15-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56503 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab1HWN1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 09:27:37 -0400
Received: by gyd10 with SMTP id 10so83497gyd.41
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 06:27:33 -0700 (PDT)
In-Reply-To: <1312455893-14922-15-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Use regs->pinctrl field instead of using the macro OMAP1510_GPIO_PIN_CONTROL
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Ok.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
