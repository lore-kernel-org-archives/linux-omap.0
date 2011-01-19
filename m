From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Wed, 19 Jan 2011 14:03:17 +0530
Message-ID: <ee1da1d18ec015522469772b211af181@mail.gmail.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com>
 <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com> <854C6400F5AA6644BA6FE7953F3E769B03676325@008-AM1MPN1-012.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33908 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753069Ab1ASIdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 03:33:19 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so598563bwz.14
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 00:33:19 -0800 (PST)
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B03676325@008-AM1MPN1-012.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
> Sent: Wednesday, January 19, 2011 1:52 PM
> To: vishwanath.bs@ti.com; linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com
> Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
> doing so would reset an active clockdomain
>
>
>
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >owner@vger.kernel.org] On Behalf Of ext Vishwanath Sripathy
> >Sent: 19 January, 2011 06:39
> >To: Kristo Tero (Nokia-MS/Tampere); linux-omap@vger.kernel.org
> >Cc: Paul Walmsley; Kevin Hilman
> >Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
> >doing so would reset an active clockdomain
> >
> >Tero,
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Tero Kristo
> >> Sent: Tuesday, January 18, 2011 3:18 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Paul Walmsley; Kevin Hilman
> >> Subject: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
> doing
> >> so would reset an active clockdomain
> >>
> >> On OMAP3 SoCs, if the CORE powerdomain enters off-mode, many
> other
> >> parts of the chip will be reset.  If those parts of the chip are
> busy,
> >> the reset will disrupt them, causing unpredictable and generally
> >> undesirable results.
> >If some parts of the chip are busy, then how can Core domain enter
> off
> >state? The necessary condition for Core to enter low power state is
> that
> >all the clock domains (including DSS, CAM, IVA, USB, PER etc)
> should
> >have
> >idled. Doesn't it mean that all the modules have idled and asserted
> >idleack when Core is entering off state?
>
> This can happen e.g. when some powerdomain has entered RET state. We
> have faced this issue at least with IVA2 because it has its own
> power management.
>
IVA2 PD managed directly instead of linux side PM frameworks is one
problem. If the IVA2 hits retention, and if there is no dependency
on core PD, it should be still fine for core to enter OFF. I hope
it's not the case where some modules from CORE PD are used by IVA
side software ( may be SDMA, GPIO etc) and as part of CORE OFF
you loose context of these which leads to the issue.

Regards,
Santosh
