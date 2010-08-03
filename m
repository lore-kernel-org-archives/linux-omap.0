From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Regression] ads7846.c touchscreen controller driver reports
 wrong X,Y values
Date: Tue, 3 Aug 2010 10:27:57 +0300
Message-ID: <20100803072757.GR12293@atomide.com>
References: <AANLkTinwrfeYybZysJ-hyZC4MCxjtAFSVos6ZOguZ9VE@mail.gmail.com>
 <AANLkTilh7VrS1zZLSmuj-BFYvm34mkF_uwk9B7TpyYYz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49372 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0HCH1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 03:27:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilh7VrS1zZLSmuj-BFYvm34mkF_uwk9B7TpyYYz@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Mickael Chazaux <mickael.chazaux@gmail.com>, linux-omap@vger.kernel.org, Roman Tereshonkov <roman.tereshonkov@nokia.com>

* Steve Sakoman <sakoman@gmail.com> [100710 01:10]:
> On Tue, May 25, 2010 at 8:54 AM, Mickael Chazaux
> <mickael.chazaux@gmail.com> wrote:
> > Hi,
> >
> > I am working on adding the support of an omap3 based board in the
> > kernel. This board uses an ADS7843 touchscreen controller, on the SPI
> > bus. The in-kernel driver (drivers/input/touchscreen/ads7646.c) works
> > fine with the 2.6.33 kernel. When updating to the 2.6.34 kernel the
> > values reported by the driver were garbage. I had to revert this
> > commit [1] to make it work again. Can someone confirm that this driver
> > still works with other OMAP boards?
> >
> > [1] a330ce2001b290c59fe98c37e981683ef0a75fdf
> 
> I can confirm that the above patch also breaks the ADS7846 driver on
> Overo.  Reverting it results in correct operation.

Hmm, does reading the OMAP2_MCSPI_CHCONF0 register have some side effect?

Regards,

Tony
