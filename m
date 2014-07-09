From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
Date: Wed, 9 Jul 2014 03:50:56 -0700
Message-ID: <20140709105055.GP28884@atomide.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
 <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
 <20140709091232.GJ28884@atomide.com>
 <53BD0C43.1090002@ti.com>
 <20140709100914.GL28884@atomide.com>
 <53BD1AF8.2060609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39092 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaGIKu5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 06:50:57 -0400
Content-Disposition: inline
In-Reply-To: <53BD1AF8.2060609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com

* Keerthy <a0393675@ti.com> [140709 03:39]:
> On Wednesday 09 July 2014 03:39 PM, Tony Lindgren wrote:
> >* Keerthy <a0393675@ti.com> [140709 02:36]:
> >>On Wednesday 09 July 2014 02:42 PM, Tony Lindgren wrote:
> >>>* Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
> >>>>--- a/arch/arm/boot/dts/dra7-evm.dts
> >>>>+++ b/arch/arm/boot/dts/dra7-evm.dts
> >>>>@@ -249,6 +249,7 @@
> >>>>  					regulator-min-microvolt = <1050000>;
> >>>>  					regulator-max-microvolt = <1050000>;
> >>>>  					regulator-boot-on;
> >>>>+					regulator-always-on;
> >>>>  				};
> >>>Is this regulator really always on?
> >>This feeds on to RTC which is a free running clock. So i guess always on is
> >>justified no?
> >Well the dts entries should describe the hardware. If the
> >regulator can be enabled and disabled, we should not claim it's
> >always on.
> 
> From the PMIC perspective every regulator can be enabled and
> disabled. From a Board perspective there are some which need
> to be always on. For Ex: SMPS123 which feeds on to the MPU.

Right, and we already have regulator-boot-on for those. Or are
you seeing some issue with that?

> I guess RTC also needs the supply to be on as long as we want
> the clock to be ticking.

Sure, but if somebody wants shut it off regulator-boot-on is
better from driver point of view.

Regards,

Tony
