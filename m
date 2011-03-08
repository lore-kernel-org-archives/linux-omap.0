From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3] OMAP3+: OPP: Replace voltage values with Macros
Date: Tue, 08 Mar 2011 05:47:04 +0530
Message-ID: <4D757580.6050507@ti.com>
References: <1299320842-2503-1-git-send-email-nm@ti.com> <874o7e1ss2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53236 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab1CHARN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 19:17:13 -0500
Received: by mail-vw0-f42.google.com with SMTP id 10so4291973vws.29
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 16:17:12 -0800 (PST)
In-Reply-To: <874o7e1ss2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Vishwanath BS <vishwanath.bs@ti.com>

Kevin Hilman wrote, on 03/08/2011 03:45 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> Since all voltage data is now centralized in oppxxx_data.c, we can replace
>> the values in the opp table with the macros used for voltage values.
>>
>> This will avoid opp table and voltage layer having conflicting values.
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>
> As you are now on the delivery path too, this should have your sign-off.
>
> Assuming this is a simple oversight, I added your signoff and queued for
> 2.6.39 (branch: for_2.6.39/pm-misc)

thanks.

-- 
Regards,
Nishanth Menon
