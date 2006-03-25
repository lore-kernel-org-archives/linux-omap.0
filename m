From: "Laihui,Sun" <laihui.ece93g@nctu.edu.tw>
Subject: usb camera: Unable to open /dev/video on omap5912
Date: Sat, 25 Mar 2006 21:08:49 +0800
Message-ID: <006101c6500d$41e261f0$dc96718c@bluecan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
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

Hi everyone,

Recently, I am working on the usb camera on omap5912.=20
I use the kernel 2.6.15 with path patch-2.6.15-omap2.

I fellow the oskfordummies.hp.infoseek.co.jp also but still can't work.

/ # mknod /dev/video0 c 81 0
/ # ln -s /dev/video0 /dev/video

/ # hexdump -v -n 100 /dev/video0
hexdump: /dev/video0: No such device
hexdump: /dev/video0: Bad file descriptor

/ # webcam t.jpg
Error : Unable to open /dev/video
: No such device

There is report in dmesg, saying:
/ # dmesg | grep sn9c102
sn9c102: V4L2 driver for SN9C10x PC Camera Controllers v1:1.24a
usbcore: registered new driver sn9c102

and

/ # dmesg | grep usb
USB: hmc 16, usb0 2 wires
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbmon: debugfs is not available
usb 1-1: new full speed USB device using ohci and address 2
usbcore: registered new driver sn9c102
usb 1-1.3: new full speed USB device using ohci and address 3

And I try to insmod the videodev.ko in omap5912,

/ # insmod ./videodev.ko
Using ./videodev.ko
Linux video capture interface: v1.00
video_dev: unable to get major 81
insmod: cannot insert `./videodev.ko': Input/output error (-1): =
Input/output err

It looks like stuck on the /dev/video.

Does somebody ever happen it or open the /dev/video....
Please explain this problem for me.....

Thank you very much.



Sun, Lai-Hui
