From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: How to enable dvfs in omap.
Date: Sat, 12 Feb 2011 16:19:56 +0530
Message-ID: <4D5665D4.2030902@e-consystems.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:36476 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751779Ab1BLKuD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:50:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP-KML <linux-omap@vger.kernel.org>

Hi all,

I am using omap 2.6.37 running overo board. I have enabled the followin=
g=20
option in the kernel menunconfig,


CPU Power Management --->
=E2=94=82 =E2=94=82 [*] CPU Frequency scaling
=E2=94=82 =E2=94=82 [ ] Enable CPUfreq debugging
=E2=94=82 =E2=94=82 <*> CPU frequency translation statistics
=E2=94=82 =E2=94=82 [*] CPU frequency translation statistics details
=E2=94=82 =E2=94=82 Default CPUFreq governor (ondemand) --->
=E2=94=82 =E2=94=82 -*- 'performance' governor
=E2=94=82 =E2=94=82 <M> 'powersave' governor
=E2=94=82 =E2=94=82 <*> 'userspace' governor for userspace frequency sc=
aling
=E2=94=82 =E2=94=82 -*- 'ondemand' cpufreq policy governor
=E2=94=82 =E2=94=82 <*> 'conservative' cpufreq governor
=E2=94=82 =E2=94=82 [ ] CPU idle PM support


but still I could find the sys and entry in=20
/sys/devices/system/cpu/cpufreq/ directory. Could some one help me to=20
enable DVFS.

root@overo:/sys/devices/system/cpu# ls
cpu0 kernel_max online possible
cpufreq offline perf_events present
root@overo:/sys/devices/system/cpu# cd cpu0/
root@overo:/sys/devices/system/cpu/cpu0# ls
crash_notes
root@overo:/sys/devices/system/cpu/cpu0# cd ..
root@overo:/sys/devices/system/cpu# cd cpufreq/
root@overo:/sys/devices/system/cpu/cpufreq# ls
root@overo:/sys/devices/system/cpu/cpufreq#
--=20

Regards,
Mohamed Thalib H

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
