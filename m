Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825F3AFCE9;
	Sun, 18 Oct 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341012; cv=none; b=JAZjc/uEE6qXt1/epJDSs4kX+CoU0Sa7umhLkVv4zbE28RR8LsugmsVktp44fDJyeBv/dSDA5a3RSR6HdK61sS9lca8j71gksIKhHu0BAV/4pOMA8wyeYB0+s++nH3/7iZXMqWWLYgDgiLVOo5YVvyzTvIG7YNp22VrqlxZ9LmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341012; c=relaxed/simple;
	bh=JPs3XtuJyKx7fLu6hhaPeSyvU/kUm/pkY/aVg1I6V/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb1jnv4Y7qfr6AkKN/cYPpUiT5yvpFi6O3UgbQFFCxyzg9JmyyHZUxpyGCavzU9AwsVSlgycqkDGJ7lMDmsi2+/aAm33sEAlr3Hg590Ia+W3LuNW+QwRZegqAFi38ieuE7xxymkavV0jDUiky4r5HMKWtLkmt0RIXy0eHkStehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b0Sq09Vz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0Sq09Vz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E601F000C4;
	Sun, 18 Oct 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792341003;
	bh=HP7nvXnHFiO6tJEtVhPZtpaBdSJlCDlwPccWX9P64C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b0Sq09Vz66wJMlPXPU1hIy98z2+KVDjGmOGPep4a31izHqvEXjHd0QP8WZZ1hvcMk
	 noNbODqaSONkR9NtVzrMkU8Z3yuryxkrzHEp3W315LtdQQp5JVCcuaG99CauOK6jXJ
	 9LzaZM7XrB7pepYoqMkRRrvKoVtvuPCcmcXA6o78=
Date: Sun, 18 Oct 2026 18:14:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: ohci-omap: handle root hub overcurrent via GPIO
Message-ID: <2026101835-botany-pueblo-cf11@gregkh>
References: <20261018155355.116290-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018155355.116290-1-ampr.mhd@gmail.com>

On Sun, Oct 18, 2026 at 07:23:24PM +0330, Muhammad Mahdi Amirpour wrote:
> Implement proper overcurrent handling for the OMAP OHCI root hub using
> the optional overcurrent GPIO line that was previously unused.
> 
> When an overcurrent condition is detected via GPIO interrupt, the driver
> now disables VBUS power through the power GPIO, records the overcurrent
> status, and reports it through the root hub port status callbacks so the
> USB hub core can react appropriately.
> 
> The hub_control override also handles SetPortFeature/ClearPortFeature
> for USB_PORT_FEAT_POWER to drive the VBUS power GPIO alongside the OHCI
> hardware register, since on boards like the OMAP1 OSK the OHCI PPS bit
> does not control the real power switch.
> 
> Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
> ---
> v3:
>   - Fix power GPIO polarity: 1 = VBUS off, 0 = VBUS on
>   - Fix wPortChange bit: shift USB_PORT_STAT_C_OVERCURRENT by 16
>   - Add clock and PHY cleanup to probe error path
>   - Use IRQF_NO_AUTOEN to close race window during probe
>   - Only set overcurrent_changed at probe when overcurrent is active
>   - Guard hub_status_data and hub_control behind priv->overcurrent
>   - Handle SetPortFeature/ClearPortFeature(POWER) for VBUS GPIO
>   - Remove shadowed flags variable in hub_control
>   - Add comment documenting overcurrent_lock
> 
> v2:
>   - Use real name in From: and Signed-off-by: lines
> ---
>  drivers/usb/host/ohci-omap.c | 249 ++++++++++++++++++++++++++++++++---
>  1 file changed, 228 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> index f6e56c4b9914..a3ff50c70d41 100644
> --- a/drivers/usb/host/ohci-omap.c
> +++ b/drivers/usb/host/ohci-omap.c
> @@ -15,6 +15,7 @@
>   * This file is licenced under the GPL.
>   */
>  
> +#include <linux/irqreturn.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -33,6 +34,9 @@
>  #include <linux/signal.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/usb/ch11.h>

Why the odd include order?  Please be more careful.

