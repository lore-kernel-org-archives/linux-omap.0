From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: How to implement JFFS2 filesystem on NAND
Date: Mon, 7 May 2007 07:01:10 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429EAA69D@dlee13.ent.ti.com>
References: <42E999AD7A0E4647BF159F467EE4FBCB017B50DF@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-class: urn:content-classes:message
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCB017B50DF@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: sathish.madhava@wipro.com, linux-omap-open-source@linux.omap.com
Cc: linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> 
> VFS: Mounted root (jffs2 filesystem).
> 
> Freeing init memory: 124K
> 
> Warning: unable to open an initial console.
> 
> /sbin/init exit code: -2
> 
> /etc/init exit code: -2
> 
> /bin/init exit code: -2
> 
> /bin/sh exit code: -2
> 
> Kernel panic - not syncing: No init found.  Try passing init= option
to
> kernel.

Looks like your file system has no device nodes in /dev.

For older kernels devfs would allow this to work.  On newer ones you
need all your nodes, or a properly configured udev, and some hotplug
support.

Regards,
Richard W.

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
