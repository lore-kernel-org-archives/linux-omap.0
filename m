From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
Date: Mon, 14 Jul 2014 09:23:24 -0700
Message-ID: <20140714162324.GF20068@atomide.com>
References: <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
 <20140709091232.GJ28884@atomide.com>
 <53BD0C43.1090002@ti.com>
 <20140709100914.GL28884@atomide.com>
 <53BD1AF8.2060609@ti.com>
 <20140709105055.GP28884@atomide.com>
 <53BD1FC3.6050500@ti.com>
 <20140709110051.GQ28884@atomide.com>
 <53BD2249.2080808@ti.com>
 <53C3ED02.7020206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42427 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970AbaGNQYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 12:24:50 -0400
Content-Disposition: inline
In-Reply-To: <53C3ED02.7020206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Keerthy <a0393675@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [140714 07:47]:
> Hi Tony,
> On Wednesday 09 July 2014 04:36 PM, Keerthy wrote:
> > On Wednesday 09 July 2014 04:30 PM, Tony Lindgren wrote:
> >> * Keerthy <a0393675@ti.com> [140709 03:59]:
> >>> On Wednesday 09 July 2014 04:20 PM, Tony Lindgren wrote:
> >>>> * Keerthy <a0393675@ti.com> [140709 03:39]:
> >>>>> On Wednesday 09 July 2014 03:39 PM, Tony Lindgren wrote:
> >>>>>> * Keerthy <a0393675@ti.com> [140709 02:36]:
> >>>>>>> On Wednesday 09 July 2014 02:42 PM, Tony Lindgren wrote:
> >>>>>>>> * Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
> >>>>>>>>> --- a/arch/arm/boot/dts/dra7-evm.dts
> >>>>>>>>> +++ b/arch/arm/boot/dts/dra7-evm.dts
> >>>>>>>>> @@ -249,6 +249,7 @@
> >>>>>>>>>                       regulator-min-microvolt = <1050000>;
> >>>>>>>>>                       regulator-max-microvolt = <1050000>;
> >>>>>>>>>                       regulator-boot-on;
> >>>>>>>>> +                    regulator-always-on;
> >>>>>>>>>                   };
> >>>>>>>> Is this regulator really always on?
> >>>>>>> This feeds on to RTC which is a free running clock. So i guess always on is
> >>>>>>> justified no?
> >>>>>> Well the dts entries should describe the hardware. If the
> >>>>>> regulator can be enabled and disabled, we should not claim it's
> >>>>>> always on.
> >>>>>  From the PMIC perspective every regulator can be enabled and
> >>>>> disabled. From a Board perspective there are some which need
> >>>>> to be always on. For Ex: SMPS123 which feeds on to the MPU.
> >>>> Right, and we already have regulator-boot-on for those. Or are
> >>>> you seeing some issue with that?
> >>> regulator-boot-on describes that at boot a particular regulator is on.
> >>> It does not guarantee that it will be on for the rest of the time. The
> >>> regulator framework can go ahead and disable it if no one has requested
> >>> for it. In case of RTC we do not want that to happen.
> >> That's a bug in the RTC driver then. The driver should request a
> >> regulator if it's specified.
> 
> In my experiments I observed that when RTC regulator is switched
> off and switched on, there is an abort while accessing RTC registers.

Right, then you know you have the right regulator :)

> After discussing with hardware team, it is confirmed that this
> LDO9 regulator powering RTC cannot be turned off when
> SoC is active and expected to be always on.

Hmm but sounds like you already proved it can be idled? So
the regulator really should be managed by the driver?

Regards,

Tony
