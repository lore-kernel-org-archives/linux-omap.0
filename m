From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 25 Apr 2012 14:33:21 +0200
Message-ID: <4F97EF11.4020300@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com> <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com> <4F97B891.1020601@ti.com> <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com> <4F97E243.6000500@ti.com> <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37074 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2DYMd0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 08:33:26 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9FDA47@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 4/25/2012 2:26 PM, Hiremath, Vaibhav wrote:
> On Wed, Apr 25, 2012 at 17:08:43, Cousson, Benoit wrote:
>> On 4/25/2012 12:20 PM, Hiremath, Vaibhav wrote:
>>> On Wed, Apr 25, 2012 at 14:10:49, Cousson, Benoit wrote:
>>
>> ...
>>
> <snip>
>>
>>> How would I know the rate of this clock in driver? Say for example, I want
>>> to configure my internal divider based on input rate?
>>> OR
>>> I want to change the rate of dss_clk itself?
>>> OR
>>> Looking at debugfs, would I get the rate of dss_clk?
>>
>> No because that clock will not exist anymore, but you will have the real
>> clock rate from the "dss_dss_clk".
>>
>
> Thanks Benoit, I think I understand your perspective on Module Vs leaf node
> and now able to digest as well.
> Probably Last Q, which I think clarify all my doubts,
>
> Assume we have complete hwmod instance and built a device using
> omap_device_build() api, and also the driver is completely using runtime pm
> api's,
> How can driver get the clk handle (required to get the rate)?
> Is there any api already available for this?

The omap_device fmwk will auto-magically create a "fck" clkdev entry for 
the main_clk.

The API is thus the standard: clk_get(dev, "fck"), to get the clock 
handle and then you can use the other clock API.

The idea is to enforce the usage of clock alias local to the device and 
not trying anymore to get the real clock name. It thus allows driver to 
work on various variant / revision without having to modify the driver.

The fmwk will also create clock alias for any opt_clock present in the 
hwmod.

Regards,
Benoit


