From: "Ishigami, Tatsuya" <ishigami@ti.com>
Subject: RE: How to program flash of custom OMAP board?
Date: Mon, 8 May 2006 01:58:06 -0500
Message-ID: <772F5D89C5E0734B8A86D85DFC6A202403346834@dlee03.ent.ti.com>
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
To: Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

 If you find no message on the UART, is the u-boot running
on the DDR or Flash?

 If you mean the latter, the number of device errata may
impact your design.

	http://focus.ti.com/lit/er/sprz209h/sprz209h.pdf
	(see page 30)

 If I remember correctly, the u-boot must be re-configured to =20
include the 28F256J3 driver (while the single MTD driver supports
28F128J3 & 28F256J3 in Linux).

 BTW, this product already supports the OMAP5912 +=20
28F256J3C, and all the behind-sence things will be done=20
automatically by pressing the single button.

	http://www.sophia.com/Products/EJ-Writer.html


 The board below (OMAP5912 + 28F256J3) is programmed
the bootloader with this tool.

	http://www.losteaka.com/omap_e.htm

 Good luck.

 regards,
  Ishigami

-----Original Message-----
From: Jason Huang
Sent: Sunday, May 07, 2006 9:02 AM
To: linux-omap-open-source@linux.omap.com
Subject: RE: How to program flash of custom OMAP board?

When you build the u-boot, be sure it is pointing the UART port you are
using.

-----Original Message-----
From: Behalf Of Li Weichen
Sent: Saturday, May 06, 2006 1:16 AM
To: 'Woodruff, Richard'; linux-omap-open-source@linux.omap.com
Subject: RE: How to program flash of custom OMAP board?

> For many OMAP-u-boot ports, if you have a JTAG debugger, you can
connect
> to the board, initialize clocks & ddr via script, load u-boot into
> memory and execute it.  Now you can download using either your JTAG or
> ether the image you want to burn and use u-boot to burn that image.
>=20
But after I load the u-boot and run, it seems not work, only stop at the
beginning of the codes and there is not any information at the UART.

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
