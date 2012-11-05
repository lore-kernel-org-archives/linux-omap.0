From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 00/10] ARM: dts: AM33XX: Add device tree data
Date: Mon, 5 Nov 2012 17:37:45 +0100
Message-ID: <5097EB59.8070104@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EA647CE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40514 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab2KEQiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 11:38:03 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA647CE@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Hi Anil,

On 11/05/2012 02:46 PM, AnilKumar, Chimata wrote:
> On Mon, Nov 05, 2012 at 16:15:40, AnilKumar, Chimata wrote:
>> Add device tree date for GPIO based various drivers matrix keypad,
>> volume keys, push buttons and use leds accross three AM33XX devices
>> viz EVM, BeagleBone and Starter Kit.
>>
>> To make it functional this series also adds pinctrl data for all
>> the GPIOs used by various drivers. In this series only default state
>> pinmux/conf settings are added because of sleep/idle state pinctrl
>> values are not available.
>>
>> These patches are based on linux-omap-dt:for_3.8/dts tree and these
> 
> My bad, small correction in this statement, these patches apply cleanly
> on linux-omap-dt:for_3.8/dts tree with the below two patches.
> http://www.spinics.net/lists/arm-kernel/msg204872.html
> http://www.spinics.net/lists/arm-kernel/msg204873.html

Mmm, this 2 patches do have dependency on some driver changes that might
not be accepted for 3.8. And in fact I do have some comment on the RTC
one :-)
Don't you prefer to change the order to allow me to pull these ones first?

Thanks,
Benoit

