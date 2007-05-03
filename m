From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Last call for bug fixes before 2.6.21-omap1 will be tagged
Date: Thu, 3 May 2007 15:28:37 +0530
Message-ID: <5d5443650705030258q100df4e7g66dc07962431c036@mail.gmail.com>
References: <20070502182859.GK3520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070502182859.GK3520@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/2/07, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> I'm planning to tag 2.6.21-omap1 on Friday so let's make sure most of
> the boards run fine. If you have any pending bug fixes for 2.6.21,
> now it's time to send them.
>

OMAP2430 defconfig build failure for USB.

-------------------------snip----------------------------
In file included from drivers/usb/musb/plat_uds.c:109:
drivers/usb/musb/musbdefs.h:67:31: error: asm/arch/hdrc_cnf.h: No such
file or directory
drivers/usb/musb/plat_uds.c: In function 'fifo_setup':
drivers/usb/musb/plat_uds.c:944: error: 'MUSB_C_RAM_BITS' undeclared
(first use in this function)
drivers/usb/musb/plat_uds.c:944: error: (Each undeclared identifier is
reported only once
drivers/usb/musb/plat_uds.c:944: error: for each function it appears in.)
drivers/usb/musb/plat_uds.c: In function 'ep_config_from_table':
drivers/usb/musb/plat_uds.c:1068: error: 'MUSB_C_RAM_BITS' undeclared
(first use in this function)
make[2]: *** [drivers/usb/musb/plat_uds.o] Error 1
make[1]: *** [drivers/usb/musb] Error 2
-------------------------snip----------------------------

-- 
--Trilok Soni
