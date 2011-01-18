From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Tue, 18 Jan 2011 19:17:17 +0100
Message-ID: <4F6B1267-93B8-4698-9880-376076825598@dominion.thruhere.net>
References: <1295336995-15831-1-git-send-email-premi@ti.com> <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net> <4D35C47D.6000102@ti.com> <b8bd13a9f9b383c7db6af63e1aa984be@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60628 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1ARSSB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 13:18:01 -0500
Received: by wwa36 with SMTP id 36so6790192wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 10:17:57 -0800 (PST)
In-Reply-To: <b8bd13a9f9b383c7db6af63e1aa984be@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Sanjeev Premi <premi@ti.com>, l-o List <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>


Op 18 jan 2011, om 18:18 heeft Vishwanath Sripathy het volgende geschreven:

> Kooi,
> 
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Tuesday, January 18, 2011 10:19 PM
>> To: Koen Kooi
>> Cc: Sanjeev Premi; l-o List; thara@ti.com; Vishwanath Sripathy
>> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
>> 
>> Koen Kooi wrote, on 01/18/2011 05:38 PM:
>>> 
>>> Op 18 jan 2011, om 08:49 heeft Sanjeev Premi het volgende
>> geschreven:
>>> 
>>>> This patch adds support for new speed enhanced parts with ARM
>>>> and IVA running at 720MHz and 520MHz respectively. These parts
>>>> can be probed at run-time by reading PRODID.SKUID[3:0] at
>>>> 0x4830A20C [1].
>>>> 
>>>> This patch specifically does following:
>>>> * Detect devices capable of 720MHz.
>>>> * Add new OPP
>>>> * Ensure that OPP is conditionally enabled.
>>>> * Check for presence of IVA before attempting to enable
>>>>   the corresponding OPP.
>>> 
>>> Thanks for the updated patch!
>>> 
>>> I'm still having problem using this together with DVFS, the kernel
>> won't scale beyond 600MHz because 600MHz and 720MHz share the
>> same voltage. Thara, Nishant, do you have any suggestions on how to
>> convince the kernel that 2 frequencies can share the same voltage
>> settings?
>> + Vishwa
> Yes, this is a limitation with the current set of DVFS patches.
> With the next version of DVFS patches (will be out soon) this feature is
> going to be supported. That means you can have 2 opps with the same
> voltage but with different frequency. The device will be configured based
> on user requested frequency.

Just to have a crude hack, would something like this work?:

	/* MPU OPP6 */
-	OPP_INITIALIZER("mpu", false, 720000000, 1350000),
+	OPP_INITIALIZER("mpu", false, 720000000, 1350001),

Or will I fall into a (post)divider trap where the kernel panics because it can't do that exact voltage?

The TRM[1] chickens out with the OPP definitions:

------------------>8---------------------------------------------------------------
Six generic processor OPPs can be defined as:
1. OPP6 (VDD1 = v4, (MPU_CLK = fmpu5, IVA2_CLK = fiva5))
2. OPP5 (VDD1 = v4, (MPU_CLK = fmpu4, IVA2_CLK = fiva4))
3. OPP4 (VDD1 = v3, (MPU_CLK = fmpu3, IVA2_CLK = fiva3))
4. OPP3 (VDD1 = v2 , (MPU_CLK = fmpu2, IVA2_CLK = fiva2))
5. OPP2 (VDD1 = v1 , (MPU_CLK = fmpu1, IVA2_CLK = fiva1))
6. OPP1 (VDD1 = v0 , (MPU_CLK = fmpu0, IVA2_CLK = fiva0))
where v4 > v3 > v2 > v1 > v0,
------------------8<---------------------------------------------------------------

My limited sample size of 3 board (2x beagle C4, 1x overo tide) shows 600MHz@1.3V works as well, but I don't know how much slack that has. And I haven't check if the hardware can do 1.3V exactly or has rounded up.

So, what's the quickest way with the current code to get 720MHz "working"? I've voided my warranty on everything already, so that isn't a problem :)

regards,

Koen

[1] spruf98m.pdf page 355