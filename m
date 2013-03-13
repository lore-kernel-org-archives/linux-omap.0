From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc1
Date: Wed, 13 Mar 2013 10:20:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303131019240.32131@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com> <20130312190030.GB8798@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3CMKUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 06:20:23 -0400
In-Reply-To: <20130312190030.GB8798@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Aaro,

On Tue, 12 Mar 2013, Aaro Koskinen wrote:

> On Tue, Mar 12, 2013 at 04:40:19PM +0000, Paul Walmsley wrote:
> > * 2420N800: powers down 30 seconds after boot
> >   - Presumably due to missing CBUS patches for watchdog control
> >   - http://lkml.org/lkml/2012/9/3/265
> >   - http://marc.info/?l=linux-omap&m=135274739624125&w=2
> >   - http://marc.info/?l=linux-omap&m=135664195831104&w=2
> >   - Should be working in v3.9-rc1 when CONFIG_RETU_WATCHDOG=y ?
> 
> Yes, you need also CONFIG_I2C_CBUS_GPIO and CONFIG_MFD_RETU.

OK thanks, will add that in for the v3.9-rc2 test.

Would it make sense to add those dependencies to the Kconfig file for 
CONFIG_RETU_WATCHDOG?


- Paul
