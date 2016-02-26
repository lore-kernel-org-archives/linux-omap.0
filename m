From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap device tree changes for v4.6 merge window, part 1
Date: Fri, 26 Feb 2016 22:35:11 +0100
Message-ID: <6026634.ihuvqopRan@wuerfel>
References: <20160222215612.GV13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160222215612.GV13417@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 22 February 2016 13:56:12 Tony Lindgren wrote:
> Device tree changes for omaps for v4.6 merge window. Mostly just
> adding board specific devices and few new boards:
> 
> - N900 improvments for adp1653 and gpio keys
> 
> - Add missing bandgap data for omap3
> 
> - Add more devices for compulab cm-t335
> 
> - Add n950 WLAN support, enable modem, add pinctrl for SSI
> 
> - Correct dm814x and dra62x auxclk rate, add support for GPMC and NAND
> 
> - Add syscon node for PHY's on dra7
> 
> - Add support more devices on logicpd torpedo
> 
> - Add USB host support for igep and specify boot console
> 
> - Fix audio clock for am335x-sl50 and specify boot console
> 
> - Remove deprecated tx-fifo-resize for dwc3 that was only used on
>   omap5 es1.0
> 
> - Add dra7 thermal data
> 
> - Update am43x-epos-evm compatible string to am438
> 
> - Add support for logicpd dm3730 som-lv
> 

Pulled into next/dt, with a trivial conflict resolution:

--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@@ -110,6 -110,19 +110,11 @@@
  
  &i2c3 {
  	clock-frequency = <400000>;
 -};
 -
 -&i2c2 {
 -	clock-frequency = <400000>;
 -};
 -
 -&i2c3 {
 -	clock-frequency = <400000>;
+ 	at24@50 {
+ 		compatible = "at24,24c02";
+ 		readonly;
+ 		reg = <0x50>;
+ 	};
  };
  
  /*

Thanks,

	Arnd
