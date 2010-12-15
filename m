From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] OMAP4: hwmod data fixes and update
Date: Tue, 14 Dec 2010 18:07:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141804450.15971@utopia.booyaka.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48820 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab0LOBHb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:07:31 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 10 Dec 2010, Benoit Cousson wrote:

> Here is a small set of OMAP4 hwmod data updates.
> 
> Re-order properly the data that were a little bit shuffled during
> the previous merge window.
> Add the new reset flags introduced in 2.6.37 and that were not
> used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon.
> Fix some missing field in the GPIO OMAP4 hwmod data that I missed
> during the review.
> IVA and DSP are added just to allow the processors device creation
> at boot time and avoid the warnings.
> 
> Thanks to Charu for testing the GPIO / WD_TIMER changes.
> Thanks to Govindraj for testing the UART changes. 
> 
> The series is based on lo/for-next (v2.6.37-rc5-66-ga2814df) and is
> available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data
> 
> Please note that there is a slight dependency with the following patch
> due to the name change of the iva fclk:
> OMAP4: clock data: Add missing DPLL x2 clock node
> https://patchwork.kernel.org/patch/396612/
> 
> Tested on sdp4430 + ES2.0/ES2.1.
> 
> Regards,
> Benoit
>
> 
> Benoit Cousson (5):
>   OMAP4: hwmod data: Fix hwmod entries order
>   OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
>   OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
>   OMAP4: hwmod data: Add IVA and DSP
>   OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk

Thanks, queued for 2.6.38 with some tweaks.  I've replied to the original 
patches with the details.

The current integration tag that contains these patches is 
'integration-2.6.38-20101214-010' available from 
git://git.pwsan.com/linux-integration


- Paul
