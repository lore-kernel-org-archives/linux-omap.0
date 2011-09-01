From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: cpuidle status in mainline for Beagleboard xM
Date: Thu, 1 Sep 2011 17:33:31 +0200
Message-ID: <CACKLOr0KpCUXrXM7M9YvE3DGPbGjzT4N678eEPfx_GGE7+40-w@mail.gmail.com>
References: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
	<87vctcjo2w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35206 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab1IAPdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 11:33:32 -0400
Received: by gxk21 with SMTP id 21so1449265gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 08:33:31 -0700 (PDT)
In-Reply-To: <87vctcjo2w.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@beagleboard.org>

Hi Kevin,
thanks for your help.

> CPU is staying in C0 probably because UARTs are not being idled, so S=
oC
> cannot hit deeper idle states. =A0Try the following at the command li=
ne to
> to enable UART idle timeouts, so the SoC can attempt idle after the
> timeout period
>
> # UART timeouts: omap-serial (4th UART only on OMAP36xx and OMAP4)
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>
> After 5 seconds of inactivity on the UARTs, you should see the SoC
> hitting deeper C-states.

I've tried that but it still doesn't hit any C-state deeper than 0.
I'll try the same test using your pm branch you pointed me out and
post the results.

Regards.
--=20
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
