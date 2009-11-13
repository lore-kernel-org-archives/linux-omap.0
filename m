From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Fri, 13 Nov 2009 12:55:20 +0000
Message-ID: <20091113125520.GA21516@rakim.wolfsonmicro.main>
References: <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
 <20091111154616.GA30354@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
 <20091112121613.GB16661@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E7394043702AFF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50002 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752447AbZKMMzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Nov 2009 07:55:16 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394043702AFF5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Fri, Nov 13, 2009 at 09:52:14AM +0530, Gupta, Ajay Kumar wrote:

> +		snprintf(supply, 7, "hsusb%d", i);

It'd be better to use sizeof() rather than a hard coded 7 here.

> +             omap->regulator[i] = regulator_get(omap->dev, supply);

Looking at your code this needs to be regulator_get_exclusive() - you
conditinoally disable the regulator when unregistering depending on if
it reports as enabled but if the supply is shared then it can be enabled
without this driver having done so.

Alternatively, make the regulator_disable() in the shutdown path
unconditional.
