From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 6 Mar 2012 12:14:13 -0800
Message-ID: <20120306201413.GW12083@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <4F562D51.3000607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50174 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030933Ab2CFUOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 15:14:19 -0500
Content-Disposition: inline
In-Reply-To: <4F562D51.3000607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120306 06:57]:
> On 03/03/2012 08:04 PM, Tony Lindgren wrote:
> > Then looks like there's a mismerge with ASoC. And ASoC patch
> > "[PATCH v3 2/3] MFD: twl6040: Convert to i2c driver, and separate
> > it from twl core" that produces another build error.
> > 
> > Looks like we also have a new section warning with ASoC changes:
> > 
> > WARNING: arch/arm/mach-omap2/built-in.o(.text+0x14504): Section mismatch in reference from the function omap4_pmic_init() to th
> > The function omap4_pmic_init() references
> > the (unknown reference) __initdata (unknown).
> > This is often because omap4_pmic_init lacks a __initdata
> > annotation or the annotation of (unknown) is wrong.
> > 
> > Peter, care to look if below is right resolve for the
> > mismerge? Also can you please also fix the new section
> > warning?
> 
> I have sent a revert series (you were on the CC) to Samuel regarding to
> this series going via the MFD tree.
> I have the corrected series waiting for the event Samuel applies the
> reverts on his for-next branch, so we can queue the fixed patches via ASoC.

OK thanks!

Tony
