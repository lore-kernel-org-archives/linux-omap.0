From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 21 May 2006 05:23:04 -0700 (PDT)
Message-ID: <20060521122304.18242.qmail@web37909.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A505B7DBDC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A505B7DBDC@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> Our current internal tree one does the following in board_2430.c for
> ether.
> 
> 
> void sdp_reset (void)
> {
> #define LAN_RESET_REGISTER (H4_DEBUG_FPGA_VA_BASE+0x1c)
> 	int cnt = 20;
> 
> 	__raw_writew(0x0, LAN_RESET_REGISTER);
> 	do {
> 		__raw_writew(0x1, LAN_RESET_REGISTER);
> 		udelay (100);
> 		if(cnt == 0)
> 			goto sdp_reset_err_out;
> 		--cnt;
> 	} while (__raw_readw(LAN_RESET_REGISTER) != 0x1);
> 
> 	cnt = 20;
> 
> 	do {
> 		__raw_writew(0x0, LAN_RESET_REGISTER);
> 		udelay (100);
> 		if(cnt == 0)
> 			goto sdp_reset_err_out;
> 		--cnt;
> 	} while (__raw_readw(LAN_RESET_REGISTER) != 0x0000);
> 	udelay (400);
>  sdp_reset_err_out:
> 	return;
> }
> 
> static int __init smc91x_init(void)
> {
> 	sdp_reset();
> 
> 	if ((omap_request_gpio(ETH_GPIO)) < 0) {
> 		printk("%s: unable to request GPIO for smc91x\n", 
> 		       __FUNCTION__);
> 		return -1;
> 	} else {
> 		omap_set_gpio_direction(ETH_GPIO, OMAP24XX_DIR_INPUT);
> 		omap_set_gpio_edge_ctrl(ETH_GPIO, OMAP_GPIO_LEVEL_LOW);
> 	}
> 	return 0;
> }
> 
> static struct resource smc91x_resources[] = {
> 	[0] = {
> 	       .start	= OMAP24xx_ETHR_BASE,	/* Physical */
> 	       .end	= OMAP24xx_ETHR_BASE + SZ_4K,
> 	       .flags	= IORESOURCE_MEM,
> 	       },
> 	[1] = {
> 	       .start	= INT_ETHER,
> 	       .end	= 0,
> 	       .flags	= IORESOURCE_IRQ,
> 	       },
> };
> 
> static struct platform_device smc91x_device = {
> 	.name		= "smc91x",
> 	.id		= 0,
> 	.num_resources	= ARRAY_SIZE(smc91x_resources),
> 	.resource	= smc91x_resources,
> };

I have tried to include above code, but it doesn't help. I remember the
same problem, while we were porting h4 code to omap-git tree, and Tony
solved it using proper GPMC_config timing values.

http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004739.html
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=e62a2da3ddfa18c63901138e8360a83b04318dee
 


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
