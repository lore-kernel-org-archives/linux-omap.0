From: Matthew Percival <matthew@capgo.com>
Subject: Re: problems on building root filesystem using scratchbox and meamo
Date: Tue, 06 Dec 2005 09:11:26 +1100
Message-ID: <1133820686.8836.2.camel@localhost.localdomain>
References: <439442af.226665ab.22c5.56c6@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <439442af.226665ab.22c5.56c6@mx.gmail.com>
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

> Perhaps the file system was created with the wrong erase size?

	Could you share the command you used to make the filesystem image?  It
seems likely you did not use the correct erase size. Try this command:
		# cat /proc/mtd
It will tell you the correct erase block size.  If you used a size
different to this (mkfs.jffs2 -e 0x####) then you will get errors like
you have seen here.

	-- Matthew
