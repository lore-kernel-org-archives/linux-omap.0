From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 13:39:23 +0000
Message-ID: <20091104133922.GD25044@sirena.org.uk>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com> <20091103153046.GA30320@nokia.com> <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56213 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZKDNjT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 08:39:19 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Wed, Nov 04, 2009 at 06:02:48PM +0530, Gupta, Ajay Kumar wrote:

> > You should be able to regulator_get() the 1v8 supply and
> > regulator_enable() it. The regulator was already setup in twl4030-core.c
> > so that should work just fine. 

> I can do regulator_get() and regulator_enable() but where ? Are you referring to board file?

> I was thinking of doing it in a generic form within EHCI driver (ehci-omap.c).

Do it in the EHCI driver.  The EHCI driver should just unconditionally
use the regulators, the regulator API will be compiled out if support is
disabled in Kconfig.
