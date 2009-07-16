From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp hibernation
Date: Thu, 16 Jul 2009 10:12:03 +0300
Message-ID: <4A5ED2C3.8070105@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com> <1247669795-23895-2-git-send-email-ameya.palande@nokia.com> <1247669795-23895-3-git-send-email-ameya.palande@nokia.com> <1247669795-23895-4-git-send-email-ameya.palande@nokia.com> <1247669795-23895-5-git-send-email-ameya.palande@nokia.com> <1247669795-23895-6-git-send-email-ameya.palande@nokia.com> <1247669795-23895-7-git-send-email-ameya.palande@nokia.com> <1247669795-23895-8-git-send-email-ameya.palande@nokia.com> <1247669795-23895-9-git-send-email-ameya.palande@nokia.com> <1247669795-23895-10-git-send-email-ameya.palande@nokia.com> <1247669795-23895-11-git-send-email-ameya.palande@nokia.com> <1247669795-23895-12-git-send-email-ameya.palande@nokia.com> <1247669795-23895-13-git-send-email-ameya.palande@nokia.com> <496
 565EC904933469F292DDA3F1663E602A32025E9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25988 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZGPHMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 03:12:05 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A32025E9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Fernando,

ext Guzman Lugo, Fernando wrote:
> 
> Hi,
> 
>> -----Original Message-----
>> From: Ameya Palande [mailto:ameya.palande@nokia.com]
>> Sent: Wednesday, July 15, 2009 9:57 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Menon, Nishanth;
>> hiroshi.doyu@nokia.com
>> Subject: [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp
>> hibernation
>>
>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>>
>> The constraints(opp >= 2) should be set whenever returning from DSP
>> hibernation.
>>
>> This fixes the problem at the following steps:
>> 1) wait DSP hibernate
>> 2) echo mem > /sys/power/state
>> 3) type key to wakeup
>>
> 
> The patch looks good, you are removing the check for OPP1 because it is suppose
> that if the DSP is in Hibernation we have a DSP constrain in OPP1,
> so I think the "if" is always true. However I don't see the issue the mention
> could you please tell me what was the problem you were seeing?

While waking up DSP if VDD1 OPP is greater that 1 then without this patch,
constraint won't be set. This results in a case where PM layer later decides to
switch to OPP1 while DSP is active, which results in a crash. To avoid this we
are setting VDD1 to OPP2 unconditionally while waking up from hibernation :)

Cheers,
Ameya.
