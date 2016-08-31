From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Wed, 31 Aug 2016 13:50:14 -0700
Message-ID: <57C74306.9020901@gmail.com>
References: <20160829223542.18871-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160829223542.18871-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 08/29/16 15:35, Tony Lindgren wrote:
> We have devices that are in incomplete state, but still need to be
> probed to allow properly idling them for PM. Some examples are
> devices that are not pinned out on certain packages, or otherwise
> unusable on some SoCs.
> 
> Setting status = "disabled" cannot be used for this case. Setting
> "disabled" makes Linux ignore these devices so they are not probed
> and can never get idled properly by Linux PM runtime.
> 
> The proper way deal with the incomplete devices is to probe them,
> then allow the driver to check the state, and then disable or idle
> the device using PM runtime. To do this, we need to often enable
> the device and run some device specific code to idle the device.
> 
> Also boards may have needs to disable and idle unused devices.
> This may be needed for example if all resources are not wired
> for a certain board variant.
> 
> It seems we can use the ePAPR 1.1 status fail-sss to do this.
> Quoting "Table 2-4 Values for status property" we have "fail-sss":
> 
> "Indicates that the device is not operational. A serious error was
>  detected in the device and it is unlikely to become operational
>  without repair. The sss portion of the value is specific to the
>  device and indicates the error condition detected."
> 
> We can handle these fail states can be handled in a generic
> way. So let's introduce a generic status = "fail-" that
> describes a situation where a device driver probe should just
> shut down or idle the device if possible and then bail out.
> This allows the SoC variant and board specific dts files to set
> the status as needed.
> 
> The suggested usage in a device driver probe is:
> 
> static int foo_probe(struct platform_device *pdev)
> {
> 	int err;
> 	const char *status;
> 	...
> 
>         pm_runtime_enable(&pdev->dev);
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_use_autosuspend(&pdev->dev);
> 	...
> 
> 	/* Configure device, load firmware, idle device */
> 	...
> 
> 	if (of_device_is_incomplete(pdev->dev.of_node, status)) {
> 		if (!strcmp("hw-incomplete-pins", status)) {
> 			dev_info(&pdev->dev,
> 				 "Unusable hardware: Not pinned out\n");
> 			err = -ENODEV;
> 			goto out;
> 		}
> 		if (!strcmp("hw-missing-daughter-card")) {
> 			err = -EPROBE_DEFER;
> 			goto out;
> 		}
> 		if (!strcmp("hw-buggy-dma")) {
> 			dev_warn(&pdev->dev,
> 				 "Replace hardware for working DMA\n");
> 		}
> 	}

What if the device has two issues to be reported?  You can not
specify two different values for the status property.

What if the firmware wants to report that the hardware failed
self-test (thus status = "fail-sss") but is already using
status to describe the hardware?


> 
> 	/* Continue normal device probe */
> 	...
> 
> 	return 0;
> 
> out:
> 	pm_runtime_dont_use_autosuspend(&pdev->dev);
> 	pm_runtime_put_sync(&pdev->dev);
> 	pm_runtime_disable(&pdev->dev);
> 
> 	return err;
> }
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> Changes since v1 ([PATCH] of: Add generic handling for hardware incomplete
> fail state):
> 
> - Make more generic as suggested by Frank but stick with
>   "operational status of a device" approch most people seem
>   to prefer that

I am still opposed to using the status property for this purpose.

The status property is intended to report an operational problem with
a device or a device that the kernel can cause to be operational (such
as a quiescent cpu being enabled).  It is the only property I am aware
of to report _state_.

It is unfortunate that Linux has adopted the practice of overloading status
to determine whether a piece of hardware exists or does not exist.  This
is extremely useful for the way we structure the .dts and .dtsi files but
should have used a new property name.  We are stuck with that choice of
using the status property for two purposes, first the state of a device,
and secondly the hardware description of existing or not existing.

Why not just create a new property that describes the hardware?
Perhaps something like:

   incomplete = "pins_output", "buggy_dma";


