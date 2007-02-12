From: "zil iram" <zil_iram@hotmail.com>
Subject: spi clock
Date: Mon, 12 Feb 2007 14:22:29 +0000
Message-ID: <BAY130-F5278FCE69140302B0F1A1F8910@phx.gbl>
References: <000001c74939$32fdb600$98f92200$@lu@serialsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000001c74939$32fdb600$98f92200$@lu@serialsys.com.hk>
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

Hi,
I am developing an SPI Controller driver based on the microwire controller 
in linux2.6.17 for omap.
I used the armxor clock for my spi clock just like the microwire driver. 
However, I am having trouble with setting the frequency for my clock. I am 
looking at the serial document for omap and have been looking at the 
registers for the SPI Master/Slave controller but there is no register where 
I can set the clock's frequency unlike that of the uwire. In the kernel, I 
changed the rate in clk_ref which is the parent of armxor clock from 
12000000 to 500000 just to see if I can set the clock rate but as I probed 
the spi clock pin with the logic analyzer, the clock was still 12000000. I 
just followed the code in the microwire driver to get the clock -- clk_get 
and assigned it to my spi_clock and then enabled the clock in the spi 
register. I could send data through my driver but I just could not set the 
clock frequency to the desired value.

Please help me.

Thanks,
Lizette

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
