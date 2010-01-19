From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 1/1] OMAP3: PM: Fix compilation issue of
 omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 22:32:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E196B373@dbde02.ent.ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
 <4B559F1C.6070802@gmail.com>
 <20100119134927.GE12231@esdhcp037198.research.nokia.com>
 <4B55BD13.70704@ti.com> <4B55C290.2060205@ti.com> <4B55C47E.2090002@ti.com>
 <4B55C4CF.4030509@ti.com> <4B55C521.5050602@ti.com>
 <4B55C56F.9030100@ti.com> <4B55C6BF.4080601@ti.com>,<4B55CC92.6090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50154 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab0ASRHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 12:07:25 -0500
In-Reply-To: <4B55CC92.6090403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

________________________________________

>there are multiple ways to use SR -> Not all of them can use OMAP chip
>registers. certain class of devices would need to use PMICs,
Even then you do not need OPP layer. For PMIC based solutions you need
to use I2C to get the voltage. So this should be abstracted. OPP layer is just for
CPU FREQ.
> further SRF
>or it's equivalent will need to query the table for knowing what voltage
>corresponds to frequency, 
Why should you know the voltage for a frequency other than your current
frequency when you do not scale the frequency of your CPU? Clock framework
will give you the current freq. For voltage, we already discussed above.


>DSPBRidge needs to report to the baseimage
>what voltage corresponds to the frequency for the baseimage's load
>balancing/power decision logic etc.. in short when dynamic voltage
>scaling is needed, we need OPP layer a.k.a CONFIG_PM needs opp layer -
>not just cpufreq.
Please understand CONFIG_PM is not for any kind of __cpufreq or dspfreq__.
It is for suspend resume and few other stuff. So why should CONFIG_PM need
OPP layer?



--
Regards,
Nishanth Menon