From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
 database
Date: Thu, 23 Sep 2010 11:50:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032963EC02@dbde02.ent.ti.com>
References: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
 <87mxr98nkg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36818 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab0IWGUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 02:20:11 -0400
In-Reply-To: <87mxr98nkg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

> >
> > Why not these defines in mach-omap2/dmtimer.c? since register offsets
> are
> > same for omap2plus except omap4 which has additional register offsets.
> Same
> > register offsets are getting repeated in all the omap2plus hwmod
> database.
> 
> I agree with Manjunath.
> 
> > As kevin suggested for DMA hwmod, i2c driver is already using these
> defines
> > in .c file even though register offsets are different within omap2plus
> processors.
> > through dev structure.
> >
> > Can we have similar kind of usage for all upcoming driver hwmod
> adaptations?
> 
> Yes please.
> 
> hwmod is not the place for register definitions, specially when OMAP4 is
> the only difference.

I can move it to its original place in mach-omap2.
The reason for re-location was if OMAP 5 and later version had different mappings we had to keep on adding new table in mach-omap2 in addition to applying sort if() checks for the different platforms.

-tarun
