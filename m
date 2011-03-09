From: Andy Green <andy@warmcat.com>
Subject: Re: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
 flags for each cpu_... test
Date: Wed, 09 Mar 2011 15:18:11 +0000
Message-ID: <4D779A33.9070905@linaro.org>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>	<20110308110904.23531.66727.stgit@otae.warmcat.com> <AANLkTi=KjWq9B9Bt90Th72=tXF2BfEv1p1Z-0=Sk1Z+t@mail.gmail.com>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32897 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068Ab1CIPS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 10:18:26 -0500
Received: by wya21 with SMTP id 21so517574wya.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 07:18:25 -0800 (PST)
In-Reply-To: <AANLkTi=KjWq9B9Bt90Th72=tXF2BfEv1p1Z-0=Sk1Z+t@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, Ben Dooks <ben-linux@fluff.org>

On 03/09/2011 02:31 PM, Somebody in the thread at some point said:

Hi -

> Minor comment, Can you use
> BIT(0) for 1, BIT(1) for 2 ... BIT (8) for 0x100

OK, I agree it will be nicer.  Thanks for the comment.

I guess I can just change this and issue just this guy as try 3 rather 
than sending the whole series mostly unchanged.  In that case, I'll take 
care of Benoit's member re-ordering to match the scripts at the same 
time and issue that guy as try 3 as well.

-Andy
