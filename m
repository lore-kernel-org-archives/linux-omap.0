From: Liem Pham Tan <tanliemph@gmail.com>
Subject: Re: Help: OMAP5912 RS232 dies after kernel uncompressing.
Date: Mon, 15 Jan 2007 23:05:41 +0700
Message-ID: <45ABA655.60001@gmail.com>
References: <000601c738b8$f7f0cd80$0700a8c0@NADHHLT01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000601c738b8$f7f0cd80$0700a8c0@NADHHLT01>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: JSievers@NADINE-Software.com
Cc: 'Linux OMAP List' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

hi Juergen,
please re-check that there is no gaps in the "console=ttyS0,115200n8". If you write "console=ttyS0,_115200n8", the rs232 connection seems to be dead.
BR,
Liem Pham


> Hello. 
>
> After I modified the environment by using setenv/saveenv I got the following
> problem.
>
> The terminal connected to the OMAP5912 rs232 at 115200n8 is working as long
> as the kernel is uploaded and decompressing. The last message shown is
> ".booting."
>
> After that message the rs232 line seems to be dead.
>
> The kernel is mounting its root from nfs-server and is running normally
> except the console device could be used.
>
> I tried several kernels (2.6.16/2.6.19) including the pre-build kernel 2.4
> from the distribution CD All the same, the rs232 line dies after
> uncompressing the kernel.
>
> My bootags setting are:
>
> Bootargs = "mem=32 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw
> nfsroot=192.168.0.50:/nfsroot"
>
> Has anybody an idea what I could do to get back my rs232 console ?
>
> Regards
>
> Juergen
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
