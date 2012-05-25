From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 07/11] mfd: omap: control: usb-phy:
 introduce the ctrl-module usb driver
Date: Fri, 25 May 2012 17:06:02 +0200
Message-ID: <4FBF9FDA.1000703@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337934361-1606-8-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
> Created a new platform driver for the platform device created by the
> control module mfd core, wrt usb. This driver has API's to power on/off
> the phy and the API's to write to musb mailbox.
>
> (p.s. the mailbox for musb in omap4 is present in system control
> module)
>
> [kishon@ti.com: wrote the original API's related to USB functions]
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>

...

> +/**
> + * omap4_usb_phy_mailbox - write to usb otg mailbox
> + * @dev: struct device *
> + * @val: the value to be written to the mailbox
> + *
> + * On detection of a device (ID pin is grounded), the phy should call this API
> + * to set AVALID, VBUSVALID and ID pin is grounded.
> + *
> + * When OMAP is connected to a host (OMAP in device mode), the phy should call
> + * this API to set AVALID, VBUSVALID and ID pin in high impedance.
> + *
> + * The phy should call this API, if OMAP is disconnected from host or device.
> + */
> +int omap4_usb_phy_mailbox(struct device *dev, u32 val)
> +{
> +	return omap_control_writel(dev, val, CONTROL_USBOTGHS_CONTROL);

Mmm, I'm missing something. The device for usb_phy mailbox cannot be the 
same than the device for the scm...

> +}
> +EXPORT_SYMBOL_GPL(omap4_usb_phy_mailbox);
> +
> +static int __devinit omap_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct omap_control *omap_control;
> +
> +	omap_control = dev_get_drvdata(pdev->dev.parent);

Directly accessing your parent device data does not looks very nice to me.
Maybe that's only me, but I'll never try to sneak into my parents stuff :-)

You previously exposed an API to get/put the control module device, so I 
guess you should use it from the probe.

> +
> +	if (!omap_control) {
> +		dev_err(&pdev->dev, "no omap_control in our parent\n");
> +		return -EINVAL;
> +	}

BTW, where is the omap_control struct used?

I'm not sure to understand how the user is supposed to call that API?

Regards,
Benoit
