From: "Wael Adel" <showairovic@gmail.com>
Subject: Gadget Zero testing with OMAP
Date: Wed, 14 Mar 2007 09:33:45 -0400
Message-ID: <bd205c5f0703140633rf8e9efcp40d6e797ca0f4b8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: david-b@pacbell.net, linux-omap-open-source@linux.omap.com, vikram.pandita@ti.com
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

hi all,
Actually, the steps mentioned in USB Linux testing in the following link:
              http://www.linux-usb.org/usbtest/index.html#gadgets
these steps for testing r not vey clear to me, so i will tell u what i
have made:
1. i have connected my pc ,that contain OHCI , to the
OMAP 5912 OSK ,that represent the gadget device using usb cable A-A.

2.i have load the module usbtest on my pc by writting insmod
usbtest.ko, this is for the kernel version 2.6.18 of my pc
3.i have load the omap udc module by writting insmod omap_udc.ko,this
is for the kernel verssion 2.6.19 of my OMAP kit
4.i have load the gadget zero module by writting insmod g_zero.ko,this
is for the kernel verssion 2.6.19 of my OMAP kit

i.e i have load the usbtest module on my pc while i load omap_udc and
g_zero on the kit.
Afterwords i have made the following:

5. i have run test.sh on my pc
but i got the following output:
****************************************
TESTING: control
Wed Mar 14 14:47:46 EDT 2007
**Control test cases:
test 9: ch9 postconfig
FAIL
****************************************
i know there is something wrong i have made but i cant find it.can
anyone please help me?
thanks in advance

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
