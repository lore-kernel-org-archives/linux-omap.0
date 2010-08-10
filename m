From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 0/8]usb: musb:USB driver changes to use hwmod+
 omap-device apis
Date: Tue, 10 Aug 2010 10:33:57 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270944037@dbde02.ent.ti.com>
References: <1281110052-28990-1-git-send-email-hemahk@ti.com>
 <4C5FF544.9050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43827 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab0HJFEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 01:04:08 -0400
In-Reply-To: <4C5FF544.9050907@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi, 

>-----Original Message-----
>From: Cousson, Benoit 
>Sent: Monday, August 09, 2010 6:02 PM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; 
>Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH 0/8]usb: musb:USB driver changes to use 
>hwmod+ omap-device apis
>
>On 8/6/2010 5:54 PM, HEMA HK wrote:
>> From: Hema HK<hemahk@ti.com>
>>
>> Series of patches to port musb driver to use hwmod and runtime pm
>> APIs for OMAP4 and OMAP3.These patches are tested on OMAP4430SDP and
>> OMAP3630-ZOOM3 boards.
>>
>> The patch 1 and 2 are are the prerequisites for the hwmod changes.
>> Patch 6 is the OMAP3 offmode support patch.
>>
>> This patch series is generated on "origin/pm-wip/hwmods-omap4".
>>
>> Offmode is tested with origin/pm on omap3630 zoom3 board.
>
>The way you are submitting that series is quite confusing!
>
>You are mixing several numbering schemes and several series versions.
>If this is a V2, you have to resubmit everything with a V2, 
>and you must 
>include an history.
>
>[8/8] usb : musb:Using runtime pm apis for musb.  	
>[7/8] : Hwmod api changes
>[V2,6/8] usb: musb: Offmode fix for idle path
>[V2,4/8] usb : musb:Using omap_device_build for musb device 
>registration
>[4/8] usb: musb: HWMOD database structures fixes OMAP4
>[V2,3/4] usb: musb: HWMOD database structures addition for OMAP3
>[2/8] usb: musb: Remove board_data parameter from musb_platform_init()
>[1/8] usb: musb: Adding names for IRQs in resource structure
>
>
>The cover letter does not contain the overall stat to summarize what 
>files you are modifying.
>
>Some spaces are missing after the ":" in the email subjects.

I will take care of this in the next st of patches.

Thanks,
Hema
>
>Regards,
>Benoit
>