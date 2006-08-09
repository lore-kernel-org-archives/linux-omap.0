From: Mark Howell <mhowell@northlink.com>
Subject: Re: NFS Bootargs
Date: Wed, 09 Aug 2006 16:45:47 -0700
Message-ID: <44DA73AB.4050104@northlink.com>
References: <BAY102-F15BFC0DB6B83849C21C502A9550@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY102-F15BFC0DB6B83849C21C502A9550@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Abot Botbot <dejanigma@hotmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Abot Botbot wrote:
> Hello all,
> 
> 
>    I'm trying to boot off an NFS share as laid out in the OSK Users 
> guide so I can begin my software development process. My buidling of the 
> system with the approrpiate makefiles has all gone seamlessly. I am 
> attempting to boot from the NFS share on my linux machine, which I've 
> demonstrated is possible from a neighboring machine. The error is as 
> follows:
> 
> Kernel panic: No init found.  Try passing init= option to kernel.
> 
> I have tried putting an "init=/bin/sh" argument into the bootargs 
> string, but that hasn't solved the problem. Does anyone else have a 
> bootargs string for an NFS share that they have used succesfully? Here 
> is the string I am currently using for refference:
> 
> console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs 
> nfsroot=192.168.1.101:/home/usr/projects/filesys,nolock mem=30M 
> init=/bin/sh
> 
> Thanks for your help,
> Andy
> 
[snip]

Andy, this is a working NFS boot string for my 1611 H2 with today's git 
kernel:

mem=32M console=ttyS0,115200n8 noinitrd root=/dev/nfs rw 
nfsroot=172.30.2.32:/home/markh/omap/nfsroot ip=dhcp

Cheers,

Mark.
