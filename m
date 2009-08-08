From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Sat, 8 Aug 2009 10:33:32 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5988EC8@dbde02.ent.ti.com>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
	 <1249665817.11736.21.camel@blitz>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>,<1249672953.11736.76.camel@blitz>
 <19F8576C6E063C45BE387C64729E739404322AA355@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52479 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZHHFDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 01:03:53 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404322AA355@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Peter Barada <peterb@logicpd.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Gupta, Ajay Kumar
>Sent: Friday, August 07, 2009 10:04 PM
>To: Peter Barada; Pandita, Vikram
>Cc: Gadiyar, Anand; linux-omap
>Subject: RE: Question regarding MUSB and dynamic fifo sizing
>
>
>Please try using below patch,
>http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
>2.6.git;a=commitdiff;h=743821717c611913a5a3f95010b141f0b4cb5463
>
>This will solve the problem for host only driver but for otg build driver Vbus will be switched off
>as of now we don't have any entry to revive it.We use to start session and Vbus using
>$echo  F >/proc/driver/musb_hdrc but now that proc entry is gone and equivalent debugfs
>entry is suppose to come.

The sysfs entry is already there and working like charm - 

echo "otg" > /sys/devices/platform/musb_hdrc/mode


>
>I would suggest to pull in all musb specific patches from mainline tree into your driver or move
>to a newer kernel version.
