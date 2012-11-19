From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Mon, 19 Nov 2012 13:17:59 +0100
Message-ID: <87r4nplrbc.fsf@dell.be.48ers.dk>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
	<1353067706-29491-2-git-send-email-anilkumar@ti.com>
	<87a9udn9xo.fsf@dell.be.48ers.dk>
	<331ABD5ECB02734CA317220B2BBEABC13EA760FD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44332 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab2KSMS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 07:18:26 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so2801599wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 04:18:24 -0800 (PST)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA760FD@DBDE01.ent.ti.com>
	(Chimata AnilKumar's message of "Mon, 19 Nov 2012 11:36:57 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, Colin Foe-Parker <colin.foeparker@logicpd.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>>>>> "A" == AnilKumar, Chimata <anilkumar@ti.com> writes:

Hi,

 >> I don't feel this property name is very clear. Perhaps something about
 >> power button or push button monitor as it is called in the datasheet?

 A> Here I am writing "TPS65217_STATUS_OFF" to status register, BIT(7).
 A> Description of this bit field: "OFF bit. Set this bit to 1 to enter
 A> OFF state when PWR_EN pin is pulled low. Bit is automatically reset
 A> to 0."

 A> PWR_EN pin pull-down is doing by RTC module.

Ahh yes, sorry -ENOCOFFEE. I somehow misread the datasheet and looked at
bit 0 instead.

-- 
Bye, Peter Korsgaard
