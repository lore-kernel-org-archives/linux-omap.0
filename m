From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
Date: Thu, 5 Mar 2015 18:16:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40001 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964814AbbCESQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 13:16:35 -0500
In-Reply-To: <1425561211-31003-2-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, KEERTHY <j-keerthy@ti.com>

On Thu, 5 Mar 2015, Dave Gerlach wrote:

> Introduce a dt property, ti,no-init, that prevents hwmod initialization.
> Even if a dt node is marked as disabled, hwmod still at least enables
> the hwmod and programs the sysconfig before attempting to idle it at
> boot. If an IP has been disabled by the hardware configuration on a
> platform, this will cause a hang due to writing to inactive registers.
> This property prevents that from happening by marking the hwmod as
> _HWMOD_STATE_DISABLED during init.

I'm kind of wondering if hwmod should even touch a device if it's marked 
as disabled in the DT.  Tony, what do you think?


- Paul
