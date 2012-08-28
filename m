From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Tue, 28 Aug 2012 10:21:33 -0700
Message-ID: <20120828172133.GH4534@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
 <20120723133400.GU4435@opensource.wolfsonmicro.com>
 <20120828112603.GC25786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51855 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928Ab2H1RVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 13:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20120828112603.GC25786@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 28, 2012 at 12:26:07PM +0100, Lee Jones wrote:

> > > arch/arm/boot/dts/db8500.dtsi

> > I'm not actually seeing anything terribly problematic here, though the
> > regulator-name properties should really be removed as they're fairly
> > useless and seem to be missing the point of having the property.

> Just looking at this now. 

> The regulator-name property is used to populate constrains->name. Are
> you sure you still want them all removed?

Yes, of course.  There's no way that a generic .dtsi used for any
possible board could come up with a sensible value.
