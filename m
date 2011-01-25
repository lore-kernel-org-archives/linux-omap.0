From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC driver
Date: Tue, 25 Jan 2011 16:54:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101251654290.16671@utopia.booyaka.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-3-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42037 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1AYXy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 18:54:57 -0500
In-Reply-To: <1295992862-6154-3-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 25 Jan 2011, David Lambert wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> Adds HWMOD entries for the OMAP DMIC driver and creates
> a platform device.  The HWMOD entires define the system
> resource requirements for the drvier such as DMA addresses, channels,
> and IRQ's.  Placing this information in the HWMOD database allows
> for more generic drivers to be written and having the specific
> implementation details defined in HWMOD.
> 
> Signed-off-by: David Lambert <dlambert@ti.com>

This should have Benoit's Signed-off-by: also.


- Paul
