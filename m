From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Android on N810 File System Problem
Date: Fri, 25 Apr 2008 07:42:52 +0200
Message-ID: <48116F5C.9040009@googlemail.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:40545 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbYDYFnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 01:43:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1396927nfb.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 22:42:59 -0700 (PDT)
In-Reply-To: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Herriott <herriojr@gmail.com>
Cc: linux-omap@vger.kernel.org

Jonathan,

CCing OMAP mailing list, there are more people to help.

Jonathan Herriott wrote:
> Hi,
> 
> I'm trying to get android installed on an N810.  I have successfully
> installed the kernel, 

Which kernel (2.6.x, x == ?)  do you use on N810? If I remember 
correctly, with N810 people use an older kernel than the one coming 
with Android SDK.

> but I am having major issues with the file
> system.  I followed the tutorial you provided at
> http://elinux.org/Android_on_OMAP, but I get a segmentation fault when
> I try to init the kernel.  I made sure to use the same android SDK
> version that was used to patch the kernel.
> 
> My steps for reproduction are:
> 
> 1) On my computer, unpack the ramdisk image to a folder.
> 2) Untar system, dev, and data to the unpacked ramdisk image.
> 3) Tar up the patched file system and scp it to /opt on the device.
> Ssh to the device and unpack the file system in /opt
> 4) Run umask 000 && chroot /opt/android /init
> 5) Receive a segmentation fault.

Can you send us the complete segementation fault output?

Regards

Dirk


