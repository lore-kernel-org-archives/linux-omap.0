From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Mon, 11 Mar 2013 10:40:51 +0200
Message-ID: <513D9893.50703@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
 <5139C174.7030401@pengutronix.de> <513A079A.1020106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <513A079A.1020106-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/08/2013 05:45 PM, Marc Kleine-Budde wrote:
> On 03/08/2013 11:46 AM, Marc Kleine-Budde wrote:
>> On 02/04/2013 04:58 PM, Roger Quadros wrote:
>>> The PHY clock, clock rate, VCC regulator and RESET regulator
>>> can now be provided via device tree.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++++
>>>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++++++
>>>  2 files changed, 65 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>> new file mode 100644
>>> index 0000000..d7e2726
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>>> @@ -0,0 +1,34 @@
>>> +USB NOP PHY
>>> +
>>> +Required properties:
>>> +- compatible: should be usb-nop-xceiv
>>> +
>>> +Optional properties:
>>> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
>>> +  /bindings/clock/clock-bindings.txt
>>> +  This property is required if clock-frequency is specified.
>>> +
>>> +- clock-names: Should be "main_clk"
>>> +
>>> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
>>> +  be configured to.
>>> +
>>> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
>>> +
>>> +- reset-supply: phandle to the regulator that provides power to the PHY.
>>> +
>>> +Example:
>>> +
>>> +	hsusb1_phy {
>>> +		compatible = "usb-nop-xceiv";
>>> +		clock-frequency = <19200000>;
>>
>> Why do you hardcode the clock frequency here? You should use
>> clk_get_rate() to get the frequency from the clock tree.
> 
> What about declaring a "fixed-clock" node in the device tree? Then it
> should be possible to keep the driver free of any omap specific code.
> 

The current implementation is not OMAP specific and is not limited to a
fixed frequency clock. The PHY driver is using standard clock APIs to set
the clock rate 'only' if the 'clock-frequency' property is present in the
device tree node.

What is the benefit of declaring it as a "fixed-clock"?
FYI. The clock may not necessarily be a fixed frequency clock and someone
needs to program the rate.

cheers,
-roger
