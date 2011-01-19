From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Wed, 19 Jan 2011 10:51:08 +0100
Message-ID: <1FDFBE36-31F7-4D14-A571-4A219F6E3EE6@dominion.thruhere.net>
References: <1295336995-15831-1-git-send-email-premi@ti.com> <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net> <B85A65D85D7EB246BE421B3FB0FBB593024847400C@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47857 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1ASJvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 04:51:11 -0500
Received: by wwa36 with SMTP id 36so667749wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 01:51:09 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024847400C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: l-o List <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Gopinath, Thara" <thara@ti.com>


Op 19 jan 2011, om 10:49 heeft Premi, Sanjeev het volgende geschreven:

>> -----Original Message-----
>> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
>> Sent: Tuesday, January 18, 2011 9:08 PM
>> To: Premi, Sanjeev
>> Cc: l-o List; Menon, Nishanth; Gopinath, Thara
>> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
>> 
> [snip]...[snip]
>> 
>> Thanks for the updated patch! 
>> 
>> I'm still having problem using this together with DVFS, the 
>> kernel won't scale beyond 600MHz because 600MHz and 720MHz 
>> share the same voltage. Thara, Nishant, do you have any 
>> suggestions on how to convince the kernel that 2 frequencies 
>> can share the same voltage settings? 
> 
> Koen,
> 
> I still haven't spent time testing with DVFS.
> 
> There are few issue that need to be resolved with the DVFS
> infra before DVFS can be functional.
> 
> Would like this patch to be de-coupled from DVFS discussions.
> It was not the intent of the patch...

It was not my intent to couple it to DVFS discussions, I just used it as an example to highlight the bugs I'm hitting with DVFS and 720MHz operation :) I don't want this patch to be held back by bugs in the DVFS code!