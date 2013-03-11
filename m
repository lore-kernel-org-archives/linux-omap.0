From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path
 for all CPU power states except off
Date: Mon, 11 Mar 2013 16:39:20 +0530
Message-ID: <513DBB60.3010406@ti.com>
References: <1360745724-30058-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab3CKLHj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 07:07:39 -0400
In-Reply-To: <1360745724-30058-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Wednesday 13 February 2013 02:25 PM, Santosh Shilimkar wrote:
> Current CPU PM code code make use of common cpu_suspend() path for all the
> CPU power states which is not optimal. In fact cpu_suspend() path is needed
> only when we put CPU power domain to off state where the CPU context is lost.
> 
> Update the code accordingly so that the expensive cpu_suspend() path
> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
> 
> The patch has been tested on OMAP4430 and OMAP5430(with few out of tree patches)
> devices for suspend and CPUidle.
> 
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Update changelog to include testing details as suggested
> by Kevin Hilman.
> 
Ping.
It can get into rc's but since it is not strict regression,
and if it has to wait for 3.10 then I can add this one
along with rest of the PM patches posted towards 3.10

Either way, let me know.

Regards,
Santosh
