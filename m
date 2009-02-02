From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: Beagle PM hangs
Date: Mon, 2 Feb 2009 10:30:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02F541FDAA@dbde02.ent.ti.com>
References: <87hc3gk9au.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbZBBFBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 00:01:05 -0500
In-Reply-To: <87hc3gk9au.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Sriram V <vshrirama@gmail.com>, Peter Reid <ppeter.reid@gmail.com>, Koen Kooi <koen@beagleboard.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Friday, January 30, 2009 10:42 PM
> To: Woodruff, Richard
> Cc: Sriram V; Peter Reid; Koen Kooi; linux-omap@vger.kernel.org
> Subject: Re: Beagle PM hangs
> 
> Richard,
> 
> "Woodruff, Richard" <r-woodruff2@ti.com> writes:
> 
> >>   I wait for a min and try to wakeup - It works.
> >>
> >>   If i wait a little longer before waking it up say, 3 or 
> 4 minutes.
> >> It does not wakeup.
> >
> > That is consistent with your memory not being placed into 
> self refresh properly.
> >
> > 5 general bugs I've seen over time:
> >         sw bug:
> >                 - ctrl sequence issue before sleep
> >                 - CKE balls not muxed correctly
> >                 - crash on unexpected wake path
> >         chip bug:
> >                 - (3430 >= es3 requires a errata sequence to work)
> >         board bug:
> >                 - hooking ddr-chip-CKE wrongly or a way 
> OMAP doesn't support like sharing between dies.
> 
> Another possibility is that the the memory timings for the custom
> board are not set correctly.
> 
> Richard, Do you have pointers to CDP/zoom code that has a workaround
> for the 3430 > es3 errata

The es3 sdrc errata fix is already present in the pm branch.

 as well as the 'ctrl sequence issue' you
> mentioned?
> 
> Kevin
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 