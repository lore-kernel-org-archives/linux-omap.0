From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE:  Zoom2 Support on LO Master broken ?
Date: Tue, 18 Aug 2009 05:28:28 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F969A0AA@dbde02.ent.ti.com>
References: <007301ca1f34$df482c50$LocalHost@wipultra793>
 <008201ca1f35$ae17bf00$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52763 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZHQX6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 19:58:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HNweIB021831
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 18:58:46 -0500
In-Reply-To: <008201ca1f35$ae17bf00$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>"V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hemanth

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
>
>
>>I am unable to boot from quad uart and if I try uart3 I get the below error
>
>For quad uart it stops after downloading kernel (ZOOM2 defconfig), probably
>related to LL_DEBUG setting.

There are couple of problems that I found.
The serial.c has recently changed and hence there is a change required in zoom2-debug file.

And then there is the correct implementation for low level debug uart for zoom2.

I have this work-in-progress patch at:
git://dev.omapzoom.org/pub/scm/vikram/omap3.git zoom2_boot

with this you can boot the zoom2 fine.

Will post the patch series tomorrow. Reference combined patch [1]


[1]
http://dev.omapzoom.org/?p=vikram/omap3.git;a=commitdiff;h=81280ed52d20ef935e926e43d702ddf918d0f13c



>
>>
>> <3>IP-Config: No network devices available.
>> IP-Config: No network devices available.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

