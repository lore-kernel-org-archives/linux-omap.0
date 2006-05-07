From: "Jason Huang" <jason.huang@wescongroup.com>
Subject: RE: How to program flash of custom OMAP board?
Date: Sat, 6 May 2006 17:01:51 -0700
Message-ID: <001f01c67169$722f3900$6c6fa8c0@wescongroup.com>
References: <445c5b32.01f8c5fc.422c.5691@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <445c5b32.01f8c5fc.422c.5691@mx.gmail.com>
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

When you build the u-boot, be sure it is pointing the UART port you are
using.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Li
Weichen
Sent: Saturday, May 06, 2006 1:16 AM
To: 'Woodruff, Richard'; linux-omap-open-source@linux.omap.com
Subject: RE: How to program flash of custom OMAP board?

> For many OMAP-u-boot ports, if you have a JTAG debugger, you can connect
> to the board, initialize clocks & ddr via script, load u-boot into
> memory and execute it.  Now you can download using either your JTAG or
> ether the image you want to burn and use u-boot to burn that image.
> 
But after I load the u-boot and run, it seems not work, only stop at the
beginning of the codes and there is not any information at the UART.

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
