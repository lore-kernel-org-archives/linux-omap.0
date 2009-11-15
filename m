From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Sun, 15 Nov 2009 12:59:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702B243@dbde02.ent.ti.com>
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
 <20091113125520.GA21516@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52004 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbZKOH3L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 02:29:11 -0500
In-Reply-To: <20091113125520.GA21516@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, November 13, 2009 6:25 PM
> To: Gupta, Ajay Kumar
> Cc: Gadiyar, Anand; felipe.balbi@nokia.com; linux-omap@vger.kernel.org;
> Aggarwal, Anuj
> Subject: Re: Query: Regulator framework in EHCI driver
> 
> On Fri, Nov 13, 2009 at 09:52:14AM +0530, Gupta, Ajay Kumar wrote:
> 
> > +		snprintf(supply, 7, "hsusb%d", i);
> 
> It'd be better to use sizeof() rather than a hard coded 7 here.

Ok fine.
> 
> > +             omap->regulator[i] = regulator_get(omap->dev, supply);
> 
> Looking at your code this needs to be regulator_get_exclusive() - you
> conditinoally disable the regulator when unregistering depending on if
> it reports as enabled but if the supply is shared then it can be enabled
> without this driver having done so.
> 
> Alternatively, make the regulator_disable() in the shutdown path
> unconditional.

Ok, I will take this change and submit this patch.

Thanks,
Ajay

