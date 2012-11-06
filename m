From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 00/10] ARM: dts: AM33XX: Add device tree data
Date: Tue, 6 Nov 2012 04:33:44 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA64E4C@DBDE01.ent.ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA647CE@DBDE01.ent.ti.com>
 <5097EB59.8070104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51643 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2KFEeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 23:34:00 -0500
In-Reply-To: <5097EB59.8070104@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Mon, Nov 05, 2012 at 22:07:45, Cousson, Benoit wrote:
> Hi Anil,
> 
> On 11/05/2012 02:46 PM, AnilKumar, Chimata wrote:
> > On Mon, Nov 05, 2012 at 16:15:40, AnilKumar, Chimata wrote:
> >> Add device tree date for GPIO based various drivers matrix keypad,
> >> volume keys, push buttons and use leds accross three AM33XX devices
> >> viz EVM, BeagleBone and Starter Kit.
> >>
> >> To make it functional this series also adds pinctrl data for all
> >> the GPIOs used by various drivers. In this series only default state
> >> pinmux/conf settings are added because of sleep/idle state pinctrl
> >> values are not available.
> >>
> >> These patches are based on linux-omap-dt:for_3.8/dts tree and these
> > 
> > My bad, small correction in this statement, these patches apply cleanly
> > on linux-omap-dt:for_3.8/dts tree with the below two patches.
> > http://www.spinics.net/lists/arm-kernel/msg204872.html
> > http://www.spinics.net/lists/arm-kernel/msg204873.html
> 
> Mmm, this 2 patches do have dependency on some driver changes that might
> not be accepted for 3.8. And in fact I do have some comment on the RTC
> one :-)
> Don't you prefer to change the order to allow me to pull these ones first?
> 

Today I will resend the patches by removing this dependency.

Thanks
AnilKumar 

