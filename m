From: "Daan Biere" <webwire@zonnet.nl>
Subject: Re: NFS Bootargs
Date: Wed, 9 Aug 2006 16:45:35 +0200
Message-ID: <002001c6bbc2$793f9f20$0a02a8c0@DAAN>
References: <BAY102-F15BFC0DB6B83849C21C502A9550@phx.gbl>
Reply-To: Daan Biere <webwire@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Abot Botbot <dejanigma@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Abot,
I've set up a nfsroot yesterday for testing a mips based system, i''m using 
the following bootargs:

append ip=dhcp nfsroot="192.168.1.101:/home/usr/projects/filesys" 
init=/bin/sh root=/dev/nfs rw

just be sure you've got all the required depencies in the /lib dir and 
you'll have the /dev/console, i made a little script to do this.


ldd $1 | awk '{ print $3; }' | sed 's/\(\/.*\/\(.*\)\)/\1 \2/g' -\
| xargs -l1 --no-run-if-empty cp

go to the lib dir and type something like "lddcopy /bin/bash" it would copy 
all the required libs.

Kind Regards,
Daan Biere
----- Original Message ----- 
From: "Abot Botbot" <dejanigma@hotmail.com>
To: <linux-omap-open-source@linux.omap.com>
Sent: Wednesday, August 09, 2006 4:26 PM
Subject: NFS Bootargs


> Hello all,
>
>
>    I'm trying to boot off an NFS share as laid out in the OSK Users guide 
> so I can begin my software development process. My buidling of the system 
> with the approrpiate makefiles has all gone seamlessly. I am attempting to 
> boot from the NFS share on my linux machine, which I've demonstrated is 
> possible from a neighboring machine. The error is as follows:
>
> Kernel panic: No init found.  Try passing init= option to kernel.
>
> I have tried putting an "init=/bin/sh" argument into the bootargs string, 
> but that hasn't solved the problem. Does anyone else have a bootargs 
> string for an NFS share that they have used succesfully? Here is the 
> string I am currently using for refference:
>
> console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs 
> nfsroot=192.168.1.101:/home/usr/projects/filesys,nolock mem=30M 
> init=/bin/sh
>
> Thanks for your help,
> Andy
>
> _________________________________________________________________
> Don't just search. Find. Check out the new MSN Search! 
> http://search.msn.click-url.com/go/onm00200636ave/direct/01/
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source 
