From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Fri, 8 Mar 2013 17:04:50 +0200
Message-ID: <5139FE12.6000700@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-2-git-send-email-rogerq@ti.com> <5139C174.7030401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36783 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934233Ab3CHPFZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 10:05:25 -0500
In-Reply-To: <5139C174.7030401@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On 03/08/2013 12:46 PM, Marc Kleine-Budde wrote:
> On 02/04/2013 04:58 PM, Roger Quadros wrote:
>> The PHY clock, clock rate, VCC regulator and RESET regulator
>> can now be provided via device tree.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++++
>>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++++++
>>  2 files changed, 65 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> new file mode 100644
>> index 0000000..d7e2726
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> @@ -0,0 +1,34 @@
>> +USB NOP PHY
>> +
>> +Required properties:
>> +- compatible: should be usb-nop-xceiv
>> +
>> +Optional properties:
>> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
>> +  /bindings/clock/clock-bindings.txt
>> +  This property is required if clock-frequency is specified.
>> +
>> +- clock-names: Should be "main_clk"
>> +
>> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
>> +  be configured to.
>> +
>> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
>> +
>> +- reset-supply: phandle to the regulator that provides power to the PHY.
>> +
>> +Example:
>> +
>> +	hsusb1_phy {
>> +		compatible = "usb-nop-xceiv";
>> +		clock-frequency = <19200000>;
> 
> Why do you hardcode the clock frequency here? You should use
> clk_get_rate() to get the frequency from the clock tree.

That would work only if the clock was programmed to the correct frequency
by someone.

e.g. In the OMAP case nobody programs the auxiliary clock on Panda which clocks
the USB PHY.

The usb-nop-xceiv device driver must program the clock rate using clk_set_rate(),
but it needs to know what frequency it must program it to. Different boards/PHYs
might use a different clock frequency. The 'clock-frequency' property
is used to pass on this information to the driver.

cheers,
-roger
