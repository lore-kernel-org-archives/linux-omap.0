From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
Date: Mon, 18 Jan 2016 14:42:55 +0530
Message-ID: <569CAC97.3030703@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-3-git-send-email-kishon@ti.com> <56994640.3090704@ti.com>
 <20160115192224.GD3904@atomide.com> <56994B72.2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56994B72.2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday 16 January 2016 01:11 AM, Suman Anna wrote:
> On 01/15/2016 01:22 PM, Tony Lindgren wrote:
>> * Suman Anna <s-anna@ti.com> [160115 11:20]:
>>> On 01/14/2016 08:11 AM, Kishon Vijay Abraham I wrote:
>>>> Create platform data for PCIe and populate it with function
>>>> pointers to perform assert and deassert of PCIe reset lines.
>>>> The PCIe driver can use the callbacks provided here to
>>>> reset the PCIe.
>>>> This will be removed once the reset contoller driver is
>>>> available to reset PCIe.
>> ...
>>
>>>> +/**
>>>> + * struct pci_dra7xx_platform_data - platform data specific to pci in dra7xx
>>>> + * @reset_name: name of the reset line
>>>> + * @assert_reset: callback for performing assert reset operation
>>>> + * @deassert_reset: callback for performing deassert reset operation
>>>> + */
>>>> +struct pci_dra7xx_platform_data {
>>>> +	const char *reset_name;
>>>> +
>>>> +	int (*assert_reset)(struct platform_device *pdev, const char *name);
>>>> +	int (*deassert_reset)(struct platform_device *pdev, const char *name);
>>>> +};
>>
>> I doubt this platform_data is dra7 specific. I believe it's
>> the same PCI controller that has been in the omap variants for
>> years?
> 
> AFAIK, this only applies to DRA7. Sekhar/Kishon can confirm. I did take
> a quick look at OMAP3/4/5 TRMs, and didn't find any. Neither did a grep
> on current hwmod files other than DRA7. There's a DM81xx related PCI
> clock domain, but don't see any corresponding driver/device for the same.

Like Suman, I do not know of any TI SoC that came off the OMAP mobile
business that has PCIe.

DM81xx has a PCIe (but no mainline driver). Both DM81xx and DRA7x use a
designware core. But, the glue layer (which is the subject of interest
here), is completely different. I looked at the DM81xx driver in TI
kernel[1] to confirm this.

I remember talking to Kishon about similarities between the DM81xx and
DRA7x PCIe subsystem and remember that he too mentioned that they are
quite different.

For an IP like PCIeSS, its quite difficult to come-up with unique names
without using the name of the platform they first appeared in. Anyway,
the driver is already called "pci-dra7xx", so I guess there is no harm
in having that name in platform data as well. That in itself should not
preclude its use on other platforms later (although I agree having a
generic name would be ideal).

Thanks,
Sekhar

PS: Kishon is out-of-office till the end of the month

[1]
http://arago-project.org/git/projects/?p=linux-omap3.git;a=blob;f=arch/arm/mach-omap2/pcie-ti81xx.c;h=05ae4f1df85a35e91a770435c50777a31de4f1ca;hb=4f1fb3bea4cc381c76e8e439f8af393c1a698dfc#l70
