From: Satish Patel <satish.patel@ti.com>
Subject: Re: [RFC PATCH v1 2/5] misc: tda8026: Add NXP TDA8026 PHY driver
Date: Tue, 7 Jan 2014 12:06:37 +0530
Message-ID: <52CBA075.8080506@ti.com>
References: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
 <1389010062-17185-3-git-send-email-satish.patel@ti.com>
 <20140106153033.GB24664@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140106153033.GB24664@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 1/6/2014 9:00 PM, Mark Rutland wrote:
> On Mon, Jan 06, 2014 at 12:07:39PM +0000, Satish Patel wrote:
>> TDA8026 is a SmartCard PHY from NXP.
>>
>> The PHY interfaces with the main processor over the
>> I2C interface and acts as a slave device.
>>
>> The driver also exposes the phy interface
>> (defined@include/linux/sc_phy.h) for SmartCard controller.
>> Controller uses this interface to communicate with smart card
>> inserted to the phy's slot.
>>
>> Note: gpio irq is not validated as I do not have device with that.
>> I have validated interrupt with dedicated interrupt line on my device.
>>
>> Signed-off-by: Maulik Mankad <maulik@ti.com>
>> Signed-off-by: Satish Patel <satish.patel@ti.com>
>> ---
>>  Documentation/devicetree/bindings/misc/tda8026.txt |   14 +
>>  drivers/misc/Kconfig                               |    7 +
>>  drivers/misc/Makefile                              |    1 +
>>  drivers/misc/tda8026.c                             | 1271 ++++++++++++++++++++
>>  4 files changed, 1293 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/misc/tda8026.txt
>>  create mode 100644 drivers/misc/tda8026.c
>>
>> diff --git a/Documentation/devicetree/bindings/misc/tda8026.txt b/Documentation/devicetree/bindings/misc/tda8026.txt
>> new file mode 100644
>> index 0000000..d3083bf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/tda8026.txt
>> @@ -0,0 +1,14 @@
>> +TDA8026 smart card slot interface
>> +
>> +Required properties:
>> +- compatible: nxp,tda8026
> 
> Please quote strings:
> 
> - compatible: should contain "nxp,tda8026"
ok
> 
>> +- shutdown-gpio = GPIO pin mapping for SDWNN pin
>> +- reg = i2c interface address
> 
> It's probably worth mentioning at the start that this is an i2c device.
> 
> [...]
ok
> 
>> +static int tda8026_parse_dt(struct device *dev, struct tda8026 *pdata)
>> +{
>> +       struct device_node *np = dev->of_node;
>> +       const struct of_device_id *match;
>> +       int ret = 0;
>> +
>> +       match = of_match_device(of_match_ptr(tda8026_id_table), dev);
>> +       if (!match)
>> +               return -EINVAL;
> 
> Why do this? The of_device_id table contains one entry with no
> additional data. If you just want to see if this was probed via DT,
> dev->of_node not being NULL would tell you that.
> 
agree..
> Is this going to be used without DT anywhere?
> 
> [...]
> 
>> +       if (pdata->irq == 0) {
>> +               /* look for the field irq-gpio in DT */
>> +               irq_gpio = of_get_named_gpio(np, "irq-gpio", 0);
>> +               if (!gpio_is_valid(irq_gpio)) {
>> +                       dev_err(dev, "Failed to get irq gpio,\n");
>> +                       return -EIO;
>> +               }
> 
> This is horrible. If the gpio controller can act as an irq controller

No it's not true. Let me clarify the signal flow,

Pins => GPIO => GPIO BANK => Interrupt controller => CPU/MPU

> then it should be annotated as such, with #interrupt-cells, and you
> should just describe the interrupt. The smart card controller cares
> about having an interrupt line, not a GPIO.
> 

Let me quote MMC card-detect example here,
File: drivers/mmc/host/omap_hsmmc.c

Card detection is happening through GPIO (same as what this patch is
doing). Please refer to the probe sequence, you will find exactly same
thing there too.


AM437x device has a special feature for the USIM Phy, where the PHY
interrupt automatically gets hooked up to interrupt-controller and
the driver gets interrupt number from DT using #interrupt-cells, exactly
what you had mentioned.
But if same PHY gets interfaced to other SoC's over GPIO, then in order
to handle that scenario you __must__ go through gpio_to_irq().

Let me add another important point here,
You can not determine irq number for the given GPIO, as it gets
allocated dynamically based on GPIO banks supported on the device and on
the board.

> Additionally, this was not described in the binding.
> 
> Thanks,
> Mark.
> 
