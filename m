From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/11] ARM: OMAP2: CM/PM: remove direct register accesses
 outside CM code
Date: Sat, 19 Oct 2013 17:12:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191711130.11676@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48930 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab3JSRMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:12:39 -0400
In-Reply-To: <1381508141-15244-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> Users of the CM funtionality should not access the CM registers directly
> by themselves. Thus, added new CM driver APIs for the OMAP2 specific
> functionalities which support the existing direct register accesses, and
> changed the platform code to use these. This is done in preparation
> for moving the CM code into its own individual driver.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.  Not thrilled about returning register bitfields directly 
from these CM functions, but it's incrementally better than what's there.


- Paul
