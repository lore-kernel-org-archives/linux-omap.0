From: "Singh, Vimal" <vimalsingh@ti.com>
Subject: RE: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Tue, 7 Oct 2008 10:58:43 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DC1012FA@dbde02.ent.ti.com>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com>
 <48232.192.168.10.89.1221127616.squirrel@dbdmail.itg.ti.com>
 <20081006112039.GF2806@atomide.com>,<200810060937.13668.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47015 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbYJGF25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 01:28:57 -0400
In-Reply-To: <200810060937.13668.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Modday 06 October 2008, Devid Brownell wrote:
> On Monday 06 October 2008, Tony Lindgren wrote:
> > > --- linux-omap-2.6_27_08_2008.orig/include/linux/mtd/nand.h
> > > +++ linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h
> > > @@ -45,7 +45,7 @@
> > >   */
> > >  #define NAND_MAX_OOBSIZE     64
> > >  #define NAND_MAX_PAGESIZE    2048
> > > -
> > > +#define NAND_BLOCK_SIZE              SZ_128K
> > >  /*
> 
> This is specific to 3430 SDP though ... there are plenty
> of other NAND block sizes in the world.
> 
> Suggest moving this definition to board-3430sdp-flash.c
> where it's relevant.

Agree. I will send a patch to move it.

...
vimal