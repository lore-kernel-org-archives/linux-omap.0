From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Sat, 24 Sep 2011 01:48:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109240141310.22872@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-4-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com> <CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-640198813-1316850494=:22872"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34179 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1IXHsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 03:48:15 -0400
In-Reply-To: <CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-640198813-1316850494=:22872
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Sep 2011, J, KEERTHY wrote:

> On Fri, Sep 23, 2011 at 11:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > On Thu, 22 Sep 2011, Keerthy wrote:
> >
> >> @@ -0,0 +1,175 @@
> >> +/*
> >> + * OMAP system control module header file
> >> + *
> >> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.=
com/
> >> + * Author: J Keerthy <j-keerthy@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License
> >> + * version 2 as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, bu=
t
> >> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GN=
U
> >> + * General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> + * 02110-1301 USA
> >> + *
> >> + */
> >> +
> >> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> >> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> >
> > You're also missing important #includes here for things like mutexes
> > and kernel types that you use later on in the file.
>=20
> Those header files are included in c files.

And how does that affect my comment?

> >> +#define OMAP_ADC_START_VALUE =A0 =A0530
> >> +#define OMAP_ADC_END_VALUE =A0 =A0 =A0923
> >
> > Are these OMAP4460, OMAP4xxx, or OMAP2+ specific?
>=20
> OMAP4460. I will pass even these values through pdata
> since they differ from platform to platform.

So then the macro names need to include "OMAP4460" or whatever SoC
they are first valid for.

> >> +
> >> +/**
> >> + * struct omap4460plus_scm_dev_attr - device attributes for scm
> >
> > There are loads of references to 'omap4460plus' when it seems to me tha=
t
> > much of this driver should also apply to OMAP4430 also. =A0Shouldn't th=
is
> > driver be named something like 'omap4430plus_scm' or even
> > better 'omap4_scm' ?
>=20
> This is used by hwmod. Hence keeping it in the header file.

Did you even read my comment before responding?


- Paul
--155748971-640198813-1316850494=:22872--