> - Pass the failure status back to caller so the caller may
>   attempt to handle the failure status
> 
> - Improved the description with more examples
> 
>  drivers/of/base.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/of.h |  8 +++++++
>  2 files changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ff37f6d..4d39857 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -550,8 +550,8 @@ EXPORT_SYMBOL(of_machine_is_compatible);
>   *
>   *  @device: Node to check for availability, with locks already held
>   *
> - *  Returns true if the status property is absent or set to "okay" or "ok",
> - *  false otherwise
> + *  Returns true if the status property is absent or set to "okay", "ok",
> + *  or starting with "fail-", false otherwise
>   */
>  static bool __of_device_is_available(const struct device_node *device)
>  {
> @@ -566,7 +566,8 @@ static bool __of_device_is_available(const struct device_node *device)
>  		return true;
>  
>  	if (statlen > 0) {
> -		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
> +		if (!strcmp(status, "okay") || !strcmp(status, "ok") ||
> +		    !strncmp(status, "fail-", 5))
>  			return true;
>  	}
>  
> @@ -595,6 +596,63 @@ bool of_device_is_available(const struct device_node *device)
>  EXPORT_SYMBOL(of_device_is_available);
>  
>  /**
> + *  __of_device_is_incomplete - check if a device is incomplete

It is not checking if a device is incomplete.  It is checking whether the
device is operational _or_ incomplete.

This is conflating concepts and likely to be confusing.  This is the problem
with overloading the status property for yet another purpose.


> + *
> + *  @device: Node to check for partial failure with locks already held
> + *  @status: Status string for optional handling of the fail-sss state
> + */
> +static bool __of_device_is_incomplete(const struct device_node *device,
> +				      const char **status)
> +{
> +	const char *s, *m = "fail-";
> +	int slen, mlen;
> +
> +	if (!device)
> +		return false;
> +
> +	s = __of_get_property(device, "status", &slen);
> +	if (!s)
> +		return false;
> +
> +	mlen = strlen(m);
> +	if (slen <= mlen)
> +		return false;
> +
> +	if (strncmp("fail-", s, mlen))
> +		return false;
> +
> +	*status = s + mlen;
> +
> +	return true;
> +}
> +
> +/**
> + *  of_device_is_incomplete - check if a device is incomplete
> + *
> + *  @device: Node to check for partial failure
> + *  @status: Status string for optional handling of the fail-sss state
> + *
> + *  Returns true if the status property is set to "fail-sss",
> + *  false otherwise. Fore more information, see fail-sss in ePAPR 1.1
> + *  "Table 2-4 Values for status property".
> + *
> + *  The caller can optionally try to handle the error based on the
> + *  status string.
> + */
> +bool of_device_is_incomplete(const struct device_node *device,
> +			     const char **status)
> +{
> +	unsigned long flags;
> +	bool res;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	res = __of_device_is_incomplete(device, status);
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	return res;
> +}
> +EXPORT_SYMBOL(of_device_is_incomplete);
> +
> +/**
>   *  of_device_is_big_endian - check if a device has BE registers
>   *
>   *  @device: Node to check for endianness
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 3d9ff8e..b593936 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -320,6 +320,8 @@ extern int of_device_is_compatible(const struct device_node *device,
>  extern int of_device_compatible_match(struct device_node *device,
>  				      const char *const *compat);
>  extern bool of_device_is_available(const struct device_node *device);
> +extern bool of_device_is_incomplete(const struct device_node *device,
> +				    const char **status);
>  extern bool of_device_is_big_endian(const struct device_node *device);
>  extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
> @@ -504,6 +506,12 @@ static inline bool of_device_is_available(const struct device_node *device)
>  	return false;
>  }
>  
> +static inline bool of_device_is_incomplete(const struct device_node *device,
> +					   const char **status)
> +{
> +	return false;
> +}
> +
>  static inline bool of_device_is_big_endian(const struct device_node *device)
>  {
>  	return false;
> 
