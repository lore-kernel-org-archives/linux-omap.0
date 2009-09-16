From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] EHCI USB: Don't use generic shutdown function
Date: Wed, 16 Sep 2009 09:39:37 +0300
Message-ID: <20090916063937.GR10345@nokia.com>
References: <20090916001055.GA2449@lixom.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:29508 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbZIPGl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Sep 2009 02:41:58 -0400
Content-Disposition: inline
In-Reply-To: <20090916001055.GA2449@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Olof Johansson <olof@lixom.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>

On Wed, Sep 16, 2009 at 02:10:55AM +0200, ext Olof Johansson wrote:
> The OMAP EHCI glue code has a layer of driver state struct between
> the platform_device and usb_hcd. So it can't use the generic
> usb_hcd_platform_shutdown.
> 
> This fixes a panic at reboot time.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi
