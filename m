From: Andrea Scian - DAVE Simply Embedded <andrea.scian@dave.eu>
Subject: Re: RFC: PATCH TI81xx fix MUSB software mode setting
Date: Tue, 19 Jun 2012 08:55:00 +0200
Message-ID: <4FE02244.6020006@dave.eu>
References: <464859D4BE03A84686BA47749242C1D03EA93DED@DBDE01.ent.ti.com> <6C6B28D4DC342643927BEAFCE8707BF63E9B104D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.dave-tech.it ([2.229.21.40]:45386 "EHLO mx.dave-tech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab2FSHB6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 03:01:58 -0400
In-Reply-To: <6C6B28D4DC342643927BEAFCE8707BF63E9B104D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "B, Ravi" <ravibabu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Dear Ravi,

>>
>> Dear all,
>>
>> when configuring our platform (DM8148 based) to work with
>> USB0 as device and USB1 as host I've found some problems.
>
> It seems that you created the patch against the ti-psp release, there
> is another way to achieve this (one port as host and other port as device).

Yes you are correct, I'm using ti-psp by cloning this tree:

http://arago-project.org/git/projects/linux-omap3.git

> Please refer to release/user's guide.

I've looked here:

http://processors.wiki.ti.com/index.php/Usbgeneralpage#One_port_as_host_and_other_port_as_Gadget_.28for_DM81XX.29

but this setup does not work.

Both ports starts from "b_idle" state and always stay there.
I've try both software setting and from hardware pin (I've left ID pin 
floating for USB0, device, and set ID pin to gnd for USB1, host only) 
without success.
However if I configure both port as host or device (thus disabling OTG 
support) they work correctly (of course, only the device port works as 
device and host port as host in either case ;-) )

> Moreover, you should create a patch against mainline, where the musb_dsps.c is
> used instead of ti81xx.c, where there is no host-only or device-only mode, by
> default OTG mode is used.
>

Ok, but I've found here:

http://processors.wiki.ti.com/index.php/TI81XX_USB_Driver_User_Guide#OTG_support_.28TI816X.2FTI814X.2FTI813x.29

that OTG is not supported for TI81xx.
Am I wrong? Maybe the situation is different in the mainline?

Best Regards and thank for you prompt answer,

Andrea
