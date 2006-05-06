From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: How to program flash of custom OMAP board?
Date: Sat, 6 May 2006 16:15:41 +0800
Message-ID: <445c5b32.01f8c5fc.422c.5691@mx.gmail.com>
References: <EA12F909C0431D458B9D18A176BEE4A5058CDD50@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5058CDD50@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> For many OMAP-u-boot ports, if you have a JTAG debugger, you can connect
> to the board, initialize clocks & ddr via script, load u-boot into
> memory and execute it.  Now you can download using either your JTAG or
> ether the image you want to burn and use u-boot to burn that image.
> 
But after I load the u-boot and run, it seems not work, only stop at the
beginning of the codes and there is not any information at the UART.
