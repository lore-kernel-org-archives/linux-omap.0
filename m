From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v1 2/5] misc: tda8026: Add NXP TDA8026 PHY driver
Date: Mon, 6 Jan 2014 15:30:33 +0000
Message-ID: <20140106153033.GB24664@e106331-lin.cambridge.arm.com>
References: <1389010062-17185-1-git-send-email-satish.patel@ti.com>
 <1389010062-17185-3-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1389010062-17185-3-git-send-email-satish.patel@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Satish Patel <satish.patel@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 06, 2014 at 12:07:39PM +0000, Satish Patel wrote:
> TDA8026 is a SmartCard PHY from NXP.
> 
> The PHY interfaces with the main processor over the
> I2C interface and acts as a slave device.
> 
> The driver also exposes the phy interface
> (defined@include/linux/sc_phy.h) for SmartCard controller.
> Controller uses this interface to communicate with smart card
> inserted to the phy's slot.
> 
> Note: gpio irq is not validated as I do not have device with that.
> I have validated interrupt with dedicated interrupt line on my device.
> 
> Signed-off-by: Maulik Mankad <maulik@ti.com>
> Signed-off-by: Satish Patel <satish.patel@ti.com>
> ---
>  Documentation/devicetree/bindings/misc/tda8026.txt |   14 +
>  drivers/misc/Kconfig                               |    7 +
>  drivers/misc/Makefile                              |    1 +
>  drivers/misc/tda8026.c                             | 1271 ++++++++++++++++++++
>  4 files changed, 1293 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/tda8026.txt
>  create mode 100644 drivers/misc/tda8026.c
> 
> diff --git a/Documentation/devicetree/bindings/misc/tda8026.txt b/Documentation/devicetree/bindings/misc/tda8026.txt
> new file mode 100644
> index 0000000..d3083bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/tda8026.txt
> @@ -0,0 +1,14 @@
> +TDA8026 smart card slot interface
> +
> +Required properties:
> +- compatible: nxp,tda8026

Please quote strings:

- compatible: should contain "nxp,tda8026"

> +- shutdown-gpio = GPIO pin mapping for SDWNN pin
> +- reg = i2c interface address

It's probably worth mentioning at the start that this is an i2c device.

[...]

> +static int tda8026_parse_dt(struct device *dev, struct tda8026 *pdata)
> +{
> +       struct device_node *np = dev->of_node;
> +       const struct of_device_id *match;
> +       int ret = 0;
> +
> +       match = of_match_device(of_match_ptr(tda8026_id_table), dev);
> +       if (!match)
> +               return -EINVAL;

Why do this? The of_device_id table contains one entry with no
additional data. If you just want to see if this was probed via DT,
dev->of_node not being NULL would tell you that.

Is this going to be used without DT anywhere?

[...]

> +       if (pdata->irq == 0) {
> +               /* look for the field irq-gpio in DT */
> +               irq_gpio = of_get_named_gpio(np, "irq-gpio", 0);
> +               if (!gpio_is_valid(irq_gpio)) {
> +                       dev_err(dev, "Failed to get irq gpio,\n");
> +                       return -EIO;
> +               }

This is horrible. If the gpio controller can act as an irq controller
then it should be annotated as such, with #interrupt-cells, and you
should just describe the interrupt. The smart card controller cares
about having an interrupt line, not a GPIO.

Additionally, this was not described in the binding.

Thanks,
Mark.
