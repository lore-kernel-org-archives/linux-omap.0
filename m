From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Tue, 18 Jan 2011 18:49:01 +0200
Message-ID: <4D35C47D.6000102@ti.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com> <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47901 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751199Ab1ARQtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 11:49:06 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so3819122bwz.18
        for <linux-omap@vger.kernel.org>; Tue, 18 Jan 2011 08:49:04 -0800 (PST)
In-Reply-To: <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Sanjeev Premi <premi@ti.com>, l-o List <linux-omap@vger.kernel.org>, thara@ti.com, Vishwanath Sripathy <vishwanath.bs@ti.com>

Koen Kooi wrote, on 01/18/2011 05:38 PM:
>
> Op 18 jan 2011, om 08:49 heeft Sanjeev Premi het volgende geschreven:
>
>> This patch adds support for new speed enhanced parts with ARM
>> and IVA running at 720MHz and 520MHz respectively. These parts
>> can be probed at run-time by reading PRODID.SKUID[3:0] at
>> 0x4830A20C [1].
>>
>> This patch specifically does following:
>> * Detect devices capable of 720MHz.
>> * Add new OPP
>> * Ensure that OPP is conditionally enabled.
>> * Check for presence of IVA before attempting to enable
>>    the corresponding OPP.
>
> Thanks for the updated patch!
>
> I'm still having problem using this together with DVFS, the kernel won't scale beyond 600MHz because 600MHz and 720MHz share the same voltage. Thara, Nishant, do you have any suggestions on how to convince the kernel that 2 frequencies can share the same voltage settings?
+ Vishwa

>
> If that isn't possible, should we lower the voltages for the lower opps when detecting a 720MHz capable SoC? It would make sense that if 720MHz works at X volt that 600MHz would work at less  than X volt. (I don't have a PDF reader at hand to check the TRM at the moment).
>
> Complete tree at http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=koen/beagle-next but this can be reproduced as well by merging Thara's dvfs branch and applying Sanjeevs patch.
I suspect the problem lies here:

http://dominion.thruhere.net/git/cgit.cgi/linux-omap/tree/arch/arm/mach-omap2/voltage.c?h=koen/beagle-next#n1847
if two OPP frequencies have same voltage, the api introduced in
http://dominion.thruhere.net/git/cgit.cgi/linux-omap/commit/?h=koen/beagle-next&id=fd2991c20a8f770c7b8f5a29b3cbb17b9fca4768

will return back the first OPP entry which matches, which would be the 
lower frequency as OPPs are organized in the OPP layer in increasing order.

-- 
Regards,
Nishanth Menon
