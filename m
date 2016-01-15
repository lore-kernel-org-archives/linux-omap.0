From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
Date: Fri, 15 Jan 2016 13:41:38 -0600
Message-ID: <56994B72.2@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-3-git-send-email-kishon@ti.com> <56994640.3090704@ti.com>
 <20160115192224.GD3904@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115192224.GD3904@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On 01/15/2016 01:22 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [160115 11:20]:
>> On 01/14/2016 08:11 AM, Kishon Vijay Abraham I wrote:
>>> Create platform data for PCIe and populate it with function
>>> pointers to perform assert and deassert of PCIe reset lines.
>>> The PCIe driver can use the callbacks provided here to
>>> reset the PCIe.
>>> This will be removed once the reset contoller driver is
>>> available to reset PCIe.
> ...
> 
>>> +/**
>>> + * struct pci_dra7xx_platform_data - platform data specific to pci in dra7xx
>>> + * @reset_name: name of the reset line
>>> + * @assert_reset: callback for performing assert reset operation
>>> + * @deassert_reset: callback for performing deassert reset operation
>>> + */
>>> +struct pci_dra7xx_platform_data {
>>> +	const char *reset_name;
>>> +
>>> +	int (*assert_reset)(struct platform_device *pdev, const char *name);
>>> +	int (*deassert_reset)(struct platform_device *pdev, const char *name);
>>> +};
> 
> I doubt this platform_data is dra7 specific. I believe it's
> the same PCI controller that has been in the omap variants for
> years?

AFAIK, this only applies to DRA7. Sekhar/Kishon can confirm. I did take
a quick look at OMAP3/4/5 TRMs, and didn't find any. Neither did a grep
on current hwmod files other than DRA7. There's a DM81xx related PCI
clock domain, but don't see any corresponding driver/device for the same.

regards
Suman
