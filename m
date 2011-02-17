From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 16:21:47 +0100
Message-ID: <4D5D3D0B.8090106@ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com> <1297946466-9565-7-git-send-email-balbi@ti.com> <4D5D25F9.8030907@ti.com> <20110217151527.GL22356@legolas.emea.dhcp.ti.com> <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58321 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab1BQPVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 10:21:55 -0500
In-Reply-To: <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On 2/17/2011 4:18 PM, Balbi, Felipe wrote:
> On Thu, Feb 17, 2011 at 05:15:27PM +0200, Felipe Balbi wrote:
>> On Thu, Feb 17, 2011 at 02:43:21PM +0100, Cousson, Benoit wrote:
>>> Hi Felipe and Hema,
>>>
>>> Sorry for this late review, but I have a couple of comments on this one.
>>>
>>> Since I was planning to send usb hwmod data file to Tony directly
>>> like I did for the other drivers, I can handle the update myself if
>>> you want.
>>
>> I'll change this particular patch to yours.
>
> doesn't apply:
>
> $ patch -p1<  ~/benoit.diff
> patching file arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> Hunk #1 succeeded at 55 with fuzz 1 (offset -7 lines).
> patch: **** malformed patch at line 42: omap44xx_l4_cfg__l3_main_2 = {
>
> could you base this off of v2.6.38-rc5 ?

This is what I was about to say.
You have a dependency with the for_2.6.39/omap4_hwmod_data branch
in git://gitorious.org/omap-pm/linux.git.

Benoit




