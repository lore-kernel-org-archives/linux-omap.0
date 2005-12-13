From: Komal Shah <komal_shah802003@yahoo.com>
Subject: OMAP1 IrDA driver doubts
Date: Tue, 13 Dec 2005 09:19:32 -0800 (PST)
Message-ID: <20051213171932.38363.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

Hi All,

I am cleaning up Irda driver in-order to add H4 support for the same.

I want to know, what exactly this sequence of read/write gpio expander
is doing in 

A)
--------snip-------------
oma1610_irda_start(...)
...
#ifdef CONFIG_MACH_OMAP_H3
        if ((err = read_gpio_expa(&ioExpanderVal, 0x26))) {
                printk(KERN_ERR "Error reading from I/O EXPANDER \n");
                return err;
        }

        ioExpanderVal |= 0x40;  /* 'P6' Enable IRDA_TX and IRDA_RX */

        if ((err = write_gpio_expa(ioExpanderVal, 0x26))) {
                printk(KERN_ERR "Error writing to I/O EXPANDER \n");
                return err;
        }
#endif
--------snip-------------

Is it related to enabling power? As similar sequence is also there for
H4?

B) 
--------snip-------------
omap_irda_startup(...)
...
/* Enable UART3 clock and set UART3 to IrDA mode */
omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
            MOD_CONF_CTRL_0);
--------snip-------------
As comment suggests that it is enabling UART3 clock, why don't we use
clk_use(...) api? And setting irda_mode from omap_irda_config function
like in usb->hmc_mode?

--------snip-------------
if (machine_is_omap_h2()) {
        omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
--------snip-------------

What is this muxing is doing? Is there any entry in mux table so that I
can use omap1_cfg_reg(...) function call?

C)
I will introduce platform_data->set_mode function, which will move 
set_h3_irda_mode() and setting firsel_gpio to h3 and h2 files resp. 

As I don't have much info about 16xx/17xx, I would appreciate any
clarfications on the above doubts. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