>  #include "ohci.h"
>  
> @@ -46,6 +50,10 @@ struct ohci_omap_priv {
>  	struct clk *usb_dc_ck;
>  	struct gpio_desc *power;
>  	struct gpio_desc *overcurrent;
> +	spinlock_t overcurrent_lock;	/* protects overcurrent_status and overcurrent_changed */
> +	bool overcurrent_status;

So "status" is true or false?  That doesn't make much sense to me,
sorry.

> +	bool overcurrent_changed;

"changed" from what?  Previous value?  Next value?  Over time?

> +	int overcurrent_irq;

Why are you initializing this to -1?

And what broke that requires this patch?  When the gpio overcurrent
logic was added, why wasn't the irq support added then?  Did it ever
work, or is this to enable new hardware support?

>  };
>  
>  static const char hcd_name[] = "ohci-omap";
> @@ -181,11 +189,148 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static irqreturn_t ohci_omap_overcurrent_irq(int irq, void *data)
> +{
> +	struct usb_hcd *hcd = data;
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	int status;
> +
> +	status = gpiod_get_value_cansleep(priv->overcurrent);
> +	if (status < 0)
> +		return IRQ_HANDLED;
> +
> +	if (status && priv->power)
> +		gpiod_set_value_cansleep(priv->power, 1);
> +
> +	spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +	if (!!status != priv->overcurrent_status)
> +		priv->overcurrent_changed = true;
> +	priv->overcurrent_status = !!status;
> +	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
> +
> +	usb_hcd_poll_rh_status(hcd);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ohci_omap_hub_status_data(struct usb_hcd *hcd, char *buf)
> +{
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	bool changed;
> +	int length;
> +
> +	length = ohci_hub_status_data(hcd, buf);
> +
> +	if (!priv->overcurrent)
> +		return length;
> +
> +	spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +	changed = priv->overcurrent_changed;
> +	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);

Why do you need a lock to read this?

> +
> +	if (changed) {

Ah, but what if the value "changed" changed right after you read it
(remember, no more lock).

> +		if (!length) {
> +			buf[0] = 0;
> +			length = 1;
> +		}
> +		buf[0] |= BIT(1);

What does bit 1 mean here?

> +	}
> +
> +	return length;
> +}
> +
> +static int ohci_omap_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> +				 u16 wIndex, char *buf, u16 wLength)
> +{
> +	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
> +	unsigned long flags;
> +	int ret;
> +
> +	/*
> +	 * Drive the VBUS power GPIO alongside the OHCI hardware register.
> +	 * On boards like the OSK, the OHCI PPS bit does not control the
> +	 * real power switch — the GPIO does.
> +	 */
> +	if (priv->power && wIndex == 1) {
> +		if (typeReq == SetPortFeature &&
> +		    wValue == USB_PORT_FEAT_POWER) {
> +			ret = ohci_hub_control(hcd, typeReq, wValue,
> +					       wIndex, buf, wLength);
> +			if (!ret) {
> +				spin_lock_irqsave(&priv->overcurrent_lock,
> +						  flags);
> +				if (!priv->overcurrent_status)
> +					gpiod_set_value_cansleep(priv->power,
> +								 0);
> +				spin_unlock_irqrestore(&priv->overcurrent_lock,
> +						       flags);
> +			}
> +			return ret;
> +		}
> +		if (typeReq == ClearPortFeature &&
> +		    wValue == USB_PORT_FEAT_POWER) {
> +			ret = ohci_hub_control(hcd, typeReq, wValue,
> +					       wIndex, buf, wLength);
> +			if (!ret && priv->power)
> +				gpiod_set_value_cansleep(priv->power, 1);
> +			return ret;
> +		}
> +	}
> +
> +	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
> +	if (ret)
> +		return ret;
> +
> +	if (!priv->overcurrent)
> +		return ret;
> +
> +	if (typeReq == ClearPortFeature && wIndex == 1 &&
> +	    wValue == USB_PORT_FEAT_C_OVER_CURRENT) {
> +		spin_lock_irqsave(&priv->overcurrent_lock, flags);
> +		priv->overcurrent_changed = false;
> +		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);

Why do you need a lock to change a single value?  Are you sure these
locks are even needed, they feel really wrong as you are using them
here.

Also, why not use guard()?  Is it because LLMs don't know about them
yet?

thanks,

greg k-h
