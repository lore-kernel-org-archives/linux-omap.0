From: javier Martin <javier.martin@vista-silicon.com>
Subject: cpuidle status in mainline for Beagleboard xM
Date: Thu, 1 Sep 2011 16:14:00 +0200
Message-ID: <CACKLOr10aTCwkBZnSinvP4HLPhrJeiBs=6KM2we4DwTT0NJ22A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35894 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420Ab1IAOOB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:14:01 -0400
Received: by ywf7 with SMTP id 7so1404997ywf.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 07:14:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@beagleboard.org>

Hi,
I am trying to enable cpuidle and cpufreq support in latest stable
kernel (3.0.4) in the Beagleboard xM.
The default governor I've selected in the kernel menu is "powersave".
However, when I execute powertop 1.12 (downloaded from Angstrom 2010.x
repository through opkg) I get the following:


Cn=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Avg residency=A0=A0=A0=A0=
=A0=A0 P-states (frequencies)
C0 (cpu running)=A0=A0=A0=A0=A0=A0=A0 ( 0.4%)
C0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 16.7ms (99.6%)
C1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)
C2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)
C3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)
C4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)
C5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)
C6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0.0ms ( 0.0%)

So, the CPU always stays in C0 status and P-states are not shown. I've
read some old reports of this working properly in omap-pm-next branch
http://groups.google.com/group/beagleboard/browse_thread/thread/b03e088=
68af7c6e0?pli=3D1%29
Do cpuidle and cpufreq really work in mainline?

Thank you.

--
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
