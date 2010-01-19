From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 1/1] OMAP3: PM: Fix compilation issue of
 omap3_pm_init_opp_table
Date: Tue, 19 Jan 2010 16:35:42 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E753D2BD@dnce01.ent.ti.com>
References: <1263902254-3015-1-git-send-email-eduardo.valentin@nokia.com>
 <4B559F1C.6070802@gmail.com>
 <20100119134927.GE12231@esdhcp037198.research.nokia.com>
 <4B55BD13.70704@ti.com> <4B55C290.2060205@ti.com> <4B55C47E.2090002@ti.com>
 <4B55C4CF.4030509@ti.com> <4B55C521.5050602@ti.com>
 <4B55C56F.9030100@ti.com> <4B55C6BF.4080601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0ASPgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 10:36:24 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <4B55C6BF.4080601@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, ext Nishanth Menon <menon.nishanth@gmail.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Hi Romit,

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>
>Menon, Nishanth wrote:
>> Dasgupta, Romit had written, on 01/19/2010 08:43 AM, the following:
>>>>> 3430 opps, and we should move it to opp34xx.c(I hate having new
>files :( )..
>>>>> It should be only
>>>>> #ifdef CONFIG_CPU_FREQ. OPP has nothing to do with CONFIG_PM.
>>>>>
>>>>> Why do you need CPU_FREQ for suspend/resume??
>>>>>
>>>> voltage control - SR needs to query for voltage?
>>>>
>>> Why should suspend/resume be dependent on SR?
>> please see the code logic -> when SR is enabled and OFF/RET happens, you
>> need the voltage for the current frequency so that you can disable SR,
>> set the nominal voltage for the current OPP then go to WFI.
>>
>You do not need the OPP table for querying voltage alone. You can read that
>from the OMAP chip registers directly. So OPP layer is not necessary when
>we do not use cpufreq!

I do agree that we should not need CPUfreq, but cannot use the voltage from the VP either; you need to set the nominal voltage to be safe not the one after SR correction.
Eventually it will have to be handled by the SR layer.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



