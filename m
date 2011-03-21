From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: cpufreq support for the Beagleboard.
Date: Mon, 21 Mar 2011 18:54:04 +0530
Message-ID: <859a150e6ceac11b05685418a0c9243c@mail.gmail.com>
References: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com><641332d61bd84a5de4483dbb496ecd5a@mail.gmail.com>
 <AANLkTimfoR=36BcAFooNWzUEVJy1BLpdQji2hB1vnd1T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43345 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584Ab1CUNYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:24:10 -0400
Received: by wyb40 with SMTP id 40so7034168wyb.21
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 06:24:06 -0700 (PDT)
In-Reply-To: <AANLkTimfoR=36BcAFooNWzUEVJy1BLpdQji2hB1vnd1T@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: javier Martin [mailto:javier.martin@vista-silicon.com]
> Sent: Monday, March 21, 2011 5:40 PM
> To: Vishwanath Sripathy
> Cc: linux-omap@vger.kernel.org
> Subject: Re: cpufreq support for the Beagleboard.
>
> Hi,
> thank you for your fast answer.
>
> I've been testing the repository you pointed me and I found that only
> 300MHz and 600MHz can be selected in the Beagleboard xM.
> Couldn't we work until 1000MHz?
1G is disabled by default in OPP table I suppose. Pls enable it (in
omap36xx_opp_def_list) if your board supports it.
>
> Do you know what's left for those patches to enter mainline? Is
> anybody working on it?
OMAP cpufreq is undergoing some architecture/design changes and this is
WIP.

Vishwa
>
> Thanks.
>
> --
> Javier Martin
> Vista Silicon S.L.
> CDTUC - FASE C - Oficina S-345
> Avda de los Castros s/n
> 39005- Santander. Cantabria. Spain
> +34 942 25 32 60
> www.vista-silicon.com
