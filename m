From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: cpufreq support for the Beagleboard.
Date: Mon, 21 Mar 2011 16:27:44 +0530
Message-ID: <641332d61bd84a5de4483dbb496ecd5a@mail.gmail.com>
References: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55231 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753189Ab1CUK5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 06:57:53 -0400
Received: by mail-ww0-f49.google.com with SMTP id 33so6410521wwc.6
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 03:57:51 -0700 (PDT)
In-Reply-To: <AANLkTi=mWbpi7i6if5TdBCoi0bUFGWcxOba1kZ+6EePa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>, linux-omap@vger.kernel.org

Cpufreq for omap is not mainlined yet.
Patches for supporting omap cpufreq are posted at
https://patchwork.kernel.org/patch/495021/

Same are available at
git://gitorious.org/omap-pm/linux.git omap_dvfs

Vishwa

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of javier Martin
> Sent: Monday, March 21, 2011 4:12 PM
> To: linux-omap@vger.kernel.org
> Subject: cpufreq support for the Beagleboard.
>
> Hi,
> I am testing latest 2.6.38 stable kernel with my Beagleboard xM. I
> have enabled CONFIG_CPU_FREQ option and several governors.
> However, when I boot the board and execute "cpufreq-info" I get the
> following:
>
> root@beagleboard:~# cpufreq-info
> cpufrequtils 006: cpufreq-info (C) Dominik Brodowski 2004-2009
> Report errors and bugs to cpufreq@vger.kernel.org, please.
> analyzing CPU 0:
>   no or unknown cpufreq driver is active on this CPU
>   maximum transition latency: 0.00 ms.
>
> I've read some information in this wiki:
> http://elinux.org/OMAP_Power_Management
>
> It seems that cpufreq is still not in mainline but it should be
> already on pm branch of omap repository. However, I've also tried
> compiling this one and I've got the same problem.
>
> Could anyone clarify whether cpufreq is supported or not in the
> Beagleboard xM and where?
>
> Thank you.
>
> --
> Javier Martin
> Vista Silicon S.L.
> CDTUC - FASE C - Oficina S-345
> Avda de los Castros s/n
> 39005- Santander. Cantabria. Spain
> +34 942 25 32 60
> www.vista-silicon.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
