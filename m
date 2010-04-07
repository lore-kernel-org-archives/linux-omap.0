From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] arm: omap1/2/3/4: convert 32k-sync driver to a
 platform_driver
Date: Wed, 7 Apr 2010 20:34:20 +0300
Message-ID: <20100407173420.GA11943@nokia.com>
References: <20100407072102.GU16297@nokia.com>
 <1270634244-22741-3-git-send-email-felipe.balbi@nokia.com>
 <87bpdvfdoy.fsf@deeprootsystems.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17814 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0DGRej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 13:34:39 -0400
Content-Disposition: inline
In-Reply-To: <87bpdvfdoy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Apr 07, 2010 at 06:08:13PM +0200, ext Kevin Hilman wrote:
>felipe.balbi@nokia.com writes:
>
>> From: Felipe Balbi <felipe.balbi@nokia.com>
>>
>> Convert the omap32k clocksource driver into a platform_driver
>> and while at that, also remove the ifdeferry around the code.
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>
>I'm OK with this for now.  Ideally, this would be further converted to
>use hwmod + omap_device to automatcially created the platform_devices
>for you.

Yeah. I was asking Paul about it today. I can send as a follow up patch 
on next week.

-- 
balbi
