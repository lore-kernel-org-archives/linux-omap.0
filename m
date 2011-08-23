From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 19/22] gpio/omap: optimize suspend and resume functions
Date: Tue, 23 Aug 2011 20:05:59 +0530
Message-ID: <4E53BACF.1040408@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-20-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:35154 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752070Ab1HWOgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:36:06 -0400
Received: by mail-gx0-f175.google.com with SMTP id 3so162160gxk.34
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 07:36:05 -0700 (PDT)
In-Reply-To: <1312455893-14922-20-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> There is no need to operate on all the banks every time the function is called.
> Just operate on the current bank passed by the framework.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
