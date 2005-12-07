From: Matthew Percival <matthew@capgo.com>
Subject: RE: problems on building root filesystem using scratchbox and meamo
Date: Thu, 08 Dec 2005 09:05:21 +1100
Message-ID: <1133993121.8897.4.camel@localhost.localdomain>
References: <43967db0.2fc92d15.13f7.2f8f@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43967db0.2fc92d15.13f7.2f8f@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

> I use the command:
>   mkfs.jffs2 -p -l -e 0x20000 -n -v -r /home/xuxian/rootfs/fs -o
> filesys.jffs2
> to make the root filesystem image. 

	For my OSK, -e 0x20000 is the correct size; the command I use is
basically the same as you.  

> What size of the erase block will be fine? I can't access the file /proc/mtd
> because I cannot mount the filesystem. Does the kernel determine the size of
> erase block or anything else? Where can I set the erase block size?

	If you mount your filesystem as an NFS root rather than an image, then
you can read /proc/mtd, but I would say you are most likely correct in
your erase size.

	I am not familiar with scratchbox or maemo, so it is possible your
problem relates to them, but I cannot be sure.  Sorry, I probably will
not be of much help here.

	-- Matthew
