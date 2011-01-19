From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: Add basic support for 720MHz part
Date: Wed, 19 Jan 2011 15:19:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024847400C@dbde02.ent.ti.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com>
 <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45480 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab1ASJtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 04:49:08 -0500
In-Reply-To: <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: l-o List <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
> Sent: Tuesday, January 18, 2011 9:08 PM
> To: Premi, Sanjeev
> Cc: l-o List; Menon, Nishanth; Gopinath, Thara
> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
> 
[snip]...[snip]
> 
> Thanks for the updated patch! 
> 
> I'm still having problem using this together with DVFS, the 
> kernel won't scale beyond 600MHz because 600MHz and 720MHz 
> share the same voltage. Thara, Nishant, do you have any 
> suggestions on how to convince the kernel that 2 frequencies 
> can share the same voltage settings? 

Koen,

I still haven't spent time testing with DVFS.

There are few issue that need to be resolved with the DVFS
infra before DVFS can be functional.

Would like this patch to be de-coupled from DVFS discussions.
It was not the intent of the patch...

Am working to list all the issues and possible solutions for
the DVFS... getting delayed due to other activities.

~sanjeev

[snip]...[snip]
