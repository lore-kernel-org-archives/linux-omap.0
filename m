From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if doing so
 would reset an active clockdomain
Date: Wed, 19 Jan 2011 14:33:28 +0530
Message-ID: <91467096ca191cde5a0d8b69ef0fce00@mail.gmail.com>
References: <1295344109-7056-1-git-send-email-tero.kristo@nokia.com>
 <e84561af552e084d0a6c904aabfe46c8@mail.gmail.com> <cff409280dee72a6d3426cc2edf93069@mail.gmail.com>
 <854C6400F5AA6644BA6FE7953F3E769B036776FE@008-AM1MPN1-012.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59029 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752593Ab1ASJDc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 04:03:32 -0500
Received: by bwz14 with SMTP id 14so683410bwz.2
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 01:03:30 -0800 (PST)
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B036776FE@008-AM1MPN1-012.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
> Sent: Wednesday, January 19, 2011 2:09 PM
> To: vishwanath.bs@ti.com; linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; khilman@deeprootsystems.com
> Subject: RE: [PATCH] OMAP3: CPUIdle: prevent CORE from going off if
> doing so would reset an active clockdomain
>
[...]

> >> If some parts of the chip are busy, then how can Core domain
> enter off
> >> state? The necessary condition for Core to enter low power state
> is
> >that
> >> all the clock domains (including DSS, CAM, IVA, USB, PER etc)
> should
> >> have
> >> idled. Doesn't it mean that all the modules have idled and
> asserted
> >> idleack when Core is entering off state?
> >Besides these, Core off should reset the modules which are only in
> Core
> >domain. It should not impact other power domains. Also Core domain
> >modules
> >which are reset will restore their context when Core comes out of
> off
> >mode. So why are you saying that "If those parts of the chip are
> busy,
> >the reset will disrupt them, causing unpredictable and generally
> >undesirable results."?
>
> Core off issues reset to peripheral domains when it wakes up, this
> is somehow (badly) visible in TRM (look for COREDOMAINWKUP_RST.)
> When this reset happens, the peripheral domain shows its reset
> status as being high, but the powerdomain itself has not entered off
> (previous state can be e.g. RET), thus its context will not be
> restored.
>
Now its clear. Reseting other independent clockdomains is
certainly bad from CORE PD OFF to ON behavior .

Please add this additional information to change log.

Regards,
Santosh
