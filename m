From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: problems on building root filesystem using scratchbox and meamo
Date: Fri, 9 Dec 2005 10:54:41 +0800
Message-ID: <4398f1fe.19db014d.48d8.ffffdf58@mx.gmail.com>
References: <1133993121.8897.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1133993121.8897.4.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Matthew Percival' <matthew@capgo.com>, 'Linux OMAP Open Source' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

What part decides the size of erase block? The hardware, the kernel or the
root filesystem?

Best regards,
xuxian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Matthew
Percival
Sent: Thursday, December 08, 2005 6:05 AM
To: Linux OMAP Open Source
Subject: RE: problems on building root filesystem using scratchbox and meamo

G'Day,

> I use the command:
>   mkfs.jffs2 -p -l -e 0x20000 -n -v -r /home/xuxian/rootfs/fs -o
> filesys.jffs2
> to make the root filesystem image. 

	For my OSK, -e 0x20000 is the correct size; the command I use is
basically the same as you.  

> What size of the erase block will be fine? I can't access the file
/proc/mtd
> because I cannot mount the filesystem. Does the kernel determine the size
of
> erase block or anything else? Where can I set the erase block size?

	If you mount your filesystem as an NFS root rather than an image,
then
you can read /proc/mtd, but I would say you are most likely correct in
your erase size.

	I am not familiar with scratchbox or maemo, so it is possible your
problem relates to them, but I cannot be sure.  Sorry, I probably will
not be of much help here.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
