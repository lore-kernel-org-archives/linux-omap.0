From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Thu, 5 Nov 2009 16:55:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
References: <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbZKEL0B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 06:26:01 -0500
In-Reply-To: <20091105111955.GA23505@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

> On Thu, Nov 05, 2009 at 04:01:24PM +0530, Gadiyar, Anand wrote:
> 
> > How do you add a fixed voltage regulator for a board which 
> doesn't really
> > have a controllable regulator for that voltage? (the PHY 
> supply is wired
> > directly from the main board power-supply, no GPIO for 
> on-off control)
> 
> > Maybe a dummy regulator would be useful?
> 
> Like drivers/regulator/fixed.c?
> 
> 

Exactly. Thanks!

(I'm stupid. I should read the code first)
