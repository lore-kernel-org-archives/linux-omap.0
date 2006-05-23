From: "prafulla chandra" <prafulla@Math.net>
Subject: osk hanging after uncompressing the kernel
Date: Tue, 23 May 2006 07:58:55 -0700
Message-ID: <20060523075855.5C8C6A62@resin02.mta.everyone.net>
Reply-To: prafulla@Math.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

Hi,
i followed newbie guide instructions also. i have made changes like thins in my makefile below condition is already present so i have not made any changes.
ifeq ($(CONFIG_ARCH_OMAP),y)
OBJS += head-omap.o
endif
and Then coming to head-omap.S it also contains the below condition with only that immediate value difference i changed that immediate value as 
mov r7 ,#(MACH_TYPE_OMAP_OSK & 0xff00 ) to 
mov r7, #(MACH_TYPE_OMAP_OSK & 0xf) and 
orr r7, r7, #(MACH_TYPE_OMAP_OSK & 0xff00) to
orr r7, r7, #(MACH_TYPE_OMAP_OSK & 0xf) and recompiled then also same problem it is hanging after decompressing the kernel . but using the same uboot i have ported my linux successfully . then at that time i have not got any error why is it so ?? where could be the problem is it really a problem with uboot ???
regards
prafulla 

_____________________________________________________________
Get your free web-based e-mail account from http://www.Math.net
Your online tourguide of Mathematics, with books, links, news,
message boards, and much more!
