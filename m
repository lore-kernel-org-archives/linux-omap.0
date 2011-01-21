From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Fri, 21 Jan 2011 09:53:22 +0530
Message-ID: <e1f3af7f928ead8c7b6cf98100b1e2d1@mail.gmail.com>
References: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com><8762tjjidg.fsf@ti.com>
 <AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38028 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827Ab1AUEXZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 23:23:25 -0500
Received: by mail-fx0-f50.google.com with SMTP id 14so1530373fxm.9
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 20:23:24 -0800 (PST)
In-Reply-To: <AANLkTikNkyN_qAGMWUrcRp8NzPW4fAYcpo0qiGBKTeDu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke Gong <lukejgong@gmail.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

Luke,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Luke Gong
> Sent: Friday, January 21, 2011 5:03 AM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Fail to suspend to ram: "Class driver suspend failed for
> cpu0"
>
> Thanks, Kevin.
>
> On Thu, Jan 20, 2011 at 5:54 PM, Kevin Hilman <khilman@ti.com>
> wrote:
> > Luke Gong <lukejgong@gmail.com> writes:
> >
> >> I have a beagle board with OMAP3530. I ported linux-omap-
> pm2.6.32 to
> >> this board. When I want to let it suspend to ram,
> >
> > This is an old kernel. =A0Any reason you're not using a newer kerne=
l?
>
> I have Angstrom7 with kernel 2.6.32 running on this board. So I
> selected this old version to test. I might try the latest one.
>
> >
> >> it fails and I get
> >> the message "Class driver suspend failed for cpu0"
> >
> > This is the CPUfreq driver failing to suspend, probably because the=
re
is
> > no CPUfreq driver implemented in your kernel. =A0Try disabling
> CPU_FREQ in
> > your kernel config.
>
> It seems can suspend to ram after disabling CPU_FREQ. Here is the log=
:
>
> root@beagleboard:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
>
> **********************************************************
> ***
> Once I hit the keyboard, I get:
>
> root@beagleboard:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (cam_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> Restarting tasks ... done.
> root@beagleboard:~#
> ***************************************************
>
> I am just curious why the powerdomain didn't enter target state 1.
It looks like your camera module is not idling upon suspend preventing =
per
and core to idle. Pls check whether camera driver has implemented
suspend/resume hooks properly. OR you can disable camera module and try=
=2E
>
> Another issue is about CPU frequency scaling. Using the original
> Angstrom7, I can scale CPU frequency. But with the linux-omap-pm
> kernel, I cannot do it even though I enable this feature in the confi=
g
> file. Is there any solution to support both cpu frequency scaling and
> suspend to ram?
In current linux-omap-pm branch, DVFS feature is not supported and this
work is under progress. Previously DVFS feature was supported in pm bra=
nch
using SRF and it has been removed sometime back.
If you really want cpufreq support, you can pick DVFS patches under rev=
iew
available at: https://patchwork.kernel.org/patch/290542/

It's also available in the dvfs tree hosted@
http://dev.omapzoom.org/?p=3Dthara/omap-dvfs.git;a=3Dshortlog;h=3Drefs/=
heads/pm-
dvfs

Vishwa

>
> Thanks again for your help.
> >
> > Kevin
> >
> >> . Here is the log:
> >>
> >> root@beagleboard:~# echo mem > /sys/power/state
> >> PM: Syncing filesystems ... done.
> >> Freezing user space processes ... (elapsed 0.00 seconds) done.
> >> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done=
=2E
> >> Suspending console(s) (use no_console_suspend to debug)
> >> omapfb omapfb: timeout waiting for FRAME DONE
> >> Class driver suspend failed for cpu0
> >> Restarting tasks ... done.
> >>
> >> *********************************************
> >>
> >> Is there any idea to fix this problem? Thanks.
> >
>
>
>
> --
> Luke
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
