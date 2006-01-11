From: Kevin Hilman <khilman@mvista.com>
Subject: MMC as a module: rmmod w/mounted FS succeeds
Date: Tue, 10 Jan 2006 17:05:17 -0800
Message-ID: <43C459CD.4080406@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

When using the MMC driver as a module, I am able to do an rmmod of the MMC
driver while a FS is mounted on it.  There must be something missing in the
OMAP MMC driver in terms of proper registration.

Note that after the mount, the usecount for the MMC driver is still zero, thus
the rmmod succeeds.  Any ideas?

Kevin

root@omap1623h2:~# uname -r
2.6.15-omap1-g165e0bcd
root@omap1623h2:~# lsmod
Module                  Size  Used by
root@omap1623h2:~# modprobe omap
root@omap1623h2:~# mmcblk0: mmc0:0001 SDR128 125408KiB
 mmcblk0: unknown partition table

root@omap1623h2:~# mknod /dev/mmcblk0 b 254 0
root@omap1623h2:~# lsmod
Module                  Size  Used by
omap                   11176  0
root@omap1623h2:~# mount -t ext2 /dev/mmcblk0 /media/mmc
root@omap1623h2:~# ls -l /media/mmc
total 12
drwx------  2 root root 12288 Jan  1 00:03 lost+found
root@omap1623h2:~# lsmod
Module                  Size  Used by
omap                   11176  0
root@omap1623h2:~# rmmod omap

Followed by a crash.
