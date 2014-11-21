From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] drivers: bus: Move omap gpmc code to live under
 drivers
Date: Fri, 21 Nov 2014 09:18:04 -0800
Message-ID: <20141121171804.GU7046@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-4-git-send-email-tony@atomide.com>
 <546EF266.1010901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34558 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbaKURSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 12:18:16 -0500
Content-Disposition: inline
In-Reply-To: <546EF266.1010901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>

* Lokesh Vutla <lokeshvutla@ti.com> [141121 00:09]:
> On Friday 21 November 2014 03:58 AM, Tony Lindgren wrote:
> > --- a/drivers/bus/Makefile
> > +++ b/drivers/bus/Makefile
> > @@ -5,7 +5,8 @@
> >  obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
> >  obj-$(CONFIG_IMX_WEIM)	+= imx-weim.o
> >  obj-$(CONFIG_MVEBU_MBUS) += mvebu-mbus.o
> > -obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
>
> I guess this is unrelated to $subject. Shouldn't this be dropped?

Yes thanks for catching that.

Regards,

Tony
