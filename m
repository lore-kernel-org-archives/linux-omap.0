From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Thu, 03 May 2012 16:46:02 +0530
Message-ID: <4FA268F2.5090301@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com> <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49030 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321Ab2ECLQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 07:16:11 -0400
Received: by obcni5 with SMTP id ni5so2788927obc.41
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 04:16:10 -0700 (PDT)
In-Reply-To: <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> We do checking for bank->enabled_non_wakeup_gpios in order
> to skip redundant operations. Somehow, the check got missed
> while doing the cleanup series.
> 
> Just to make sure that we do context restore correctly in
> *_runtime_resume(), the bank->workaround_enabled check is
> moved after context restore. Otherwise, it would prevent
> context restore when bank->enabled_non_wakeup_gpios is 0.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

