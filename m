From: Tony Lindgren <tony@atomide.com>
Subject: Re: Reg pinmux driver for OMAP based SoC- AM335X
Date: Wed, 1 Feb 2012 10:14:07 -0800
Message-ID: <20120201181407.GN9339@atomide.com>
References: <20120127020832.GJ29812@atomide.com>
 <20120127065752.GB32740@S2101-09.ap.freescale.net>
 <20120127170545.GH13504@atomide.com>
 <20120130015607.GA10470@S2101-09.ap.freescale.net>
 <20120130172042.GE9339@atomide.com>
 <20120131013215.GB24681@S2101-09.ap.freescale.net>
 <20120131022906.GH9339@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93176CAC6@DBDE01.ent.ti.com>
 <20120131170511.GI9339@atomide.com>
 <79CD15C6BA57404B839C016229A409A8317BB650@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25116 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab2BASOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 13:14:11 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317BB650@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120201 01:34]:
> On Tue, Jan 31, 2012 at 22:35:11, Tony Lindgren wrote:
> > 
> > The driver I'm working leaves all the data out of kernel, and the driver
> > just knows how to handle a pinmux register instances. 
> 
> Tony,
> 
> Is this hosted or accessible somewhere? Just for reference...

Still few more things to fix before I can post it..

Tony
