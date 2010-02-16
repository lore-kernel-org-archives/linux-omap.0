From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Tue, 16 Feb 2010 20:35:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF809B@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1002121449440.28188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43339 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab0BPPGB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:06:01 -0500
In-Reply-To: <alpine.DEB.2.00.1002121449440.28188@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Saturday, February 13, 2010 3:20 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
> tony@atomide.com; Nayak, Rajendra
> Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
> 
> On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> 
> > This patch series makes the OMAP3430 GPIO module
> > use hwmod framework.
> >
> > This patch series applies on top of pm branch
> > and it requires my previous patch set which converts
> > GPIO into an early init device.
> >
> > They are boot tested on SDP 3430 and compile tested
> > for OMAP 2420 and 2430.
> >
> > Charulatha V (2):
> >   OMAP3: hwmod: add GPIO hwmods for OMAP3430
> >   OMAP3: hwmod: Adapt HWMOD FW for GPIO OMAP3430
> >
> >  arch/arm/mach-omap2/gpio.c             |  901 ++++---------------------
> -------
> >  arch/arm/mach-omap2/omap_hwmod_34xx.h  |  410 +++++++++++++++
> >  arch/arm/plat-omap/include/plat/gpio.h |   25 +-
> 
> NAK.  Your series just broke GPIO for all non-OMAP3430 chips.

Paul,

This patch series is only RFC as the changes are huge. 
I would like to get comments for the approach taken for HWMOD implementation for GPIO.  After aligning with everyone, I would extend my patches to support non-OMAP3430 chips too.

-Charulatha

> 
> 
> - Paul
