From: "arun c" <arun.edarath@gmail.com>
Subject: I2C not working in uboot
Date: Tue, 17 Jul 2007 16:39:57 +0530
Message-ID: <c656a4d20707170409g6f9b294eyec6f9f798c9b25d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I am working on a custom omap2430 board. Its similar to
omap2430SDP. I ported uboot,and xloader to that board.

I want to test the working of a keypad which is connected
through the TWL4030 power module in uboot.My kepad
registers are accessed through I2C.omap 2430's I2C2_SCL
and  I2C2_SDA are connected to 4030.

I enabled I2C in uboot.(added CFG_I2C_CMD)
the default uboot settings are given below

#if (CONFIG_COMMANDS & CFG_CMD_I2C)
#define CFG_I2C_SPEED          100
#define CFG_I2C_SLAVE          1
#define CFG_I2C_BUS            0
#define CFG_I2C_BUS_SELECT     1
#define CONFIG_DRIVER_OMAP24XX_I2C 1
#endif

I booted uboot with these settings. But reading
the chip address 0x49(using imd) gives only zeros.
0x49 is the keypad register bank address in i2c

As per datasheet of 2430 some registers are set
to values other than zero on reset. So I strongly
think my settings are wrong.

Please somebody tell me the correct way use the
I2C bus for checking the keypad in uboot.

Best regards
Arun
