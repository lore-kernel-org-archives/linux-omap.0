From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 20:00:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
 <20091103153046.GA30320@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
 <20091104133922.GD25044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59501 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756305AbZKDOa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 09:30:58 -0500
In-Reply-To: <20091104133922.GD25044@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Mark Brown wrote:
> On Wed, Nov 04, 2009 at 06:02:48PM +0530, Gupta, Ajay Kumar wrote:
> 
> > > You should be able to regulator_get() the 1v8 supply and
> > > regulator_enable() it. The regulator was already setup in twl4030-core.c
> > > so that should work just fine. 
> 
> > I can do regulator_get() and regulator_enable() but where ? Are you referring to board file?
> 
> > I was thinking of doing it in a generic form within EHCI driver (ehci-omap.c).
> 
> Do it in the EHCI driver.  The EHCI driver should just unconditionally
> use the regulators, the regulator API will be compiled out if support is
> disabled in Kconfig.
> 

NAK to do it unconditionally in the driver. This is board specific.
It just so happens that this is the regulator used on the beagleboard
and EVM, but it could very easily be another one (like on the SDP).

How about a hook from the platform code in mach-omap2/usb-ehci.c instead?
