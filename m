From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: Re: NFS Bootargs
Date: Fri, 11 Aug 2006 15:06:41 +0000
Message-ID: <BAY102-F252592CB572C827127438A94B0@phx.gbl>
References: <000501c6bcb1$88fcf3f0$0a02a8c0@DAAN>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000501c6bcb1$88fcf3f0$0a02a8c0@DAAN>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: webwire@zonnet.nl
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Daan,

   Got it to work. Certainly was the version of the NFS service that came 
with my Cento OS distro.

Thanks for your help!
Andy


>From: "Daan Biere" <webwire@zonnet.nl>
>Reply-To: "Daan Biere" <webwire@zonnet.nl>
>To: "Abot Botbot" <dejanigma@hotmail.com>
>Subject: Re: NFS Bootargs
>Date: Thu, 10 Aug 2006 21:16:51 +0200
>
>Hey,
>It does matter :), i had the problem too, you''ll have to use the 
>nfs-user-server.
>My /etc/exports is as follows:
>
>/160GB/ris/nfsroot 192.168.2.0/255.255.255.0(rw,no_root_squash,sync)
>
>Kind Regards,
>Daan Biere
>----- Original Message ----- From: "Abot Botbot" <dejanigma@hotmail.com>
>To: <linux-omap-open-source@linux.omap.com>
>Sent: Thursday, August 10, 2006 4:28 PM
>Subject: Re: NFS Bootargs
>
>
>>Hello all,
>>
>>   I suspect now the problem is on my linux machine hosting the NFS serv. 
>>Is there a significant difference between an NFS share being served in 
>>user mode or kernel mode? I just learned of these different modes reading 
>>up on some unrelated documentation. I can mount my NFS share on other 
>>systems just fine, but i suspect that doesn't guarantee the board will be 
>>able to boot off it. I am running CentOS 3.6, which came with an nfs 
>>service, which is what I'm using for this. Are all NFS services created 
>>equal and does the mode (user or kernel) matter for this task?
>>
>>Thanks,
>>Andy
>>
>>
>>>From: Mark Howell <mhowell@northlink.com>
>>>To: Abot Botbot <dejanigma@hotmail.com>
>>>CC: linux-omap-open-source@linux.omap.com
>>>Subject: Re: NFS Bootargs
>>>Date: Wed, 09 Aug 2006 16:45:47 -0700
>>>
>>>Abot Botbot wrote:
>>>>Hello all,
>>>>
>>>>
>>>>    I'm trying to boot off an NFS share as laid out in the OSK Users 
>>>>guide so I can begin my software development process. My buidling of the 
>>>>system with the approrpiate makefiles has all gone seamlessly. I am 
>>>>attempting to boot from the NFS share on my linux machine, which I've 
>>>>demonstrated is possible from a neighboring machine. The error is as 
>>>>follows:
>>>>
>>>>Kernel panic: No init found.  Try passing init= option to kernel.
>>>>
>>>>I have tried putting an "init=/bin/sh" argument into the bootargs 
>>>>string, but that hasn't solved the problem. Does anyone else have a 
>>>>bootargs string for an NFS share that they have used succesfully? Here 
>>>>is the string I am currently using for refference:
>>>>
>>>>console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs 
>>>>nfsroot=192.168.1.101:/home/usr/projects/filesys,nolock mem=30M 
>>>>init=/bin/sh
>>>>
>>>>Thanks for your help,
>>>>Andy
>>>>
>>>[snip]
>>>
>>>Andy, this is a working NFS boot string for my 1611 H2 with today's git 
>>>kernel:
>>>
>>>mem=32M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw 
>>>nfsroot=172.30.2.32:/home/markh/omap/nfsroot ip=dhcp
>>>
>>>Cheers,
>>>
>>>Mark.
>>>
>>
>>_________________________________________________________________
>>Express yourself instantly with MSN Messenger! Download today - it's FREE! 
>>http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
>>
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
