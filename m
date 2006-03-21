From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: Problems building DSP gateway on 2.6.15
Date: Tue, 21 Mar 2006 09:21:34 -0000
Message-ID: <001001c64cc8$d911a420$642aa8c0@BUFFY>
References: <20060320180002.1755A8062C@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060320180002.1755A8062C@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

=20

I have just built 2.6.15 kernel with 2.6.15-omap1 patch. I included the =
DSP
gateway support in my "make xconfig" stage. I downloaded the utils and =
apps
from sourceforge for dspgateway 3.3 and built those successfully. I am =
using
Uboot 1.1.1 to setup my 5912 OSK board and then downloading the kernel =
and a
ramdisk via JTAG to target memory. Console is via serial port and =
minicom to
my host PC. My ramdisk is created with:

=20

set -x

SIZE=3D8192

DEV=3D/dev/ram

ROOTFS=3D/usr/src/5912/rootfs2.6

/sbin/mkfs.ext2 $DEV $SIZE

mount -t ext2 $DEV /mnt/ram

cd $ROOTFS

cp -av . /mnt/ram

df /dev/ram

umount /mnt/ram

dd if=3D$DEV bs=3D1k count=3D$SIZE | gzip -9 > ramdisk.image.gz

chmod 666 ramdisk.image.gz

=20

=20

 I try to do: dspctl load ex_task.out but it tells me that:

=20

Warning: none of /sys/devicesplatform/dsp.0/ifver,
/sys/devices/platform/dsp0..

(DSP Gateway driver is too old or not loaded)

open control device: No such file or directory.

=20

In /sys/devices/platform I have: i2c_omap.1, omap_mcbsp.1, omapflash.0,
serial8250.0, omap-keyboard, omap_t2, power, smc91x, omap_cf, omapfb,
serial8250 and uevent.

=20

In /dev I have: console, tty, tty0 and ttyS0

=20

lsmod shows no modules loaded.

=20

I'm sure I have missed a step along the way here but I can't find it. =
Can
someone point me in the right direction please?

=20

Thanks,

=20

Richard.
