From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Wed, 10 Sep 2008 07:08:27 +0300 (EEST)
Message-ID: <20080910.070827.145357958.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A534486D6A4@dlee03.ent.ti.com>
	<20080829.080313.110221229.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63303 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYIJEIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 00:08:46 -0400
In-Reply-To: <20080829.080313.110221229.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, tony@atomide.com
Cc: linux-omap@vger.kernel.org, x00omar@ti.com, h-kanigeri2@ti.com

Hi,

Although this TI bridge patches are not integrated and a bit
independent S/W component, it would be nice to get some comments just
on this bridge header file location from kernel maintainer's
perspective.

"arch/arm/plat-omap/include/mach/bridge"
  or "arch/arm/plat-omap/include/bridge"?

	 Hiroshi DOYU

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
Date: Fri, 29 Aug 2008 08:03:13 +0300 (EEST)

> Hi Omar,
> 
> I just noticed that the bridge specific header files are located
> under "linux/arch/arm/plat-omap/include/mach/bridge/", but it may be
> better to have them under "arch/arm/plat-omap/include/bridge/" because
> those header files are not related to the omap archtecture so much and
> mostly used for bridge specific purpose, although omap is the only
> platform to have bridge with dsp;) For me, it would make more sense
> logically, and also practically grepp'ing would work more nicely
> without any fancy tools like specifiying the directories to search.
> 
> Any comments?
> 
> 	Hiroshi DOYU
> 
> From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
> Subject: [PATCH 2/3][OMAP 3/4]table end for wcd command definitions
> Date: Thu, 28 Aug 2008 20:30:44 -0500
> 
> > Added the table end 'CMD_BASE_END_OFFSET' define in wcdioctl.h
> > 
> > Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
> > ---
> > 
> > Index: omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h
> > ===================================================================
> > --- omapkernel.orig/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:03:10.000000000 -0500
> > +++ omapkernel/arch/arm/plat-omap/include/mach/bridge/wcdioctl.h	2008-08-22 19:20:05.000000000 -0500
> > @@ -515,4 +515,5 @@
> >  #define CMD_CMM_GETINFO_OFFSET	  (CMD_CMM_BASE_OFFSET + 3)
> >  #define CMD_CMM_END_OFFSET	      CMD_CMM_GETINFO_OFFSET
> >  
> > +#define CMD_BASE_END_OFFSET	CMD_CMM_END_OFFSET
> >  #endif				/* WCDIOCTL_ */
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
