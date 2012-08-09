From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP: Configuring CONTROL_DEVCONF0 register via DT with pinctrl
Date: Wed, 8 Aug 2012 23:36:13 -0700
Message-ID: <20120809063612.GL11011@atomide.com>
References: <501262B5.1080004@ti.com>
 <20120807111041.GY11011@atomide.com>
 <5022532C.9060804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43195 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2HIGgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 02:36:16 -0400
Content-Disposition: inline
In-Reply-To: <5022532C.9060804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120808 04:53]:
> On 08/07/2012 02:10 PM, Tony Lindgren wrote:
> > You need to also consider that CONTROL_DEVCONF0 has the MMC/SDIO module input
> > clock selection. So pinctrl-single binding would have to be expanded to also
> > support one-bit-per-mux type registers in addition to one-register-per-mux
> > registers. And then this could also be used for the MMC/SDIO module input clock.
> 
> Or if the clock selection for MMC/SDIO also static on a board we can just do
> the mux config once, configuring McBSP1 and MMC/SDIO at the same time?

Although the DEVCONF0 and 1 seem static, at least with pinctrl framework we
can keep it dynamic if needed and we're not relying on buggy bootloaders to
set it up.

Regards,

Tony
