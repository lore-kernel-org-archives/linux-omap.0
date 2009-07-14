From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: How to checkout v2.6.31-rc3 using git
Date: Wed, 15 Jul 2009 01:33:55 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45077 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbZGNUEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 16:04:07 -0400
In-Reply-To: <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>Sent: Tuesday, July 14, 2009 2:57 PM
>To: Pandita, Vikram
>Cc: Linux OMAP Users
>Subject: Re: How to checkout v2.6.31-rc3 using git
>
>Hi Vikram,
>			Thanks for the reply.
>
>On Jul 14, 2009, at 11:49 PM, Pandita, Vikram wrote:
>
>>>
>>
>> L-O seems to be still on v2.6.31-rc1
>> Use: $git tag -l
>>
>> Looks like tony has not synce'd up with rc2/3 yet.
>>
>> If you need the new rc, then you could use kernel.org git.
>> Not sure what is your use case.
>
>I'm trying to port android kernel sources to v2.6.31, to better take
>advantage of power management support for the gumstix overo. I've
>managed to complete the port of android-2.6.29, but power management
>is not very stable with v2.6.29.

If your requirement is a good PM, then the best place is kevin's pm branch I guess.

http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
head: pm 


>
>Best regards,
>
>Elvis
>

