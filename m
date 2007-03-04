From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Sun, 04 Mar 2007 18:11:22 +0100
Message-ID: <45EAFDBA.9010406@googlemail.com>
References: <85ps7pgphq.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090309030905060500010707"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <85ps7pgphq.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309030905060500010707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arnaud Patard (Rtp) wrote:
> If one wants to use ssi/Kconfig on arm, it should be added to
> arch/arm/Kconfig.

Yes, I found this as well by getting

sound/arm/Kconfig:55:warning: 'select' used by config symbol
'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_TSC2101'
sound/arm/Kconfig:56:warning: 'select' used by config symbol
'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_UWIRE'

Kconfig warnings.

While touching this, what do you think about doing some more
clean up:

- omap_uwire.c is now in drivers/spi [], remove (old?) one from
drivers/ssi

- Replace OMAP_UWIRE in Kconfig by SPI_OMAP_UWIRE pointing
to drivers/spi

?

Update of your patch below.

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009217.html


--------------090309030905060500010707
Content-Type: text/x-patch;
 name="ssi_kconfig.patch"
Content-Disposition: inline;
 filename="ssi_kconfig.patch"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by calf.ext.ti.com id l24HBdrC011059

Index: linux-osk/arch/arm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/arch/arm/Kconfig
+++ linux-osk/arch/arm/Kconfig
@@ -991,6 +991,8 @@ if ARCH_OMAP
 source "drivers/cbus/Kconfig"
 endif
=20
+source "drivers/ssi/Kconfig"
+
 endmenu
=20
 source "fs/Kconfig"
Index: linux-osk/drivers/ssi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/drivers/ssi/Kconfig
+++ linux-osk/drivers/ssi/Kconfig
@@ -1,16 +1,9 @@
 menu "Synchronous Serial Interfaces (SSI)"
=20
-config OMAP_UWIRE
-	depends on ARCH_OMAP1
-	tristate "MicroWire support on OMAP"
-	---help---
-	  Say Y here if you want support for the MicroWire interface
-	  on an OMAP processor.
-
 config OMAP_TSC2101
 	depends on ARCH_OMAP1 || ARCH_OMAP24XX
 	tristate "TSC2101 codec support for Touchscreen and audio"
-	select OMAP_UWIRE if MACH_OMAP_H3 || MACH_OMAP_H2
+	select SPI_OMAP_UWIRE if MACH_OMAP_H3 || MACH_OMAP_H2
 	select GPIOEXPANDER_OMAP if MACH_OMAP_H3
 	---help---
 	  Say Y here if you want support for the TSC2101 codec.  It is
Index: linux-osk/drivers/ssi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/drivers/ssi/Makefile
+++ linux-osk/drivers/ssi/Makefile
@@ -2,5 +2,4 @@
 # Makefile for the SSI drivers
 #
=20
-obj-$(CONFIG_OMAP_UWIRE)        +=3D omap-uwire.o
 obj-$(CONFIG_OMAP_TSC2101)      +=3D omap-tsc2101.o
Index: linux-osk/drivers/ssi/omap-uwire.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/drivers/ssi/omap-uwire.c
+++ /dev/null
@@ -1,233 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *
- *	uWire interface driver for the OMAP Platform
- *
- * Copyright 2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *	   source@mvista.com
- *
- * Ported to 2.6 uwire interface.
- * Copyright (C) 2004 Texas Instruments.
- *
- * Generalization patches by Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>
- *
- *  This program is free software; you can redistribute	 it and/or modif=
y it
- *  under  the terms of	 the GNU General  Public License as published by=
 the
