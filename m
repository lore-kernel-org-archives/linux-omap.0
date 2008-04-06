From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [android-internals] Re: Android on Nokia n810 (OMAP2420)
Date: Sun, 06 Apr 2008 09:41:26 +0200
Message-ID: <47F87EA6.6050504@googlemail.com>
References: <2a9ba570-9005-4eed-8f1a-f45c909f9fe3@m36g2000hse.googlegroups.com>  <f6c5b8d90804020736m3d80fef9h2d377aea7fab52bf@mail.gmail.com>  <0b2d3f9c-e29a-406a-ac8d-d8589d457a0f@m36g2000hse.googlegroups.com>  <0b799c72-1a04-4224-8307-18b7ab10d17f@b5g2000pri.googlegroups.com>  <9a810d71-bc48-4bab-8ad6-93ebc310a110@z38g2000hsc.googlegroups.com>  <999ed349-dc22-4db4-a679-60511d9339f7@a23g2000hsc.googlegroups.com>  <9ff5cf01-f4aa-4560-b71e-bb948a69d9b9@t54g2000hsg.googlegroups.com>  <9583cd73-79d6-4f4e-b5a3-e27c4f165993@p39g2000prm.googlegroups.com>  <105bd206-af76-4fbb-affa-6fc8efdf6133@59g2000hsb.googlegroups.com> <f6e0615c-d180-4a3e-a112-c5320cde1cfd@c65g2000hsa.googlegroups.com> <47F7B240.2070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:24044 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYDFHgj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 03:36:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so889636fgb.17
        for <linux-omap@vger.kernel.org>; Sun, 06 Apr 2008 00:36:37 -0700 (PDT)
In-Reply-To: <47F7B240.2070901@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Georges.Toth@gmail.com
Cc: linux-omap@vger.kernel.org

Nishanth Menon wrote:
> Looping in OMAP ML to the good news..
> Congrats!
> sim0nx said the following on 04/05/2008 06:35 AM:
> 
>>I can't believe it !!!
>>Android runs on the maemo n810 !!!

Great!

Do you have some screenshots we can add to

http://elinux.org/Android_on_OMAP#Screenshots

?

Anything else we should add/correct at

http://elinux.org/Android_on_OMAP

?

Thanks

Dirk

Btw: Do you have any power management issues like

http://elinux.org/Android_on_OMAP#Power_management

? We still don't know anything about them :(

>>After reading this:
>>http://groups.google.lu/group/android-internals/browse_thread/thread/93570c41bce07f16?hl=en
>>for the 100th time, and following the instructions on the mentioned
>>link:
>>http://nemustech.blogspot.com/2007/12/android-porting-to-real-target-hw.html
>>it works.
>>
>>Here are the specifics I've implemented:
>>* patch /etc/init.rc
>>---- begin : init.rc
>>....
>>## qemu-init {
>>## exec /etc/qemu-init.sh
>>## }
>>network-property {
>>exec /etc/set_network.sh
>>}
>>
>>
>>/bin/chmod -R a+rw /data /tmp
>>/bin/chmod a+rw .
>>/bin/chmod -R a+rw data
>>
>># rm /dev/log (if you have)
>># mkdir /dev/log;touch /dev/log/{main,events,radio}
>>* you can see usefull infos from strace log and /dev/log/main
>>
>>and instead of:
>>chroot . /a.sh
>>I execute the android init process:
>>chroot . /init
>>
>>Not sure yet what exactly of those steps solved the problem (maybe the
>>qemu one), but it does work.
>>After a quick try I see that the touchscreen doesn't work (the
>>keyboard does though), but that shouldn't be too hard to fix.
>>
>>BTW, this is using an m5 kernel, and binder.c
>>--~--~---------~--~----~------------~-------~--~----~
>>You received this message because you are subscribed to the Google Groups "Android Internals" group.
>>To post to this group, send email to android-internals@googlegroups.com
>>To unsubscribe from this group, send email to android-internals-unsubscribe@googlegroups.com
>>For more options, visit this group at http://groups.google.com/group/android-internals?hl=en
>>-~----------~----~----~----~------~----~------~--~---
>>
>>
>>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


