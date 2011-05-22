From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Sun, 22 May 2011 23:40:37 +0200
Message-ID: <20110522214036.GO18610@sortiz-mobl>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
 <1304687833-4578-5-git-send-email-leslyam@ti.com>
 <20110513183958.GY8970@sortiz-mobl>
 <BANLkTi=c9naYFuuRbNG8FK6WuKWVBp0DKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2418 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab1EVVkl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 May 2011 17:40:41 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=c9naYFuuRbNG8FK6WuKWVBp0DKg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>

Hi Lesly,

On Tue, May 17, 2011 at 07:10:03PM +0530, Manuel, Lesly Arackal wrote:
> Hi Samuel,
>=20
> On Sat, May 14, 2011 at 12:09 AM, Samuel Ortiz <sameo@linux.intel.com=
> wrote:
> > Hi Lesly,
> >
> > On Fri, May 06, 2011 at 06:47:10PM +0530, Lesly A M wrote:
> >> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_=
reset.
> >>
> >> TWL4030 power scripts which can be used by different OMAP3 boards
> >> with the power companion chip (TWL4030 series).
> >>
> >> The twl4030 generic script can be used by any board file to update
> >> the power data in twl4030_platform_data.
> >>
> >> Since the TWL4030 power script has dependency with APIs in twl4030=
-power.c
> >> removing the __init for these APIs.
> >>
> >> For more information please see:
> >> =A0 =A0 =A0 http://omapedia.org/wiki/TWL4030_power_scripts
> > I understand you guys are trying to keep the arch/arm stats to a sa=
ne level,
> > but I don't see why this driver should be under drivers/mfd/. I'm u=
sually
> > flexible about what goes into drivers/mfd, but this one seems out o=
f context
> > to me.
>=20
> Since this script driver file contains the changes for PM IC (TWL4030=
 series),
> which is a Multifunction devices with GPIOs, USB, audio,
> current regulators, power management chip, ...
>=20
> This script driver file contains the pm bus message sequence which wi=
ll be
> programmed in the scratch memory of the PM IC, and some resource conf=
iguration
> data for PM IC resources.
>=20
> This change was suggested by Tony for the last version of this patch =
series.
I understand, but I'm trying to get the "let's push everything that som=
ehow
linked to our MFD driver to drivers/mfd/" crazyness down to a sane leve=
l.
This one doesn't look like it should be part of drivers/mfd.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