- *  Free Software Foundation;  either version 2 of the	License, or (at y=
our
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIE=
S OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.=
  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,=
 BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS=
 OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND =
ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR =
TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US=
E OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License a=
long
- *  with this program; if not, write  to the Free Software Foundation, I=
nc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/hardware.h>
-#include <asm/io.h>
-#include <asm/mach-types.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/omap730.h>	/* OMAP730_IO_CONF registers */
-
-#include "omap-uwire.h"
-
-/* uWire Registers: */
-#define UWIRE_BASE    0xFFFB3000
-#define UWIRE_IO_SIZE 0x20
-#define UWIRE_TDR     0x00
-#define UWIRE_RDR     0x00
-#define UWIRE_CSR     0x01
-#define UWIRE_SR1     0x02
-#define UWIRE_SR2     0x03
-#define UWIRE_SR3     0x04
-#define UWIRE_SR4     0x05
-#define UWIRE_SR5     0x06
-
-static unsigned short uwire_flags[4];
-static unsigned long uwire_base =3D io_p2v(UWIRE_BASE);
-static spinlock_t uwire_lock;
-static unsigned int uwire_idx_shift;
-
-static inline void uwire_write_reg(int idx, u16 val)
-{
-	__raw_writew(val, uwire_base + (idx << uwire_idx_shift));
-}
-
-static inline u16 uwire_read_reg(int idx)
-{
-	return __raw_readw(uwire_base + (idx << uwire_idx_shift));
-}
-
-void omap_uwire_configure_mode(int cs, unsigned long flags)
-{
-	u16 w, val =3D 0;
-	int shift, reg;
-
-	BUG_ON(cs > 3);
-
-	val =3D flags & 0x3f;
-	if (flags & UWIRE_CLK_INVERTED)
-		val ^=3D 0x03;
-	if (cs & 1)
-		shift =3D 6;
-	else
-		shift =3D 0;
-	if (cs <=3D 1)
-		reg =3D UWIRE_SR1;
-	else
-		reg =3D UWIRE_SR2;
-	spin_lock(&uwire_lock);
-	w =3D uwire_read_reg(reg);
-	w &=3D ~(0x3f << shift);
-	w |=3D val << shift;
-	uwire_write_reg(reg, w);
-	spin_unlock(&uwire_lock);
-
-	uwire_flags[cs] =3D flags;
-}
-
-static int wait_uwire_csr_flag(u16 mask, u16 val, int might_not_catch)
-{
-	u16 w;
-	int c =3D 0;
-	unsigned long max_jiffies =3D jiffies + HZ;
-
-	for (;;) {
-		w =3D uwire_read_reg(UWIRE_CSR);
-		if ((w & mask) =3D=3D val)
-			break;
-		if (time_after(jiffies, max_jiffies)) {
-			printk(KERN_ERR "%s: timeout. reg=3D%#06x mask=3D%#06x val=3D%#06x\n"=
,
-			       __FUNCTION__, w, mask, val);
-			return -1;
-		}
-		c++;
-		if (might_not_catch && c > 64)
-			break;
-	}
-	return 0;
-}
-
-int omap_uwire_data_transfer(int cs, u16 tx_data, int tx_size, int rx_si=
ze,
-			     u16 *rx_buf, int leave_cs_active)
-{
-	u16 ret =3D -1, w;
-	u16 mask;
-
-	BUG_ON(cs > 3);
-	BUG_ON(rx_size && !rx_buf);
-
-	spin_lock(&uwire_lock);
-
-	if (wait_uwire_csr_flag(1 << 14, 0, 0))
-		goto exit;
-
-	if (uwire_flags[cs] & UWIRE_CLK_INVERTED)
-		uwire_write_reg(UWIRE_SR4, 1);
-	else
-		uwire_write_reg(UWIRE_SR4, 0);
-
-	w =3D cs << 10;
-	w |=3D 1 << 12;				/* CS_CMD : activate CS */
-	uwire_write_reg(UWIRE_CSR, w);
-
-	/* Shift data to 16bit MSb and place it in TX register. */
-	uwire_write_reg(UWIRE_TDR, tx_data << (16 - tx_size));
-
-	if (wait_uwire_csr_flag(1 << 14, 0, 0))
-		goto exit;
-
-	w =3D rx_size | (tx_size << 5) | (cs << 10);
-	w |=3D (1 << 12) | (1 << 13);
-	/* Start uWire read/write */
-	uwire_write_reg(UWIRE_CSR, w);
-
-	/* Wait till read/write actually starts.
-	 * This is needed at high (>=3D60MHz) MPU frequencies
-	 * REVISIT: But occasionally we won't have time to catch it
-	 */
-	if (wait_uwire_csr_flag(1 << 14, 1 << 14, 1))
-		goto exit;
-
-	/* Wait for both transfers to be completed */
-	mask =3D 1 << 14;			/* CSRB : reg busy */
-	w =3D 0;
-	if (rx_size) {
-		mask |=3D 1 << 15;	/* RDRB : reg busy */
-		w |=3D 1 << 15;
-	}
-
-	if (wait_uwire_csr_flag(mask, w, 0))
-		goto exit;
-
-	if (rx_size)
-		*rx_buf =3D uwire_read_reg(UWIRE_RDR);
-
-	if (!leave_cs_active)
-		uwire_write_reg(UWIRE_CSR, cs << 10);
-
-	ret =3D 0;
-
-exit:
-	spin_unlock(&uwire_lock);
-	return ret;
-}
-
-static int __init omap_uwire_init(void)
-{
-	spin_lock_init(&uwire_lock);
-	if (cpu_is_omap730())
-		uwire_idx_shift =3D 1;
-	else
-		uwire_idx_shift =3D 2;
-
-	uwire_write_reg(UWIRE_SR3, 1);
-	if (machine_is_omap_h2()) {
-		/* defaults: W21 SDO, U18 SDI, V19 SCL */
-		omap_cfg_reg(N14_1610_UWIRE_CS0);
-		omap_cfg_reg(N15_1610_UWIRE_CS1);
-	}
-	if (machine_is_omap_osk()) {
-		/* this is the standard expansion connector usage, with
-		 * the other chipselect pins for MPUIO2 and MPUIO4.
-		 */
-		omap_cfg_reg(N14_1610_UWIRE_CS0);
-		omap_cfg_reg(P15_1610_UWIRE_CS3);
-	}
-	if (machine_is_omap_perseus2()) {
-		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
-		int val =3D omap_readl(OMAP730_IO_CONF_9) & ~0x00EEE000;
-		omap_writel(val | 0x00AAA000, OMAP730_IO_CONF_9);
-	}
-	return 0;
-}
-
-static void __exit omap_uwire_exit(void)
-{
-}
-
-subsys_initcall(omap_uwire_init);
-module_exit(omap_uwire_exit);
-
-EXPORT_SYMBOL(omap_uwire_configure_mode);
-EXPORT_SYMBOL(omap_uwire_data_transfer);
-
-MODULE_LICENSE("GPL");
Index: linux-osk/drivers/ssi/omap-uwire.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/drivers/ssi/omap-uwire.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#ifndef __ARCH_OMAP_UWIRE_H
-#define __ARCH_OMAP_UWIRE_H
-
-#define UWIRE_READ_FALLING_EDGE		0x0000
-#define UWIRE_READ_RISING_EDGE		0x0001
-#define UWIRE_WRITE_FALLING_EDGE	0x0000
-#define UWIRE_WRITE_RISING_EDGE		0x0002
-#define UWIRE_CS_ACTIVE_LOW		0x0000
-#define UWIRE_CS_ACTIVE_HIGH		0x0004
-#define UWIRE_FREQ_DIV_2		0x0000
-#define UWIRE_FREQ_DIV_4		0x0008
-#define UWIRE_FREQ_DIV_8		0x0010
-#define UWIRE_CHK_READY			0x0020
-#define UWIRE_CLK_INVERTED		0x0040
-
-/*
- * uWire for OMAP declarations
- */
-extern void omap_uwire_configure_mode(int cs, unsigned long flags);
-
-/* NOTE: Make sure you don't call this from an interrupt handler! */
-extern int omap_uwire_data_transfer(int cs, u16 tx_data, int tx_size,
-				    int rx_size, u16 *rx_buf,
-				    int leave_cs_active);
-
-#endif
Index: linux-osk/sound/arm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-osk.orig/sound/arm/Kconfig
+++ linux-osk/sound/arm/Kconfig
@@ -53,7 +53,7 @@ config SND_OMAP_TSC2101
  	depends on ARCH_OMAP && SND
  	select SND_PCM
          select OMAP_TSC2101
-         select OMAP_UWIRE if ARCH_OMAP
+         select SPI_OMAP_UWIRE if ARCH_OMAP
 	 select OMAP_MCBSP
  	help
  	  Say Y here if you have a OMAP platform board


--------------090309030905060500010707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------090309030905060500010707--
