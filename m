From: "G Kondaiah, Manjunath" <xgkondai@ti.com>
Subject: RE: OMAP1 IrDA driver doubts
Date: Wed, 14 Dec 2005 06:04:11 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50365E870@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Komal,

A) is required since the same lines are shared between IrDA and aGPS
modules. There is an I/O Expander to select these lines on H3/H4 using
I2C.

Regards,
Manjunath

-----Original Message-----
From: linux-omap-open-source-bounces+xgkondai=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+xgkondai=3Dti.com@linux.omap.com]
On Behalf Of Komal Shah
Sent: Tuesday, December 13, 2005 11:20 AM
To: linux-omap-open-source@linux.omap.com
Subject: OMAP1 IrDA driver doubts

Hi All,

I am cleaning up Irda driver in-order to add H4 support for the same.

I want to know, what exactly this sequence of read/write gpio expander
is doing in=20

A)
--------snip-------------
oma1610_irda_start(...)
...
#ifdef CONFIG_MACH_OMAP_H3
        if ((err =3D read_gpio_expa(&ioExpanderVal, 0x26))) {
                printk(KERN_ERR "Error reading from I/O EXPANDER \n");
                return err;
        }

        ioExpanderVal |=3D 0x40;  /* 'P6' Enable IRDA_TX and IRDA_RX */

        if ((err =3D write_gpio_expa(ioExpanderVal, 0x26))) {
                printk(KERN_ERR "Error writing to I/O EXPANDER \n");
                return err;
        }
#endif
--------snip-------------

Is it related to enabling power? As similar sequence is also there for
H4?

B)=20
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
I will introduce platform_data->set_mode function, which will move=20
set_h3_irda_mode() and setting firsel_gpio to h3 and h2 files resp.=20

As I don't have much info about 16xx/17xx, I would appreciate any
clarfications on the above doubts. Thanx.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
