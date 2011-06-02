From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: PM: omap_device: fix device power domain
 callbacks
Date: Thu, 2 Jun 2011 16:51:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106021649231.26852@utopia.booyaka.com>
References: <1306886694-11092-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49269 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab1FBWvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 18:51:31 -0400
In-Reply-To: <1306886694-11092-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 31 May 2011, Kevin Hilman wrote:

> After commit 4d27e9dcff00a6425d779b065ec8892e4f391661 (PM: Make power
> domain callbacks take precedence over subsystem ones), the power
> domain callbacks need to call the driver callbacks instead of relying
> on the default subsystem (in this case, platform_bus) to handle the
> driver callbacks.
> 
> Validated on 3430/n900, 3530/Overo.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Will be queued in my for_3.0/pm-fixes branch unless there are objections.

Seems reasonable to me, although I'm not the expert here.


- Paul
