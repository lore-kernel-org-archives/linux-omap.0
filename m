From: "Rix, Tom" <trix@ti.com>
Subject: RE: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Fri, 28 Aug 2009 11:26:27 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A8788CC35FF@dlee01.ent.ti.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>,<20090827140617.GA30917@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60792 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbZH1Qe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 12:34:29 -0400
In-Reply-To: <20090827140617.GA30917@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Petazzoni <mpetazzoni@mvista.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The bootloader perspective..

The minimum set needed are for xloader, u-boot and the environment. 
xloader is very static.
u-boot at 1.25m should be big enough
environment is very static and should be big enough..
This is consistent with the bootloader.

The rest can be done with mtdparts and the differences between ldp and zoom2
flash layout can be separated in their respective environment files. 

The bootloader flashing utility 'fastboot' depends on the kernel layout.
There is a change pending to decouple using an mtdparts-like mechanism. 
See 'Runtime Partitions' toward the bottom of..

https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=FAQ-8%3A+Zoom-II+Android%C2%A0fastboot

Tom

________________________________________
From: Maxime Petazzoni [mpetazzoni@mvista.com]
Sent: Thursday, August 27, 2009 9:06 AM
To: Pandita, Vikram
Cc: Singh, Vimal; linux-omap@vger.kernel.org; Rix, Tom
Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions

Hi,

* Pandita, Vikram <vikram.pandita@ti.com> [2009-08-27 19:16:27]:

> Why?
>
> I know of an implementation by Vimal Singh that introduces a common
> flash file for Zoom1 and Zoom2.
> There is reuse of code there.

Thanks for your comments.

There are indeed other implentations around using a common flash file
for Zoom1 and Zoom2 boards. I didn't know of this specific
implementation by Vimal Singh, but we use something very similar
internally.

Since linux-omap didn't had any MTD partitions definitions for either
boards, I decided to go for the smallest change: only partitions for
Zoom2.

> Please discuss and get a converged approach on handling NAND
> partitions on Zoom1 and Zoom2.

Agreed. We should use a common file for Zoom1 and Zoom2 flash, with
Zoom2 specific partition sizes. But I'm not sure I deserve the right to
propose Vimal Singh's patch (by the way, why hasn't it been merged in
the linux-omap tree?). How should we proceed then?

> Also the Systerm/User/Cache partition definitions are more from Android perspective.
>
> Given that each system may have a different NAND partition requirement,
> have you looked at bootargs passing the MTD partition info: Eg:
>
> mtdparts=omap2-nand.0:512k@0(xloader),\
> 1536k@512k(bootloader),\
> 29m@2m(kernel),\
> 160m@32m(system),\
> 32m@192m(userdata),\
> 32m@224m(cache)

Yes, I am aware of the mtdparts command line arguments, which works
great. I think a "default", sensible partition layout for the Zoom2
would be nice though.

- Maxime

--
Maxime Petazzoni
Linux kernel & software dev
MontaVista Software, Inc
