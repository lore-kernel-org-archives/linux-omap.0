From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: Re: [beagleboard] Re: USB EHCI problems
Date: Sat, 15 Aug 2009 23:04:14 +0300
Message-ID: <200908152304.15249.siarhei.siamashka@gmail.com>
References: <cc69eebf0907230459jb47f4e9pb1b5953a4819aa45@mail.gmail.com> <cc69eebf0908130606l78849436j459f4bf4ceaecf7b@mail.gmail.com> <4A85E7D0.2070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:35677 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZHOUER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 16:04:17 -0400
Received: by ewy10 with SMTP id 10so2188090ewy.37
        for <linux-omap@vger.kernel.org>; Sat, 15 Aug 2009 13:04:17 -0700 (PDT)
In-Reply-To: <4A85E7D0.2070807@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 15 August 2009, Frantisek Dufka wrote:
> Gerald Coley wrote:
> > You need to enable Smart Reflex on VDD2 in the Kernel. I can't seem to
> > get anyone around here to help me formalize exactly how to do this in
> > the Kernel. So if you can figure it out, I would go ahead and do it. If
> > you could please then post it to the community, that would be great.
> >
> > Gerald
>
> http://www.webos-internals.org/wiki/Patch_webOS_CPU_Frequency_or_Voltage_Sc
>aling#Enable_SmartReflex
>
> the file is there but after running
> echo -n 1 > /sys/power/sr_vdd2_autocomp
> there is still zero in the file and in kernel log I see
> OPP3 doesn't support SmartReflex
> SR2: VDD autocomp not activated
>
> Maybe different kernel would do.

Would it make sense to ask for help in the linux-omap mailing list?
I guess Gerald has a reply from TI or a new errata list or something else
which says that "enabling Smart Reflex on VDD2" can workaround EHCI problem.

Now somebody knowledgeable about kernel internals, OMAP3, Smart Reflex
and power management code in general could probably provide some hints
or even a patch to enable this bugfix in the kernel. Maybe the fix is even
sitting in somebody's branch already and we just don't know. Or maybe a
solution for EHCI problem has been explained in the list, but just was
lost in the pile of other messages in linux-omap (it has quite a heavy
traffic).

It may make sense to look at the 'pm' branch:
http://elinux.org/OMAP_Power_Management

But this wiki page has comment:
"Enables SmartReflex autocompensation on VDD2 (Note: This feature can only be 
tested on a ES3.1 silicon):
# echo 1 > /sys/power/sr_vdd2_autocomp"

And AFAIK beagleboard revision C has ES3.0 silicon. So no luck here. Or can
something still be done?

The whole beagleboard EHCI story starts here:
http://groups.google.com/group/beagleboard/browse_thread/thread/5b8385f0bb1f63da/d46625fe49783a8a

-- 
Best regards,
Siarhei Siamashka
