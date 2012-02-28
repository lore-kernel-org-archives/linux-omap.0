From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP4: dma: Correct CPU version check for
 dma_common_ch_end
Date: Tue, 28 Feb 2012 14:37:44 -0800
Message-ID: <20120228223744.GF18901@atomide.com>
References: <1329983081-9494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:35963 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965907Ab2B1Whr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 17:37:47 -0500
Content-Disposition: inline
In-Reply-To: <1329983081-9494-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120222 23:13]:
> CCDN is the last common channel register in all OMAP4 versions. Use
> cpu_is_omap44xx() instead of the cpu_is_omap4430().
> cpu_is_omap4430() returns 0 unconditionally. This causes that the
> dma_common_ch_end register variable is not configured correctly on OMAP4, not
> even for OMAP4430.
> Because of this, registers between CCFN - CCDN will be not cleard in the
> omap2_clear_dma function in OMAP4.

Thanks applying into fixes-non-critical as discussed for the earlier
version of this patch.

Regards,

Tony
