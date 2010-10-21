From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] 32k sync timer meets hwmod
Date: Thu, 21 Oct 2010 22:09:03 +0300
Message-ID: <20101021190903.GX3958@legolas.emea.dhcp.ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
 <87mxq7xw7g.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56888 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071Ab0JUTJI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 15:09:08 -0400
Content-Disposition: inline
In-Reply-To: <87mxq7xw7g.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Oct 21, 2010 at 01:00:19PM -0500, Kevin Hilman wrote:
>Felipe Balbi <balbi@ti.com> writes:
>
>> Converted 32k-sync timer to platform_driver
>> and now using pm_runtime and hwmod.
>>
>> Tested on 3430 by me and 4430 by Tarun
>>
>> If someone could test on 2430 and 2420, I would
>> be really glad.
>
>Hey, don't you have a 2420 device.  There were some cool 2420-based
>tablets a few years ago made by some company in Finland that you may
>have heard of.  ;)

I have an n810 which doesn't work :-p sucks to be me :-p

-- 
balbi
