From: Nishanth Menon <nm@ti.com>
Subject: Re: BeagleBoard stops at booting kernel with 2.6.37-rc5
Date: Thu, 16 Dec 2010 14:28:36 -0600
Message-ID: <4D0A7674.40009@ti.com>
References: <D76728EE-7818-4236-83E9-B32045714912@mac.com> <AANLkTim1vzFpdOjBNDXT2cofUAS4=_G7+QtTKZdw0xDv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59474 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756470Ab0LPU2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 15:28:41 -0500
Received: by gyg8 with SMTP id 8so1819485gyg.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 12:28:39 -0800 (PST)
In-Reply-To: <AANLkTim1vzFpdOjBNDXT2cofUAS4=_G7+QtTKZdw0xDv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Robert Nelson had written, on 12/16/2010 02:25 PM, the following:
> On Thu, Dec 16, 2010 at 2:19 PM, Elvis Dowson <elvis.dowson@mac.com> wrote:
>> Hi,
>>        I'm working with linux mainline 2.6.37-rc5 and my custom beagleboard based platform stops at booting the kernel. Is there a fix for this?
>>
>> reading uImage
>>
>> 2432692 bytes read
>> Booting from mmc ...
>> ## Booting kernel from Legacy Image at 82000000 ...
>>   Image Name:   Linux-2.6.37-rc5
>>   Image Type:   ARM Linux Kernel Image (uncompressed)
>>   Data Size:    2432628 Bytes =  2.3 MB
>>   Load Address: 80008000
>>   Entry Point:  80008000
>>   Verifying Checksum ... OK
>>   Loading Kernel Image ... OK
>> OK
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>>
> 
> If it stops there, double check your bootarg's as with 2.6.37+ you
> might be using the omap-serial vs the old generic serial driver...
> "ttyO2" (O in Omap) vs "ttyS2"..

one more thing: in fs - getty dependency might exist - you could choose 
something similar to what I did on my bare busybox install:
http://nishanthmenon.blogspot.com/2010/10/tired-of-ttysx-and-ttyox.html

-- 
Regards,
Nishanth Menon
