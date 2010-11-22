From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap4: 4430sdp: enable the ehci port on 4430SDP
Date: Mon, 22 Nov 2010 14:06:08 +0200
Message-ID: <20101122120608.GG2446@legolas.emea.dhcp.ti.com>
References: <1290364999-4783-1-git-send-email-gadiyar@ti.com>
 <20101122101737.GN2446@legolas.emea.dhcp.ti.com>
 <4CEA59E0.8080705@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58880 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753434Ab0KVMGB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 07:06:01 -0500
Received: by gwb10 with SMTP id 10so3919238gwb.1
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 04:06:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CEA59E0.8080705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Tony Lindgren <tony@atomide.com>

On Mon, Nov 22, 2010 at 05:24:08PM +0530, Anand Gadiyar wrote:
>On 11/22/2010 3:47 PM, Felipe Balbi wrote:
>> On Mon, Nov 22, 2010 at 12:13:19AM +0530, Anand Gadiyar wrote:
>>> From: Keshava Munegowda <keshava_mgowda@ti.com>
>>>
>>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> Tony, if you give me your Ack I can take this with Greg since it depends
>> on the series I'm checking now.
>>
>
>This one can go through Tony - I deliberately left it out of the EHCI series.
>
>The dependency is needed for the EHCI port to actually be usable, however we
>can register the device in the board file independently of the driver.
>
>I forgot to update the patch description - I'll wait some more for any
>more comments and then repost with a proper description.

Ok, so it's Tony's call now. Tony, if you want to take this together
with OMAP changes, just let me know and I'll drop this patch from my
branch, if you want me to take it through Greg, then give me an Acked-by
:-)

-- 
balbi
