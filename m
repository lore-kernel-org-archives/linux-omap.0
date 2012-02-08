From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/16] ARM: omap: fix oops in
	drivers/video/omap2/dss/dpi.c
Date: Wed, 8 Feb 2012 22:50:12 +0000
Message-ID: <20120208225012.GA25414@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAVQ-0006Gp-Is@rmk-PC.arm.linux.org.uk> <20120208183607.GB29796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50476 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab2BHWuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 17:50:21 -0500
Content-Disposition: inline
In-Reply-To: <20120208183607.GB29796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Wed, Feb 08, 2012 at 10:36:07AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> > When a PMIC is not found, this driver is unable to obtain its
> > 'vdds_dsi_reg' regulator.  Even through its initialization function
> > fails, other code still calls its enable function, which fails to
> > check whether it has this regulator before asking for it to be enabled.
> > 
> > This fixes the oops, however a better fix would be to sort out the
> > upper layers to prevent them calling into a module which failed to
> > initialize.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Tomi can look into fixing this properly for v3.4:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

No, it's a thing for v3.3, because you can still get this oops.

I expect _most_ of these patches will go into v3.3, and anything with
'fix' or 'oops' in especially I want to see in v3.3.
