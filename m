From: "xuxian" <lsfdxuxian@gmail.com>
Subject: problems on building root filesystem using
	scratchbox and meamo
Date: Mon, 5 Dec 2005 21:37:39 +0800
Message-ID: <439442af.226665ab.22c5.56c6@mx.gmail.com>
Reply-To: scratchbox-users@lists.scratchbox.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <scratchbox-users-bounces@lists.scratchbox.org>
List-Unsubscribe: <http://lists.scratchbox.org/cgi-bin/mailman/listinfo/scratchbox-users>,
	<mailto:scratchbox-users-request@lists.scratchbox.org?subject=unsubscribe>
List-Archive: <http://lists.scratchbox.org/pipermail/scratchbox-users>
List-Post: <mailto:scratchbox-users@lists.scratchbox.org>
List-Help: <mailto:scratchbox-users-request@lists.scratchbox.org?subject=help>
List-Subscribe: <http://lists.scratchbox.org/cgi-bin/mailman/listinfo/scratchbox-users>,
	<mailto:scratchbox-users-request@lists.scratchbox.org?subject=subscribe>
Sender: scratchbox-users-bounces@lists.scratchbox.org
Errors-To: scratchbox-users-bounces@lists.scratchbox.org
To: maemo-users@maemo.org
Cc: linux-arm@lists.arm.linux.org.uk, linux-omap-open-source@linux.omap.com, scratchbox-users@lists.scratchbox.org
List-Id: linux-omap@vger.kernel.org

Hi all,

I'm using scratchbox and meamo to build my root filesystem. I fallow the
steps shown in the HOWTO: Using flasher and the reference root filesystem.
The link is:
http://www.maemo.org/platform/docs/howtos/howto_use_flasher_rootfs.html
Finally, I got the jffs2 image of my root filesystem and download it to my
board OSK5912 successfully. But I meet the following error messages when
boot the kernel:
............................................................................
 Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.4.1, my address is 192.168.4.190
IP-Config: Complete:
      device=eth0, addr=192.168.4.190, mask=255.255.255.0, gw=192.168.4.1,
     host=192.168.4.190, domain=omap1_eth1, nis-domain=(none),
     bootserver=192.168.4.1, rootserver=192.168.4.1, rootpath=
Node at 0x0062e3b8 with length 0x80001044 would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3bc:
0x1044 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3c0:
0x586d instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3c4:
0x030c instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3c8:
0x001a instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3cc:
0x81a4 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3d4:
0xacc3 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3d8:
0x2317 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3dc:
0x2317 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3e0:
0x2317 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0062e3e4:
0x9000 instead
Further such events for this erase block will not be printed
Node at 0x00630138 with length 0x80000777 would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
Node at 0x006311f8 with length 0x80000f3d would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
Node at 0x00632138 with length 0x80000fe5 would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
Node at 0x00635138 with length 0x8000103f would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
Node at 0x00636178 with length 0x80000045 would run over the end of the
erase block
Perhaps the file system was created with the wrong erase size?
............................................................................

It seems the filesystem can work as NFS, but not stable. It can work once in
three times approximately, and in the other times it can't go further more
when the following messages shown on the console:
............................................................................
Looking up port of RPC 100003/2 on 192.168.0.11
Looking up port of RPC 100005/1 on 192.168.0.11
VFS: Mounted root (nfs filesystem).
Freeing init memory: 120K
............................................................................

My board is OSK5912 and the kernel is omap-linux-2.6.14.
I have had these problems for quite a while, but have never been able to
identify the cause. Dos anyone have experience in it? Any help will be
appreciated. 
Thank in advance.
Best regards.

xuxian
