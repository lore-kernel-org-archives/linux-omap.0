From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: AM335x pinctrl error -19 (-ENODEV)
Date: Fri, 1 Mar 2013 05:49:55 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EB168F4@DBDE01.ent.ti.com>
References: <512E29D9.2020003@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59046 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3CAFuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 00:50:02 -0500
In-Reply-To: <512E29D9.2020003@mimc.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 27, 2013 at 21:14:25, Mark Jackson wrote:
> I've specified an I2C bus and all 6 UARTs in the dts file for my custom cpu board, as follows:-
> 
> 	ocp {
> 		uart1: serial@44e09000 {
> 			pinctrl-names = "default";

Hi Mark,

Specify "pinctrl-0" property with pinmux/conf node.
Refer http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/139223.html

Thanks
AnilKumar

> 			status = "okay";
> 		};
> 
> 		uart2: serial@48022000 {
> 			pinctrl-names = "default";
> 			status = "okay";
> 		};
> 
> 		uart3: serial@48024000 {
> 			pinctrl-names = "default";
> 			status = "okay";
> 		};
> 
> 		uart4: serial@481a6000 {
> 			pinctrl-names = "default";
> 			status = "okay";
> 		};
> 
> 		uart5: serial@481a8000 {
> 			pinctrl-names = "default";
> 			status = "okay";
> 		};
> 
> 		uart6: serial@481aa000 {
> 			pinctrl-names = "default";
> 			status = "okay";
> 		};
> 
> 		i2c1: i2c@44e0b000 {
> 			status = "okay";
> 			pinctrl-names = "default";
> 			clock-frequency = <400000>;
> 
> 			gpio@20 {
> 				compatible = "mcp,mcp23017";
> 				reg = <0x20>;
> 			};
> 
> 			tps: tps@24 {
> 				reg = <0x24>;
> 			};
> 
> 			eeprom@53 {
> 				compatible = "mcp,24c02";
> 				reg = <0x53>;
> 				pagesize = <8>;
> 			};
> 
> 			rtc@68 {
> 				compatible = "dallas,ds1307";
> 				reg = <0x68>;
> 			};
> 		};
> 	};
> 
> But I get the following errors in the kernel boot log:-
> 
> [    0.409275] omap_i2c 44e0b000.i2c: did not get pins for i2c error: -19
> [    0.411498] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
> [    0.413235] mcp230xx: probe of 0-0020 failed with error -22
> ...
> [    0.716912] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
> [    0.721790] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.729174] omap_uart 44e09000.serial: did not get pins for uart0 error: -19
> [    0.729833] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
> [    1.320105] console [ttyO0] enabled
> [    1.326050] omap_uart 48022000.serial: did not get pins for uart1 error: -19
> [    1.334384] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 89) is a OMAP UART1
> [    1.344362] omap_uart 48024000.serial: did not get pins for uart2 error: -19
> [    1.352281] 48024000.serial: ttyO2 at MMIO 0x48024000 (irq = 90) is a OMAP UART2
> [    1.361721] omap_uart 481a6000.serial: did not get pins for uart3 error: -19
> [    1.369759] 481a6000.serial: ttyO3 at MMIO 0x481a6000 (irq = 60) is a OMAP UART3
> [    1.379144] omap_uart 481a8000.serial: did not get pins for uart4 error: -19
> [    1.387008] 481a8000.serial: ttyO4 at MMIO 0x481a8000 (irq = 61) is a OMAP UART4
> [    1.396302] omap_uart 481aa000.serial: did not get pins for uart5 error: -19
> [    1.404164] 481aa000.serial: ttyO5 at MMIO 0x481aa000 (irq = 62) is a OMAP UART5
> 
> However, the I2C bus appears to be working okay, as later I get:-
> 
> [    1.906072] rtc-ds1307 0-0068: rtc core: registered ds1307 as rtc0
> [    1.912767] rtc-ds1307 0-0068: 56 bytes nvram
> ...
> [    2.118207] rtc-ds1307 0-0068: setting system clock to 2013-01-22 20:28:37 UTC (1358886517)
> 
> I did try specifying the exact pins required in the am33xx_pinmux dts entry, but I got an error
> stating the pins were already allocated to their relevant devices.
> 
> Any ideas ?
> 
> Cheers
> Mark J.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

