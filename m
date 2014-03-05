From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/18] ARM: OMAP2+: CM/PRM cleanup set
Date: Wed, 5 Mar 2014 09:36:39 -0800
Message-ID: <20140305173638.GG4983@atomide.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59346 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752430AbaCERgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 12:36:47 -0500
Content-Disposition: inline
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140304 08:22]:
> Hi,
> 
> This set cleans up the CM/PRM codebase a bit, removing the need for direct
> CM/PRM register access macros outside CM/PRM drivers. This is done in
> preparation to isolate these drivers into its own driver directory.
> Currently my plan is to create a single PRCM driver, which will contain
> both, and as such, CM/PRM inter-access is not removed in this set.
> 
> This set is built on top of the OMAP2 DT clock conversion set, but most
> of the patches can also be standalone if need be.
> 
> Testing done:
> - omap2 : none (any feedback welcome)

Seems to boot just fine on n8x0 and 2430sdp.

> - omap3-beagle : boot, suspend-resume (RET), suspend-resume (OFF)

Also tested that off-idle keeps working.

> - omap4-panda-es : boot, suspend-resume (RET)
> 
> Branch also available here:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.14-rc4-cm-prm-cleanup

It seems that it's probably best that Paul queues or acks these once
the dependencies are out of the way.

Regards,

Tony
