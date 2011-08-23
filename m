From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 10/22] gpio/omap: use level/edge detect reg offsets
Date: Tue, 23 Aug 2011 18:38:25 +0530
Message-ID: <4E53A649.6060106@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37711 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab1HWNId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 09:08:33 -0400
Received: by mail-yi0-f48.google.com with SMTP id 17so77725yib.35
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 06:08:32 -0700 (PDT)
In-Reply-To: <1312455893-14922-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks good.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
