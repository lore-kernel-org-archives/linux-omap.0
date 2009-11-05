From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Thu, 5 Nov 2009 11:41:34 +0200
Message-ID: <20091105094134.GB3045@nokia.com>
References: <20091103153046.GA30320@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
 <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47841 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZKEJmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 04:42:50 -0500
Content-Disposition: inline
In-Reply-To: <20091105093641.GA21779@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,

On Thu, Nov 05, 2009 at 10:36:41AM +0100, ext Mark Brown wrote:
> On Thu, Nov 05, 2009 at 08:54:02AM +0530, Gupta, Ajay Kumar wrote:
> 
> > I think we can add a check for supply name in EHCI driver, if its
> valid then we will call regulator_get()/enable() but if it's NULL then
> don't do anything.
> > 
> > So the boards which don't use any regulator they can pass a NULL to
> supply name.

I don't know if I'm the only one, but Anand's mails are coming in over
80 chars lines.

> No, this would be a substantial misuse of the regulator API.  The supply
> name should not be being passed through as platform data, the driver
> should request a fixed name (usually the name of the relevant physical
> supply to the chip) and let the API map this onto the actual supply for
> the system.

I agree with Mark here. The best solution would be to provide a fixed
voltage regulator for the other boards.

-- 
balbi
