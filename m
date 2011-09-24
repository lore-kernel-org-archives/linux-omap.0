From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Sat, 24 Sep 2011 01:59:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109240148180.22872@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-4-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com> <CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2035352623-1316850887=:22872"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1IXH7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 03:59:17 -0400
In-Reply-To: <CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1109240154560.22872@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2035352623-1316850887=:22872
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1109240154561.22872@utopia.booyaka.com>

On Fri, 23 Sep 2011, J, KEERTHY wrote:

> On Fri, Sep 23, 2011 at 11:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> > On Thu, 22 Sep 2011, Keerthy wrote:
> >
> >> diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/mac=
h-omap2/temp_sensor4460_data.c
> >> new file mode 100644
> >> index 0000000..2804615
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
> >
> > Is there some reason why this shouldn't go into drivers/ in some form?
>=20
> This is used by mach-omap2.

Why does something in mach-omap2 need this data?

> >> diff --git a/arch/arm/plat-omap/include/plat/scm.h b/arch/arm/plat-oma=
p/include/plat/scm.h
> >> new file mode 100644
> >> index 0000000..47aa38f
> >> --- /dev/null
> >> +++ b/arch/arm/plat-omap/include/plat/scm.h
> >
> > If this is being used by a driver, then this header file should go into
> > the appropriate drivers/ subdirectory. =A0If it is being used by code i=
n
> > arch/arm/mach-omap2, then please use the existing
> > arch/arm/mach-omap2/control.h instead.
>=20
> The header file has structures used both by drivers/ and mach-omap.
> So kept it in plat-omap.

The point is, if there are structure definitions and macros that are
only needed by code in drivers/, then those should be split off into a
separate file and placed in drivers/.  Similarly, if there are elements of=
=20
this file that are only used in mach-omap2/, then those should go into=20
mach-omap2/control.h.

About the only part off the top of my head that should go into a
plat-omap header file should be the dev_attr structure.  And it's=20
debatable whether this driver even needs a dev_attr, or whether all
this data should just go into an omap4460_scm.c MFD driver that uses
a bunch of common code for the parts that are shared with 4430, etc.
Do you have any views on this issue?


- Paul
--155748971-2035352623-1316850887=:22872--
