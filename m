From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 1/1] OMAP3: PM: Fix compilation issue of
 omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 22:30:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E196B372@dbde02.ent.ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
 <4B559F1C.6070802@gmail.com>
 <20100119134927.GE12231@esdhcp037198.research.nokia.com>
 <4B55BD13.70704@ti.com> <4B55C290.2060205@ti.com> <4B55C47E.2090002@ti.com>
 <4B55C4CF.4030509@ti.com> <4B55C521.5050602@ti.com>
 <4B55C56F.9030100@ti.com>
 <4B55C6BF.4080601@ti.com>,<74583B8642AB8841B30447520659FCA9E753D2BD@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49862 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab0ASRCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 12:02:37 -0500
In-Reply-To: <74583B8642AB8841B30447520659FCA9E753D2BD@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>


Hello Benoit,
>>You do not need the OPP table for querying voltage alone. You can read that
>>from the OMAP chip registers directly. So OPP layer is not necessary when
>>we do not use cpufreq!

>I do agree that we should not need CPUfreq, but cannot use the voltage from the VP either; you need to set >the nominal voltage to be safe not the one after SR correction.
>Eventually it will have to be handled by the SR layer.
Yes it can be handled by SR layer but this does not need one to query OPP. All you need is to know current freq and voltage. This can and should be done without taking help of OPP layer (when CONFIG_CPU_FREQ is absent).

Thanks,
-Romit