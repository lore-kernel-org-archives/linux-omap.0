From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/11] ARM: OMAP3: CM/PM: add API for forcing IVA2 clk
 enable/disable
Date: Sat, 19 Oct 2013 17:19:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191719060.11676@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48982 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab3JSRTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:19:47 -0400
In-Reply-To: <1381508141-15244-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM code directly writes to CM register space to enable/disable IVA2
> clock during boot during the IVA2 reset. Direct access shall be avoided,
> thus implement an API call for this, and change the PM core to use this.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Seems like this type of clock forcing needs to be coordinated with the 
clock framework.  Could you please work with Mike to get a decent 
interface implemented for this?


- Paul
