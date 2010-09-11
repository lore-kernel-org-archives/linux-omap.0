From: Felipe Balbi <balbi@ti.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Sat, 11 Sep 2010 17:21:53 +0300
Message-ID: <20100911142152.GA2547@legolas.emea.dhcp.ti.com>
References: <20100910174814.6e5d439e@surf>
 <20100910170053.GB2230@legolas.emea.dhcp.ti.com>
 <20100910204713.61e002bc@surf>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab0IKOV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Sep 2010 10:21:57 -0400
Content-Disposition: inline
In-Reply-To: <20100910204713.61e002bc@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Sep 10, 2010 at 01:47:13PM -0500, Thomas Petazzoni wrote:
>> On Fri, Sep 10, 2010 at 10:48:14AM -0500, Thomas Petazzoni wrote:
>> >I also have a problem with USB support, both on linux-omap and
>> >Kevin's pm-core branch. My USB Ethernet adapter, supported by the
>> >asix driver, isn't detected anymore. With a pm git tree of a couple
>> >of weeks ago, it was working. This is again with just a plain
>> >omap3_defconfig.
>>
>> is it attached to EHCI/OHCI or musb port ?
>
>It's a normal USB Ethernet adapter that is attached to the EHCI/OCHI
>port of the BeagleBoard. I have a revision C3.

Would you have any debugging dumps to share ? What shows up on dmesg
after you attach the device ? (please clear the message ring buffer
before attaching the device with dmesg -c).

-- 
balbi
