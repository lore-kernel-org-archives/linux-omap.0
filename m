From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Sat, 27 Oct 2012 02:52:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210270251460.27071@utopia.booyaka.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com> <1350552010-28760-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41457 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292Ab2J0CwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 22:52:14 -0400
In-Reply-To: <1350552010-28760-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hi

On Thu, 18 Oct 2012, Tero Kristo wrote:

> Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
> PHY functions for OMAP4, but this causes a problem with core retention
> as the MUSB module remains enabled if omap-usb2 phy driver is not used.
> This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.
> 
> Fixed by adding a minimal function back that disables the USB PHY in
> case omap-usb2 driver is not used.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Looks like another one for Tony...

- Paul
