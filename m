From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators when cable unplugged
Date: Tue, 10 Feb 2009 11:52:59 -0800
Message-ID: <200902101152.59526.david-b@pacbell.net>
References: <200902081053.00255.david-b@pacbell.net> <1234274767.17391.20.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:38534 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754384AbZBJTxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Feb 2009 14:53:03 -0500
In-Reply-To: <1234274767.17391.20.camel@ubuntu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>, linux-usb@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

On Tuesday 10 February 2009, Kalle Jokiniemi wrote:
> > This patch disables LDO regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > when the USB cable is unplugged, to eliminate that source of power
> > waste.  (Enabled LDOs consume power at all times.)
> 
> Please put this on hold for a while. This won't work if we don't have
> TWL regulator support enabled.

So Kconfig should have TWL4030_USB depend on REGULATOR_TWL4030?


> Also it's missing error value checking. 

You mean like in the ldo_init() stuff?  Fair enough.

- Dave


> I'll post new patch(es) soon.
> 

