From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: cpufreq support for the Beagleboard.
Date: Tue, 22 Mar 2011 10:39:26 +0530
Message-ID: <0f31e209e69c20b1e5b1a9f31f95b843@mail.gmail.com>
References: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com><641332d61bd84a5de4483dbb496ecd5a@mail.gmail.com>
 <AANLkTimfoR=36BcAFooNWzUEVJy1BLpdQji2hB1vnd1T@mail.gmail.com>
 <859a150e6ceac11b05685418a0c9243c@mail.gmail.com> <4D879CA0.6070904@crhc.illinois.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51088 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753623Ab1CVFJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 01:09:32 -0400
Received: by mail-qy0-f180.google.com with SMTP id 10so5619701qyk.11
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 22:09:29 -0700 (PDT)
In-Reply-To: <4D879CA0.6070904@crhc.illinois.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Johnson <johnso87@crhc.illinois.edu>
Cc: javier Martin <javier.martin@vista-silicon.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Matt Johnson [mailto:johnso87@crhc.illinois.edu]
> Sent: Tuesday, March 22, 2011 12:15 AM
> To: Vishwanath Sripathy
> Cc: javier Martin; linux-omap@vger.kernel.org
> Subject: Re: cpufreq support for the Beagleboard.
>
> On 03/21/2011 08:24 AM, Vishwanath Sripathy wrote:
> >> -----Original Message-----
> >> From: javier Martin [mailto:javier.martin@vista-silicon.com]
> >> Sent: Monday, March 21, 2011 5:40 PM
> >> To: Vishwanath Sripathy
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: cpufreq support for the Beagleboard.
> >>
> >> Hi,
> >> thank you for your fast answer.
> >>
> >> I've been testing the repository you pointed me and I found that only
> >> 300MHz and 600MHz can be selected in the Beagleboard xM.
> >> Couldn't we work until 1000MHz?
> > 1G is disabled by default in OPP table I suppose. Pls enable it (in
> > omap36xx_opp_def_list) if your board supports it.
> My understanding was that the mainline kernel needed support for
> SmartReflex 1.5 and Adaptive Body Biasing (ABB), as found in TI's
> linux-omap-psp 2.6.32, before it was safe to enable the 1GHz OPP on the
> DM3730 (for e.g., Beagleboard xM).  Is this not the case?  Can we really
> just flip the bit in the OPP table?
Sorry, I should have been more explicit.
Yes you need to have ABB and SR enabled before enabling 1G.

Vishwa
>
> >> Do you know what's left for those patches to enter mainline? Is
> >> anybody working on it?
> > OMAP cpufreq is undergoing some architecture/design changes and
> this is
> > WIP.
> >
> > Vishwa
> Thanks,
> Matt
>
> >> Thanks.
> >>
> >> --
> >> Javier Martin
> >> Vista Silicon S.L.
> >> CDTUC - FASE C - Oficina S-345
> >> Avda de los Castros s/n
> >> 39005- Santander. Cantabria. Spain
> >> +34 942 25 32 60
> >> www.vista-silicon.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
