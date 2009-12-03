From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Thu, 3 Dec 2009 10:39:58 +0200
Message-ID: <20091203083958.GB31110@nokia.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
 <20091202173321.GA23738@nokia.com>
 <6ed0b2680912021234x6b5e6058p6d50d5cd20ecf019@mail.gmail.com>
 <20091202204946.GB25682@nokia.com>
 <6ed0b2680912021329g372bd0a4vb5b4a80244960f95@mail.gmail.com>
 <20091202215442.GA30658@oksana.dev.rtsoft.ru>
 <20091202223156.GA14921@nokia.com>
 <20091202225922.GA15568@oksana.dev.rtsoft.ru>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57240 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZLCIkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 03:40:39 -0500
Content-Disposition: inline
In-Reply-To: <20091202225922.GA15568@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, Dec 02, 2009 at 11:59:22PM +0100, ext Anton Vorontsov wrote:
>On Thu, Dec 03, 2009 at 12:31:56AM +0200, Felipe Balbi wrote:
>> Hi,
>>
>> On Wed, Dec 02, 2009 at 10:54:42PM +0100, ext Anton Vorontsov wrote:
>> >As for the default USB VBUS current value, it could be Kconfig
>> >option (something alike to USB_GADGET_VBUS_DRAW) and/or module
>> >parameter, or hw default, or hardcoded for now. Either will
>> >work.
>>
>> cannot be Kconfig, it's mandated by usb battery charging spec 1.x to
>> be 100mA for 100ms, then if you don't enumerate, you have to cut
>> charging.
>
>Oh, I thought TWL4030 does the USB stuff somewhat transparently
>so the checks in twl4030_charger_check_vbus() would be enough.
>Is there any TWL4030 reference manual available?

there should be some tpsxxxxx manual available, someone from TI should 
be able to tell us ??

>If TWL4030 just draws the VBUS directly, then it might be a good
>idea to integrate the driver with OTG framework, as an example
>see

thing is that we already have the transceiver driver done... so we have 
to think how to do this properly.

>commit 5bf2b994bfe11bfe86231050897b2d881ca544d9
>Author: Philipp Zabel <philipp.zabel@gmail.com>
>Date:   Sun Jan 18 17:40:27 2009 +0100
>
>    pda_power: Add optional OTG transceiver and voltage regulator support
>
>Though, instead of just a boolean is_usb_online() stuff, you'll
>have to get the allowed current draw value and configure the
>charger appropriately.
>
>Will this work?

yes, that'll work. But how about start charging always with 100mA and if 
userland sees that we were enumerated it reconfigures charging as 
necessary. But this would mean that we have the EM daemon started up 
just after the driver itself is loaded to avoid the problem with 100ms 
no enumeration. How does that sound ? Do we start making some writeable 
power_supply sysfs ???

-- 
balbi
