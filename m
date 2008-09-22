From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Mon, 22 Sep 2008 18:32:14 +0300
Message-ID: <20080922153214.GY24627@gandalf.research.nokia.com>
References: <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo> <20080912193534.GH7132@frodo> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080922151711.GW24627@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA391@dbde02.ent.ti.com> <20080922152644.GX24627@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA396@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51932 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYIVPcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 11:32:48 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA396@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 22, 2008 at 09:00:26PM +0530, ext Gadiyar, Anand wrote:
> Yes, it was related to DPLL5 I think. But with your patches plus that one
> section of code commented out, EHCI was still working. So nothing broken yet.

Cool, so let's wait a bit more for clock updates, then we apply those,
maybe that's the way to go. I'm also waiting the virtual clock
structures so we can clean up the clock handling on the ehci driver.

After that the driver could possibly be sent to mainline for
integration.

-- 
balbi
