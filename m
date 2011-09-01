From: Kevin Hilman <khilman@ti.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Thu, 01 Sep 2011 08:10:15 -0700
Message-ID: <87vctcjo2w.fsf@ti.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59097 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932185Ab1IAPKV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 11:10:21 -0400
Received: by mail-gx0-f182.google.com with SMTP id 28so2004577gxk.27
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 08:10:19 -0700 (PDT)
In-Reply-To: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	(javier Martin's message of "Thu, 1 Sep 2011 16:14:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

javier Martin <javier.martin@vista-silicon.com> writes:

> I am trying to enable cpuidle and cpufreq support in latest stable
> kernel (3.0.4) in the Beagleboard xM.

OMAP CPUfreq driver is still not in mailine.  I plan to rectify that
(finally) for v3.2.  In the mean time, feel free to try the
pm-wip/cpufreq branch from my linux-omap-pm tree[1] (currently based on
v3.0-rc3)

> The default governor I've selected in the kernel menu is "powersave".
> However, when I execute powertop 1.12 (downloaded from Angstrom 2010.=
x
> repository through opkg) I get the following:
>
>
> Cn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Avg residency=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 P-states (frequencies)
> C0 (cpu running)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( 0.4%)
> C0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 16.7ms (99.6%)
> C1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
> C2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
> C3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
> C4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
> C5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
> C6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0.0ms ( 0.0%)
>
> So, the CPU always stays in C0 status and P-states are not shown.=20

P-states are not shown because there is no CPUfreq driver, so no
P-states available, and of course the choice of CPUfreq governor doesn'=
t
matter.

CPU is staying in C0 probably because UARTs are not being idled, so SoC
cannot hit deeper idle states.  Try the following at the command line t=
o
to enable UART idle timeouts, so the SoC can attempt idle after the
timeout period

# UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout          =
    =20
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout          =
    =20
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout          =
    =20
echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout          =
    =20

After 5 seconds of inactivity on the UARTs, you should see the SoC
hitting deeper C-states.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
