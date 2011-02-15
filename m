From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/5 v6] OMAP2+: musb: HWMOD adaptation for musb. registration
Date: Tue, 15 Feb 2011 08:12:11 -0800
Message-ID: <87r5b9uvj8.fsf@ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
	<1297346881-13438-5-git-send-email-hemahk@ti.com>
	<87vd0mw3u9.fsf@ti.com>
	<20110215083235.GG2570@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51814 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171Ab1BOQMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:12:15 -0500
In-Reply-To: <20110215083235.GG2570@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Tue, 15 Feb 2011 10:32:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hema HK <hemahk@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi Felipe,

Felipe Balbi <balbi@ti.com> writes:

> On Mon, Feb 14, 2011 at 04:15:10PM -0800, Kevin Hilman wrote:
>> Hema HK <hemahk@ti.com> writes:
>> 
>> > Using omap_device_build API instead of platform_device_register for
>> > OMAP2430,OMAP34xx and OMAP4430 musb device registration.
>> > The device specific resources defined in centralized
>> > database will be used.
>> 
>> Except for AM35x.
>> 
>> NACK, for same reasons as previous version of this patch.
>
> Does it really make sense to hold on omap2plus HWMOD conversion because
> of AM35x ? I mean, I understand it would be better to get all fixed up,
> but loose another merge window for that ?
>
> Can we get omap2plus in and AM35x on the next merge window ? At least
> omap2plus would have been converted to hwmod and would be using
> pm_runtime as we want.

Well, you get to decide as you're the maintainer of this stuff. ;)

If you merge it, I suggest at least fixing the changelog to make it
clear that not all devices are using hwmod. 

That being said, how difficult is it to add the hwmod data for the AM35x
OTG block?   Just added it to the exising OMAP3 data using CHIP_IS* to
marke it as AM35x, and you can at least get rid of the base address and
IRQ number hacks for AM35x in this code.

Separating out the pdata function pointer hooks is a different matter
which is also ugly, but I don't feel as strongly about.

Kevin




