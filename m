From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io
 is done
Date: Fri, 07 Oct 2011 12:17:53 +0530
Message-ID: <4E8EA099.5020906@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004542.26980.98554.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35820 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754134Ab1JGGr6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 02:47:58 -0400
Received: by mail-yw0-f46.google.com with SMTP id 5so4503623ywb.33
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 23:47:58 -0700 (PDT)
In-Reply-To: <20111005004542.26980.98554.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wednesday 05 October 2011 06:15 AM, Tony Lindgren wrote:
> This way we don't need to initialize SoC detection early
> and can start using generic map_io.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
