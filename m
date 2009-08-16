From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [beagleboard] Re: USB EHCI problems
Date: Sat, 15 Aug 2009 21:53:51 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620396DFEB5D@dlee02.ent.ti.com>
References: <cc69eebf0907230459jb47f4e9pb1b5953a4819aa45@mail.gmail.com>
 <cc69eebf0908130606l78849436j459f4bf4ceaecf7b@mail.gmail.com>
 <4A85E7D0.2070807@gmail.com> <200908152304.15249.siarhei.siamashka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbZHPCx6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 22:53:58 -0400
In-Reply-To: <200908152304.15249.siarhei.siamashka@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Siarhei Siamashka
> Sent: Saturday, August 15, 2009 3:04 PM

> On Saturday 15 August 2009, Frantisek Dufka wrote:
> > Gerald Coley wrote:
> > > You need to enable Smart Reflex on VDD2 in the Kernel. I can't seem to
> > > get anyone around here to help me formalize exactly how to do this in
> > > the Kernel. So if you can figure it out, I would go ahead and do it. If
> > > you could please then post it to the community, that would be great.
> > >
> > > Gerald
> >
> > http://www.webos-internals.org/wiki/Patch_webOS_CPU_Frequency_or_Voltage_Sc
> >aling#Enable_SmartReflex

Seems hacking moves along fast, some basic info and mis-info on Pre.  Pre kernel which is shipped needs a few patches and it is capable of running sr+dvfs at the same time.

> > the file is there but after running
> > echo -n 1 > /sys/power/sr_vdd2_autocomp
> > there is still zero in the file and in kernel log I see
> > OPP3 doesn't support SmartReflex
> > SR2: VDD autocomp not activated

In older code you need both compile time and run time to get it to take.  Just turning it on won't be so safe until some bug fixes make their way out.

> It may make sense to look at the 'pm' branch:
> http://elinux.org/OMAP_Power_Management

pm branch needs a few changes to make it viable for sr.

> But this wiki page has comment:
> "Enables SmartReflex autocompensation on VDD2 (Note: This feature can only be
> tested on a ES3.1 silicon):
> # echo 1 > /sys/power/sr_vdd2_autocomp"
>
> And AFAIK beagleboard revision C has ES3.0 silicon. So no luck here. Or can
> something still be done?

You will only find characterized parameters for 3.1 and 3.1.1.  These are production parts.

I had heard a few bits of talk about running at lower voltage helping ehci out.  That seems backwards even if tests show it working. I wonder if it is some artifact of a timing change which happens at lower voltage and because of some new internal chip activity.

Regards,
Richard W.

