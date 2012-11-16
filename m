From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: usb-host: Device tree support for USB
 Host
Date: Fri, 16 Nov 2012 12:55:43 +0200
Message-ID: <50A61BAF.7000200@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com> <1352991396-19589-2-git-send-email-rogerq@ti.com> <50A615C6.6060604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab2KPKzq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 05:55:46 -0500
In-Reply-To: <50A615C6.6060604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, balbi@ti.com, keshava_mgowda@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi Benoit,

On 11/16/2012 12:30 PM, Benoit Cousson wrote:
> Hi Roger,
> 
> On 11/15/2012 03:56 PM, Roger Quadros wrote:
>> Provides a means for the OMAP USB host subsystem to be initialized
>> from Device tree. This is a first step for device tree migration where
>> we specify only the board specific stuff. Things like I/O address space
>> and interrupts are not yet specified in the device tree but can be
>> done as a next step.
>>
>> This patch will allow boards to be booted with our without device tree
>> and have USB host functional.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/arm/omap/usb-host.txt      |   60 +++++++++++++++++
>>  arch/arm/mach-omap2/board-generic.c                |    1 +
>>  arch/arm/mach-omap2/common.h                       |    2 +
>>  arch/arm/mach-omap2/usb-host.c                     |   71 ++++++++++++++++++++
>>  4 files changed, 134 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/omap/usb-host.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/usb-host.txt b/Documentation/devicetree/bindings/arm/omap/usb-host.txt
>> new file mode 100644
>> index 0000000..f25cfa4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/usb-host.txt
>> @@ -0,0 +1,60 @@
>> +* usb-host - OMAP USB Host Subsystem
>> +
>> +The OMAP USB host subsystem consists of the following modules
>> +1) USBTLL (Tranceiverless interface)
>> +2) USBHOST (Host Controller module) which includes both EHCI and OHCI controllers
>> +
>> +THe USB Host subsystem can be connected to the external world using 3 PORTs that could
>> +be configured in various modes like  UTMI+ for external PHY, ULPI transceiverless link (TLL),
>> +Serial TLL, High-speed interchip (HSIC), etc.
>> +
>> +Required proprties:
>> +- compatible: Must be "ti,usb-host";
>> +- num_ports: Number of physical ports available
>> +
>> +Optional properties:
>> +- 1 child node for each available port.  These child nodes are usually supplied by the
>> +  board support device tree as they are specific to how the ports are wired on the board
>> +
>> +  - mode: Integer specifying the mode in which the port is used
>> +	* OMAP_USBHS_PORT_MODE_UNUSED		= 0,
>> +	* OMAP_EHCI_PORT_MODE_PHY		= 1,
>> +	* OMAP_EHCI_PORT_MODE_TLL		= 2,
>> +	* OMAP_EHCI_PORT_MODE_HSIC		= 3,
>> +	* OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0 	= 4,
>> +	* OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM 	= 5,
>> +	* OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0	= 6,
>> +	* OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM	= 7,
>> +	* OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0	= 8,
>> +	* OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM	= 9,
>> +	* OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0	= 10,
>> +	* OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM	= 11,
>> +	* OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0	= 12,
>> +	* OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM	= 13,
>> +   - clk: Name of the clock that needs to be active when using the port
>> +   - clkrate: Frequency at which the above clk needs to be run at
>> +
>> +
>> +Example:
>> +
>> +/* In the OMAP Core tree */
>> +usbhost: usb-host {
>> +	compatible = "ti,usb-host";
>> +	num_ports = <3>;
>> +};
>> +
>> +/* In the Board tree */
>> +&usbhost {
>> +	port@0 {
>> +		mode = <1>;
>> +		clk = "auxclk3_ck";
>> +		clkrate = <19200000>;
>> +	};
>> +	port@1 {
>> +		mode = <0>;
>> +	};
>> +	port@2 {
>> +		mode = <0>;
>> +	};
>> +};
>> +
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 601ecdf..4e53b62 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -40,6 +40,7 @@ static void __init omap_generic_init(void)
>>  	omap_sdrc_init(NULL, NULL);
>>  
>>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>> +	usbhost_init_of();
> 
> You should never have to add that kind of hacks in generic board file.
> Why do you need that during board init?
> 
> In theory, the of_platform_populate will create all the devices, and
> during the driver probe you will create the sub nodes.
>

OK. I was thinking of this as a temporary fix till the USB host drivers
support OF nodes natively. Maybe I should work on fixing up the host
drivers instead.

But I'm not sure how the PM runtime calls map to omap_device/hwmod
framework when device tree boot is used. I can see that the device tree
node can specify "ti,hwmods = " parameter. Just can't seem to figure out
how all this adds up :P

cheers,
-roger

