From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: undefined instruction
Date: Thu, 26 Jun 2008 13:33:20 -0500
Message-ID: <4863E0F0.7070905@css-design.us>
References: <a1d91fa0806250029x2bf114f5t2f45bb1472e96fbb@mail.gmail.com>	 <7B4574D56E4ADF438756313E9A172A8708CFE66C@dlee01.ent.ti.com>	 <a1d91fa0806260406q25815d09hd66a1784dbcf58a1@mail.gmail.com>	 <a1d91fa0806260829l6953e0b6o754b00b632efae47@mail.gmail.com>	 <4863BFCB.9040105@css-design.us>	 <a1d91fa0806260929h19e7c5k2173d4df63f53fa3@mail.gmail.com> <a1d91fa0806261040x669cdffwc93855b17afce32e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:46607 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753072AbYFZSda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2008 14:33:30 -0400
In-Reply-To: <a1d91fa0806261040x669cdffwc93855b17afce32e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>

Mohammed,

This is the correct approach.  As long as you avoid anything below 
0x240000, you avoid touching u-boot and the kernel.   I suggest to turn 
protect off only for the sectors needed.  The sectors/addresses depends 
upon your flash.  If you are using the OSK, then these are told in the 
OSK newbie guide (I can't recall and our flash is different). 

For the OSK, the filesystem is at 0x240000.  Therefore, you transfer the 
first file to 0x240000 and the next file transfers to 0x240000 + 
0xc00000 (E40000).   This is purely a memory copy.   You don't need to 
combine.   When you place the two pieces next to each other, they are 
basically combined.  

I'm not sure you understand this, but when you use tftp, you are copying 
the file to SDRAM.   This address is fixed for the OSK at 0x10000000.   
Therefore the steps are:

1) tftp part 1 into memory 0x10000000
2) copy the memory of 0x10000000 to 0x240000
3) tftp part 2 into memory 0x10000000
4) copy the memory of 0x10000000 to 0xE40000
5) Reset the board (You could boot from here if you wish, but a reset is 
simpler and puts the flash back to protected)

Steve

mohammed shareef wrote:
> i erased location 0x240000 to 0x1ffffff;
> then i transfered the first file to location 0x240000, the size of the
> first image was c00000 (12Mb)
> but now i have the second image on RAM of osk.
> the flash segment for ffs2 filesystem runs from 0x01000000 till
> 0x0fffffff(please correct me if i am wrong).  i dont know to which
> location on flash to transfer this to. could someone please help me on
> this. thank you. and i also have doubts on how to combine the two
> images on the flash and make it tun. thannk you.
> regards,
> Shareef
>
> On Thu, Jun 26, 2008 at 9:59 PM, mohammed shareef <mdshareef@gmail.com> wrote:
>   
>> Dear Steve,
>>
>> i split the file into two pieces:
>>
>> split rootfs-jffs2.img --bytes=12m
>>
>> so i have two files with xaa(12Mb) and xab(11.5Mb)
>>
>> i was ablt to transfer the first file completely with any problem.
>>  but i dont know what to do next. should i transfer the first image in
>> RAM to flash? could you please tell me how many sectors i need erase
>> and from which bank? i am afraid that i may end up erasing the u-boot.
>> thank you.
>> regards,
>> Shareef
>>
>> On Thu, Jun 26, 2008 at 9:41 PM, Steve Poulsen <spoulsen@css-design.us> wrote:
>>     
>>> Mohammed,
>>>
>>> When you tftp the file to memory, you need to make sure the filesize fits in
>>> the memory available.  Since you have experimentally done that and now want
>>> to flash the pieces, I suggest you look at the "split" command under Linux.
>>>   You will need to split the file into pieces that fit into RAM and flash at
>>> the proper address.  If you split the file into two pieces, then you will
>>> need to flash the first piece at address X and the second piece at address X
>>> + 16meg.  You should make sure you split the file on a sector boundary.   If
>>> you don't want to think about this, then you should erase/unprotect the
>>> whole area you will need first, then transfer and flash the pieces. You may
>>> want to look at the omapfl utility.   With some modification, you could
>>> flash your image more easily via USB.
>>>
>>> Steve
>>>
>>> mohammed shareef wrote:
>>>       
>>>> Hi,
>>>>
>>>> I tried to do the same procedure with a small filesystem image <
>>>> 16Mb... it worked. i didnt have such problems. so could someone please
>>>> tell me how to divide the filesystem image in to two and flash it?
>>>> thank you,
>>>> regards,
>>>> shareef
>>>>
>>>> On Thu, Jun 26, 2008 at 4:36 PM, mohammed shareef <mdshareef@gmail.com>
>>>> wrote:
>>>>
>>>>         
>>>>> Hi,
>>>>>
>>>>> i did the below. i got an image. but i am still having the same problem
>>>>>
>>>>> my file size is 23Mb
>>>>>
>>>>> [root@localhost tftpboot]# mkfs.jffs2 --squash -r /data/rootfs2.6
>>>>> -e131072 > /data/rootfs-jffs2.img
>>>>> [root@localhost tftpboot]# cp /data/rootfs-jffs2.img
>>>>> /tftpboot/rootfs-jffs2.img
>>>>>
>>>>> \0x09 #################################################################
>>>>> \0x09 #############undefined instruction
>>>>> pc : [<e0000004>]    lr : [<00000002>]
>>>>> sp : 1103fca4  ip : 11095dd8  fp : 00000001
>>>>> r10: 10963410  r9 : 1103fd24  r8 : 1103ffdc
>>>>> r7 : 270a30a1  r6 : 8695632d  r5 : 08016ffa  r4 : 5aebcc39
>>>>> r3 : 00000032  r2 : 11095dd4  r1 : 000000a0  r0 : 00000000
>>>>> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
>>>>> Resetting CPU ...
>>>>>
>>>>> could you please tell me what i should do. thank you.
>>>>> regards,
>>>>> Shareef
>>>>>
>>>>>
>>>>>
>>>>> On Wed, Jun 25, 2008 at 9:52 PM, Hunter, Jon <jon-hunter@ti.com> wrote:
>>>>>
>>>>>           
>>>>>>> then i changed the filename and the
>>>>>>> tftpboot transfer started. But on the mid-way it complains  "undefined
>>>>>>> instruction".
>>>>>>>
>>>>>>> could some one please tell me where the problem is? thank you.
>>>>>>>
>>>>>>>               
>>>>>> How big is the file that you are attempting to download over tftp?
>>>>>>
>>>>>> U-boot executes in the upper part of the RAM and so if your file is too
>>>>>> big, then there is a good chance you are overwriting u-boot which would
>>>>>> cause u-boot to crash eventually. U-boot does not protect against this. This
>>>>>> would be a potential cause of an undefined instruction exception.
>>>>>>
>>>>>> Jon
>>>>>>
>>>>>>
>>>>>>             
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>         
>>>       
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

