From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: FW:
Date: Fri, 16 Mar 2007 10:34:28 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08002B66C76@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Steve Poulsen <spoulsen@css-design.us>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


You can take help from the following for OMAP 5912... considering
someone has already working setup.=20

-----Original Message-----
From: Wael Adel [mailto:showairovic@gmail.com]=20
Sent: Thursday, March 15, 2007 5:05 PM
To: Pandita, Vikram; david-b@pacbell.net
Cc: linux-usb-devel@lists.sourceforge.net
Subject:=20

hi all,
i have sent u this mail once and
there is no answer, i have made a progress on testing gadgetfs on OMAP
5912 OSK.

i have made the following steps:
1. connect my pc to the OMAP kit using usb cable A-A.
2.load the omap_udc module by writting:  insmod omap_udc.ko
3.i have made a directory gadget in /dev by writting: mkdir /dev/gadget
4.i load the gadgetfs module by writting: insmod gadgetfs.ko
5.i run the test of usb.c which represents a user-space gadget driver
and i got the following output:
************************************************************************
*********
gadgetfs: bound to omap_udc driver
/dev/gadget/omap_udc ep0 configured
serial=3D"502r2qdbv272wh4puv3gadgetfs: suspended from state 2
2wy2o5m3cumr"
SUSPEND
udc: USB reset done, gadget gadgetfs
gadgetfs: suspended from state 2
SUSPEND
udc: USB reset done, gadget gadgetfs
gadgetfs: connected
CONNECT full speed
udc: USB reset done, gadget gadgetfs
SETUP 80.06 v0300 i0000 255
SETUP 80.06 v0302 i0409 255
SETUP 80.06 v0301 i0409 255
gadgetfs: configuration #3
SETUP 80.06 v0303 i0409 255
SETUP 00.09 v0003 i0000 0
CONFIG #3
simple_source_thread open ep1in error 2 (No such file or directory)
simple_sink_thread open ep1out error 2 (No such file or directory)
SETUP 80.06 v0304 i0409 255
SETUP 80.06 v0305 i0409 255
************************************************************************
**********************************
how can i make each endpoint appears as a single file?
please anyone answer me?
thanks in advance.
