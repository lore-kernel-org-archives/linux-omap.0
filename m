From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8]usb: musb:USB driver changes to use hwmod+ omap-device apis
Date: Mon, 09 Aug 2010 13:58:01 -0700
Message-ID: <87ocdbijvq.fsf@deeprootsystems.com>
References: <1281110052-28990-1-git-send-email-hemahk@ti.com>
	<4C5FF544.9050907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43387 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab0HIU6D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 16:58:03 -0400
In-Reply-To: <4C5FF544.9050907@ti.com> (Benoit Cousson's message of "Mon, 09
	Aug 2010 14:32:04 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: HEMA HK <hemahk@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 8/6/2010 5:54 PM, HEMA HK wrote:
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
> The way you are submitting that series is quite confusing!
>
> You are mixing several numbering schemes and several series versions.
> If this is a V2, you have to resubmit everything with a V2, and you
> must include an history.
>
> [8/8] usb : musb:Using runtime pm apis for musb.  	
> [7/8] : Hwmod api changes
> [V2,6/8] usb: musb: Offmode fix for idle path
> [V2,4/8] usb : musb:Using omap_device_build for musb device registration
> [4/8] usb: musb: HWMOD database structures fixes OMAP4
> [V2,3/4] usb: musb: HWMOD database structures addition for OMAP3
> [2/8] usb: musb: Remove board_data parameter from musb_platform_init()
> [1/8] usb: musb: Adding names for IRQs in resource structure
>
>
> The cover letter does not contain the overall stat to summarize what
> files you are modifying.

Please consider using git-format-patch + git-send-email which will
automatically take care of many of the problems Benoit has pointed out.

Please see this wiki page for lots of useful suggestions:

http://wiki.omappedia.org/wiki/Releasing_to_Linux_kernel_using_patches_and_emails

Kevin
