From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Thu, 12 Nov 2009 12:16:13 +0000
Message-ID: <20091112121613.GB16661@rakim.wolfsonmicro.main>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
 <20091111154616.GA30354@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41812 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752813AbZKLMQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 07:16:09 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Thu, Nov 12, 2009 at 09:11:58AM +0530, Gupta, Ajay Kumar wrote:

> > > +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> > > +			continue;
> > > +		if (omap->regulator[i]) {
> > > +			if (regulator_is_enabled(omap->regulator[i]))
> > > +				regulator_disable(omap->regulator[i]);
> > > +			regulator_put(omap->regulator[i]);
> > > +		}

> > For robustness I'd drop the first check for MODE_UNKNOWN here - it
> > doesn't add anything.

> MODE_UNKNOWN means that the port is not connected and so no need to check
> the regulator availability.

Sure, currently - the point is that if you're going to check for the
individual allocations anyway then the check doesn't buy you anything.
