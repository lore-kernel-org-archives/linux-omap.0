From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: How to enable dvfs in omap.
Date: Sat, 12 Feb 2011 16:27:51 +0530
Message-ID: <e4a5bc05ba60bfbabb5338354a1bd69e@mail.gmail.com>
References: <4D5665D4.2030902@e-consystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36897 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab1BLK55 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 05:57:57 -0500
Received: by wwi17 with SMTP id 17so387370wwi.5
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:57:54 -0800 (PST)
In-Reply-To: <4D5665D4.2030902@e-consystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohamed@e-consystems.com, OMAP-KML <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mohamed Thalib H
> Sent: Saturday, February 12, 2011 4:20 PM
> To: OMAP-KML
> Subject: How to enable dvfs in omap.
>
> Hi all,
>
> I am using omap 2.6.37 running overo board. I have enabled the
> following
> option in the kernel menunconfig,
>
>
> CPU Power Management --->
> =E2=94=82 =E2=94=82 [*] CPU Frequency scaling
> =E2=94=82 =E2=94=82 [ ] Enable CPUfreq debugging
> =E2=94=82 =E2=94=82 <*> CPU frequency translation statistics
> =E2=94=82 =E2=94=82 [*] CPU frequency translation statistics details
> =E2=94=82 =E2=94=82 Default CPUFreq governor (ondemand) --->
> =E2=94=82 =E2=94=82 -*- 'performance' governor
> =E2=94=82 =E2=94=82 <M> 'powersave' governor
> =E2=94=82 =E2=94=82 <*> 'userspace' governor for userspace frequency =
scaling
> =E2=94=82 =E2=94=82 -*- 'ondemand' cpufreq policy governor
> =E2=94=82 =E2=94=82 <*> 'conservative' cpufreq governor
> =E2=94=82 =E2=94=82 [ ] CPU idle PM support
>
>
> but still I could find the sys and entry in
> /sys/devices/system/cpu/cpufreq/ directory. Could some one help me
> to enable DVFS.
>
That's because tts not supported yet.
You may want to look at this[1] series which is in progress
to enable the support.


Regards,
Santosh

[1] [PATCH 00/13] OMAP: Basic DVFS Framework
 http://www.spinics.net/lists/linux-omap/msg44393.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
