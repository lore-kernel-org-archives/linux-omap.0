From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Sat, 8 Aug 2009 08:34:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404322AA355@dbde02.ent.ti.com>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
	 <1249665817.11736.21.camel@blitz>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>,<1249672953.11736.76.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48160 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932931AbZHHDE1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 23:04:27 -0400
In-Reply-To: <1249672953.11736.76.camel@blitz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

>Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
>thumbdrive plugged in, and then modprobe the driver, it finds the
>thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
>multiple times, and each time it is enumerated.

>If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
>musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
>enumerated.
>Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
>boot for it to enumerate the thumbdrive?

It seems Vbus is off and thus nothing is detected.
There is already a fix for this (at least for host only driver) in mainline but as 
you are using v2.6.28-rc8 that fix is not in your driver.

Please try using below patch,
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=743821717c611913a5a3f95010b141f0b4cb5463

This will solve the problem for host only driver but for otg build driver Vbus will be switched off 
as of now we don't have any entry to revive it.We use to start session and Vbus using
$echo  F >/proc/driver/musb_hdrc but now that proc entry is gone and equivalent debugfs
entry is suppose to come.

I would suggest to pull in all musb specific patches from mainline tree into your driver or move
to a newer kernel version.

-Ajay
--
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

