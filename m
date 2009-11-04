From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 14:56:26 +0000
Message-ID: <20091104145626.GC30644@rakim.wolfsonmicro.main>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
 <20091103153046.GA30320@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
 <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46424 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756128AbZKDO4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 09:56:22 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

On Wed, Nov 04, 2009 at 08:20:46PM +0530, Gadiyar, Anand wrote:

> I meant: for the same driver (say EHCI in this case) on two different
> boards, if one of them needs a particular regulator (say the 1v8 from TWL4030)
> and the other needs none at all (but needs the regulator API in general for
> other devices on the board), then what would happen?

Like I say, if the kernel is built with regulator support then a fixed
voltage regulator should be defined representing the supply if it is
provided by a fixed voltage regulator - if the supply is essential to
the correct operation of the device this will reflect the actual
hardware.

If the supply is genuinely optional and need not be connected for
correct operation of the device then the consumer driver should
gracefully handle failure to acquire the regulator, for example by
disabling functionality that depends on the additional supply, but this
is relatively unusual.
