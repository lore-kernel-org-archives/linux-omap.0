From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/11] ARM: OMAP3: CM/control: move CM scratchpad save
 to CM driver
Date: Sat, 19 Oct 2013 17:17:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191717250.11676@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48959 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab3JSRRg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:17:36 -0400
In-Reply-To: <1381508141-15244-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code for off-mode currently saves the scratchpad contents for CM
> registers within OMAP control module driver. However, as we are separating
> CM code into its own driver, this must be moved also. This patch adds a
> new API for saving the CM scratchpad contents and uses this from the high
> level scratchpad save function.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.


- Paul
