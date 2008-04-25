From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Android on N810 File System Problem
Date: Fri, 25 Apr 2008 21:36:06 +0300
Message-ID: <20080425183605.GA27479@kedavra.cpe.vivax.com.br>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53946 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbYDYSem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 14:34:42 -0400
Content-Disposition: inline
In-Reply-To: <48116F5C.9040009@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

On Fri, Apr 25, 2008 at 07:42:52AM +0200, Dirk Behme wrote:
> Jonathan,
>
> CCing OMAP mailing list, there are more people to help.
>
> Jonathan Herriott wrote:
>> Hi,
>>
>> I'm trying to get android installed on an N810.  I have successfully
>> installed the kernel, 
>
> Which kernel (2.6.x, x == ?)  do you use on N810? If I remember  
> correctly, with N810 people use an older kernel than the one coming with 
> Android SDK.
>
>> but I am having major issues with the file
>> system.  I followed the tutorial you provided at
>> http://elinux.org/Android_on_OMAP, but I get a segmentation fault when
>> I try to init the kernel.  I made sure to use the same android SDK
>> version that was used to patch the kernel.
>>
>> My steps for reproduction are:
>>
>> 1) On my computer, unpack the ramdisk image to a folder.
>> 2) Untar system, dev, and data to the unpacked ramdisk image.
>> 3) Tar up the patched file system and scp it to /opt on the device.
>> Ssh to the device and unpack the file system in /opt
>> 4) Run umask 000 && chroot /opt/android /init
>> 5) Receive a segmentation fault.
>
> Can you send us the complete segementation fault output?

Current linux-omap's head has all the necessary pieces to get n810
working. Touchscreen, keypad, ambient light sensor, led, usb, everything
is there.

Maybe it's easier to get android's patches on top of current linux-omap
?

but anyway, it seems that you don't have android's fs support on your
kernel... Are you getting a "VFS: could not mount root" or something
like that?

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
