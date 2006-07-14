From: Vladimir Vassilev <vladimir@logicom-bg.com>
Subject: Issues with camera interface on OMAP 5912.
Date: Fri, 14 Jul 2006 09:21:47 +0300
Message-ID: <44B737FB.8070604@logicom-bg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello,

We are trying to get the camera interface on OMAP 5912 (OSK) running 
(using 2.6.16-omap1 kernel). The following reasons for this not to work 
were discovered (in chronological order):

1. The call to clk_enable(clk_get(0, "armper_ck")); inside 
omap16xx_cam_init returned 0 which later on caused division by zero 
exception. After investigating this we noticed the clock "armper_ck" 
used is not declared anywhere. grep returns nothing except a few other 
references to it, but no declaration ( there is no reference in
linux-2.6.16-omap1/arch/arm/mach-omap1/clock.h).

2. The camera interface register block is not at 0x0xFFFB6800 as in the 
16xx version (H2), but either on 0x2007D800 or 0x3007D800 as in 17xx 
(H3) this is being set wrong for OSK and the production silicon version 
of the chip (Actually the C revision of the 5912 had 0xFFFB6800 
specified as the address and this has changed in the D revision which is 
the production version.). However just changing the address results in a 
memory access violation and a crash as soon as the register is accessed. 
This is fixed after a ioremap is called. Finally we managed to get the 
external clock generation out.

I wonder if someone else has already done this and has a working patch. 
Otherwise we hope to get any help available and provide such patch to 
the community after we cleanup our fixes.

Regards,
Vladimir
