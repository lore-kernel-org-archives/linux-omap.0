From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Query: MUSB clock management code
Date: Tue, 25 Aug 2009 12:05:04 +0300
Message-ID: <20090825090503.GO25331@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CEF2@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31853 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZHYJH7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 05:07:59 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CEF2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 24, 2009 at 01:09:43PM +0200, ext Gadiyar, Anand wrote:
> Hi all,
> 
> Is there a reason to have a wrapper code around the clock
> enable/disable code in arch/arm/mach-omap2/usb-musb.c?
> Is it not okay for the glue-layer code in
> drivers/usb/musb/omap2430.c to do this?

most likely, not anymore, but we needed that as means not to pass clock
name to musb driver. Once all other users of musb move to clkdev, we can
remove that and use plain clk fw calls.

-- 
balbi
