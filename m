From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: Zoom2: provide default MTD partitions
Date: Thu, 27 Aug 2009 19:38:49 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CF8@dbde02.ent.ti.com>
References: <1251374386-6733-1-git-send-email-mpetazzoni@mvista.com>
 	<FCCFB4CDC6E5564B9182F639FC35608702F9A44CDF@dbde02.ent.ti.com>
 <ce9ab5790908270703o2ffd4b32kce208b87d3e69044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37865 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbZH0OJZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 10:09:25 -0400
In-Reply-To: <ce9ab5790908270703o2ffd4b32kce208b87d3e69044@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: Maxime Petazzoni <mpetazzoni@mvista.com>, "Singh, Vimal" <IMCEAEX-_O=TI_OU=BD_cn=Recipients_cn=x0094262@dlee86.itg.ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Rix, Tom" <trix@ti.com>

Vimal

>-----Original Message-----
>From: vimal singh [mailto:vimal.newwork@gmail.com]
>Sent: Thursday, August 27, 2009 9:03 AM
>To: Pandita, Vikram
>Cc: Maxime Petazzoni; Singh, Vimal; linux-omap@vger.kernel.org; Rix, Tom
>Subject: Re: [PATCH] OMAP3: Zoom2: provide default MTD partitions
>
>Hi,
>>
>> Also the Systerm/User/Cache partition definitions are more from Android perspective.
>>
>> Given that each system may have a different NAND partition requirement,
>> have you looked at bootargs passing the MTD partition info: Eg:
>>
>> mtdparts=omap2-nand.0:512k@0(xloader),\
>> 1536k@512k(bootloader),\
>> 29m@2m(kernel),\
>> 160m@32m(system),\
>> 32m@192m(userdata),\
>> 32m@224m(cache)


What about this bootargs nand partition specification approach? 


>>
>>
>> Lets discuss the final approach on this list and try to close this soon.
>>
>> Thnx
>>
