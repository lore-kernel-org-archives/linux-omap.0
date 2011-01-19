From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for
 function body copying
Date: Wed, 19 Jan 2011 14:09:25 -0800
Message-ID: <20110119220925.GF4957@atomide.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50484 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab1ASWJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 17:09:38 -0500
Content-Disposition: inline
In-Reply-To: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

* Dave Martin <dave.martin@linaro.org> [110114 13:17]:
> In low-level board support code, there is sometimes a need to
> copy a function body to another location at run-time.
> 
> A straightforward call to memcpy doesn't work in Thumb-2,
> because bit 0 of external Thumb function symbols is set to 1,
> indicating that the function is Thumb.  Without corrective
> measures, this will cause an off-by-one copy, and the copy
> may be called using the wrong instruction set.
> 
> This patch adds an fncpy() macro to help with such copies.
> 
> Particular care is needed, because C doesn't guarantee any
> defined behaviour when casting a function pointer to any other
> type.  This has been observed to lead to strange optimisation
> side-effects when doing the arithmetic which is required in
> order to copy/move function bodies correctly in Thumb-2.
> 
> Thanks to Russell King and Nicolas Pitre for their input
> on this patch.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Jean Pihet <j-pihet@ti.com>

Boot tested on osk5912 and n800:

Tested-by: Tony Lindgren <tony@atomide.com>
