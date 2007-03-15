From: "Wael Adel" <showairovic@gmail.com>
Subject: Is there anyone can help?
Date: Thu, 15 Mar 2007 07:32:39 -0400
Message-ID: <bd205c5f0703150432m7523edbdm359eb7ff0f9d232d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

hi all,
i have sent u this mail once and
there is no answer, i have made a progress on testing gadgetfs on OMAP 5912 OSK.

i have made the following steps:
1. connect my pc to the OMAP kit using usb cable A-A.
2.load the omap_udc module by writting:  insmod omap_udc.ko
3.i have made a directory gadget in /dev by writting: mkdir /dev/gadget
4.i load the gadgetfs module by writting: insmod gadgetfs.ko
5.i run the test of usb.c which represents a user-space gadget driver
and i got the following output:
*********************************************************************************
gadgetfs: bound to omap_udc driver
/dev/gadget/omap_udc ep0 configured
serial="502r2qdbv272wh4puv3gadgetfs: suspended from state 2
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
**********************************************************************************************************
how can i make each endpoint appears as a single file?
please anyone answer me?
thanks in advance.
