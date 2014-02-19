From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: AM43x: hwmod data: register spinlock OCP
 interface
Date: Wed, 19 Feb 2014 18:38:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191837340.8777@utopia.booyaka.com>
References: <1389397464-13345-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42574 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbaBSSiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 13:38:04 -0500
In-Reply-To: <1389397464-13345-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Fri, 10 Jan 2014, Suman Anna wrote:

> AM43xx has a spinlock module which is identical to the
> one present on AM33xx. Register the spinlock ocp_if link
> so that the spinlock hwmod and associated omap_device can
> be instantiated, and the runtime pm API could be used by
> the OMAP hwspinlock driver.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued for v3.15.

Please remember to cc the linux-arm-kernel mailing list on all OMAP 
patches.  I've added it to this message.


- Paul
