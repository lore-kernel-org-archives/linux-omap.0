From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: problems on building root filesystem using scratchbox and meamo
Date: Wed, 7 Dec 2005 14:14:01 +0800
Message-ID: <43967db0.2fc92d15.13f7.2f8f@mx.gmail.com>
References: <1133820686.8836.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1133820686.8836.2.camel@localhost.localdomain>
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

Hi Matthew,

I use the command:
  mkfs.jffs2 -p -l -e 0x20000 -n -v -r /home/xuxian/rootfs/fs -o
filesys.jffs2
to make the root filesystem image. 
Several weeks ago, I mad a filesystem image use the same command without
scratchbox and maemo, and it work quite well. So I guess if the problem had
something to do with the scratchbox and maemo?
What size of the erase block will be fine? I can't access the file /proc/mtd
because I cannot mount the filesystem. Does the kernel determine the size of
erase block or anything else? Where can I set the erase block size?

Thank you and best regards

xuxian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Matthew
Percival
Sent: Tuesday, December 06, 2005 6:11 AM
To: Linux OMAP Open Source
Subject: Re: problems on building root filesystem using scratchbox and meamo

G'Day,

> Perhaps the file system was created with the wrong erase size?

	Could you share the command you used to make the filesystem image?
It
seems likely you did not use the correct erase size. Try this command:
		# cat /proc/mtd
It will tell you the correct erase block size.  If you used a size
different to this (mkfs.jffs2 -e 0x####) then you will get errors like
you have seen here.

	-- Matthew

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
