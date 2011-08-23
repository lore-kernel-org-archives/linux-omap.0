From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 16/22] gpio/omap: remove bank->method & METHOD_* macros
Date: Tue, 23 Aug 2011 19:57:10 +0530
Message-ID: <4E53B8BE.9030007@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-17-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50181 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753493Ab1HWO1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:27:18 -0400
Received: by mail-yx0-f176.google.com with SMTP id 4so137055yxp.7
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:27:16 -0700 (PDT)
In-Reply-To: <1312455893-14922-17-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
> need to be handled separately. Identify the same using a flag and remove all
> METHOD_* macros.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
