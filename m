From: barban@openhandsetdevelopers.com
Subject: Re: Android on OMAP
Date: Wed, 14 May 2008 18:47:41 -0500
Message-ID: <20080514184741.at5z36mpxcw4oc44@openhandsetdevelopers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server28.01domain.net ([74.86.116.172]:50938 "EHLO
	server28.01domain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbYEOBHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 21:07:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dirk.behme@googlemail.com

Hi Dirk & all you OMAP experts,
I have reached this mailing list by investigating the very interesting
results you achieved concerning Android on OMAP.

>> The whole Filesystem is about 28MBytes in bz2 format.
>> I don't know where can I upload it. I can not find some place where  
>>   can hold such big file for a long time.
>> I am glad to upload it , if someone has the network storage resources.

I don't know if you have already found a good place for collecting the
stuff related to your work: if not, I would be glad to offer you
network storage as well as other facilities you can need at
www.OpenHandsetDevelopers.com

At the moment, you can find in my site a directory which collects
applications for Android to be used on the emulator and discussion
boards for a community of developers interested in the Android
platform and Android devices.

Do not hesitate to contact me, just in case it can be useful to create  
a specific category/section for your work.

Best regards and enjoy with Android!

Andrea, owner of OpenHandsetDevelopers.com




> skyflame wrote:
>>>> Hi
>>>>
>>>> I move to m5-r14 with both kernel driver and filesystem grabed    
>>>> from the sdk.
>>>> Now, I can enter the homescreen , and the keyboard is also working 8 )
>>>>
>>>> I don't do anything extra than what I am doing on the m3-r14 release.
>>>
>>>
>>> Great! Congratulations! :)
>>>
>>> Do you think you can make the kernel patch (against 2.6.23-omap1?)  
>>>   and the filesystem available somewhere? Then we can link wiki   
>>> page  to it.
>>>
>>> Dirk
>>>
>>>
>>
>> Hi Dirk
>>
>> I was working on a 2.6.21 kernel. For I don't got a working 2.6.23   
>>  kernel on hand.
>> The git tree kernel don't work fine with my omap2430SDP V5.0
>> The PMIC seems not working in the right way, thus the LCD don't run up.
>> So I can not make the diff over 2.6.23 omap1  : (
>
> Okay. I sent my 2.6.23 omap1 Android patch yesterday (seems that it
> didn't reach the list cause of > 100k). If you didn't get it I can
> send it again in private mail. Would be quite nice if you could check
> if there are the same files in it you used.
>
> Anything like
>
> cat my_patch | grep +++ > file1
> cat your_patch | grep +++ > file2
> kdiff3 file1 file2
>
>> The whole Filesystem is about 28MBytes in bz2 format.
>> I don't know where can I upload it. I can not find some place where  
>>   can hold such big file for a long time.
>> I am glad to upload it , if someone has the network storage resources.
>
> As already mentioned yesterday: Same to me ;)
>
> Anybody with ~30-40 MB permanent public storage?
>
> Many thanks
>
> Dirk



