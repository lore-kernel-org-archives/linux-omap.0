From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
Date: Thu, 17 Jan 2013 18:51:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046Ab3AQSvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jan 2013 13:51:09 -0500
In-Reply-To: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon

On Thu, 10 Jan 2013, Jon Hunter wrote:

> During the migration to the common clock framework, calls to the
> functions omap2xxx_clkt_vps_late_init() and
> omap2xxx_clkt_vps_check_bootloader_rates() were not preserved for
> OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
> "curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
> following error message to be displayed because the appropriate MPU
> clock frequency (derived from sys_ck_rate) cannot be found.
> 
> "Could not set MPU rate to 4294MHz"

I don't see this message on 2430sdp or n800 with v3.8-rc3, but maybe 
that's due to sys_clk differences.  Do you still see this on v3.8-rc3 
with H4?

Also, there's already a call to omap2xxx_clkt_vps_check_bootloader_rates() 
-- is it necessary to add another one?

	
- Paul
