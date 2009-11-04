From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 20:20:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
 <20091103153046.GA30320@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
 <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50605 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbZKDOuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 09:50:52 -0500
In-Reply-To: <20091104144811.GB30644@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Mark Brown:
> On Wed, Nov 04, 2009 at 08:15:02PM +0530, Gadiyar, Anand wrote:
> 
> > So, if a board does not need a regulator at all, then the APIs do nothing?
> 
> If the kernel is built without regulator API support then the get,
> release, enable and disable functions are stubbed out to always report
> success.  If the kernel has been built with regulator support then
> generally a fixed voltage regulator should be defined by the board.  The
> expectation is that if the regulator API is of no use on a board since
> there are no regulators set up then it'll be disabled in Kconfig.
> 

I meant: for the same driver (say EHCI in this case) on two different
boards, if one of them needs a particular regulator (say the 1v8 from TWL4030)
and the other needs none at all (but needs the regulator API in general for
other devices on the board), then what would happen?
