From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: undefined instruction
Date: Thu, 26 Jun 2008 20:59:09 +0530
Message-ID: <a1d91fa0806260829l6953e0b6o754b00b632efae47@mail.gmail.com>
References: <a1d91fa0806250029x2bf114f5t2f45bb1472e96fbb@mail.gmail.com>
	 <7B4574D56E4ADF438756313E9A172A8708CFE66C@dlee01.ent.ti.com>
	 <a1d91fa0806260406q25815d09hd66a1784dbcf58a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:29490 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbYFZP3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 11:29:11 -0400
Received: by ti-out-0910.google.com with SMTP id b6so68460tic.23
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 08:29:09 -0700 (PDT)
In-Reply-To: <a1d91fa0806260406q25815d09hd66a1784dbcf58a1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: omap <linux-omap@vger.kernel.org>

Hi,

I tried to do the same procedure with a small filesystem image <
16Mb... it worked. i didnt have such problems. so could someone please
tell me how to divide the filesystem image in to two and flash it?
thank you,
regards,
shareef

On Thu, Jun 26, 2008 at 4:36 PM, mohammed shareef <mdshareef@gmail.com> wrote:
> Hi,
>
> i did the below. i got an image. but i am still having the same problem
>
> my file size is 23Mb
>
> [root@localhost tftpboot]# mkfs.jffs2 --squash -r /data/rootfs2.6
> -e131072 > /data/rootfs-jffs2.img
> [root@localhost tftpboot]# cp /data/rootfs-jffs2.img /tftpboot/rootfs-jffs2.img
>
> \0x09 #################################################################
> \0x09 #############undefined instruction
> pc : [<e0000004>]    lr : [<00000002>]
> sp : 1103fca4  ip : 11095dd8  fp : 00000001
> r10: 10963410  r9 : 1103fd24  r8 : 1103ffdc
> r7 : 270a30a1  r6 : 8695632d  r5 : 08016ffa  r4 : 5aebcc39
> r3 : 00000032  r2 : 11095dd4  r1 : 000000a0  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
> Resetting CPU ...
>
> could you please tell me what i should do. thank you.
> regards,
> Shareef
>
>
>
> On Wed, Jun 25, 2008 at 9:52 PM, Hunter, Jon <jon-hunter@ti.com> wrote:
>>> then i changed the filename and the
>>> tftpboot transfer started. But on the mid-way it complains  "undefined
>>> instruction".
>>>
>>> could some one please tell me where the problem is? thank you.
>>
>>
>> How big is the file that you are attempting to download over tftp?
>>
>> U-boot executes in the upper part of the RAM and so if your file is too big, then there is a good chance you are overwriting u-boot which would cause u-boot to crash eventually. U-boot does not protect against this. This would be a potential cause of an undefined instruction exception.
>>
>> Jon
>>
>
