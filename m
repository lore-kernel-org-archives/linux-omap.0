From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to voltagedomain
Date: Thu, 24 Mar 2011 23:01:10 +0530
Message-ID: <c3f9612ebb2d3ad7c05bc8f506f0dabb@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-8-git-send-email-khilman@ti.com>	<8989339cfa18407f4caacb718eec831d@mail.gmail.com>
 <87wrjo1uax.fsf@ti.com> <4D8B5B24.40807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35192 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555Ab1CXRbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 13:31:17 -0400
Received: by mail-vx0-f176.google.com with SMTP id 40so275570vxi.35
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 10:31:16 -0700 (PDT)
In-Reply-To: <4D8B5B24.40807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Thursday, March 24, 2011 8:24 PM
> To: Hilman, Kevin
> Cc: Sripathy, Vishwanath; linux-omap@vger.kernel.org; Paul Walmsely
> Subject: Re: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to
> voltagedomain
>
> On 3/24/2011 3:12 PM, Hilman, Kevin wrote:
> > Vishwanath Sripathy<vishwanath.bs@ti.com>  writes:
> >
> >>> -----Original Message-----
> >>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >>> Sent: Thursday, March 24, 2011 5:30 AM
> >>> To: linux-omap@vger.kernel.org
> >>> Cc: Paul Walmsely; Benoit Cousson
> >>> Subject: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to
> >>> voltagedomain
> >>>
> >>> Add a 'bool scalable' flag to the struct powerdomain and set it for
> >>
> >> I suppose you meant "struct voltagedomain".
> >
> > yes
> >
> >> But shouldn't this flag be part of PMIC struct?
> >> Voltage scalability depends on the kind of VDD supply from PMIC. So
> even
> >> if OMAP supports voltage scaling, we may not be able to scale the
> voltage
> >> if PMIC does not support it.
> >
> > That's a good point.  Probably I can drop this flag and just use the
> > existence of the various fields of the voltage domain (pmic, vc, vp,
> > etc.) to determine if the voltdm can scale.
>
> Mmm, the scalability is still a characteristic of the OMAP voltage
> domain. Some are scalable with a supported range of voltage, some are
> not.
Then should we need this flag in both Voltage domain as well as PMIC?
If both are scalable then only voltage can be scaled I suppose.

Vishwa
>
> So that information is relevant in the voltage domain. Then the
> regulator framework will have as well some information about the range
> that should match what OMAP is able to do.
>
> Benoit
