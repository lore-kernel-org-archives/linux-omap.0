From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
Date: Wed, 27 Jan 2016 09:23:24 -0800
Message-ID: <20160127172323.GP19432@atomide.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-3-git-send-email-kishon@ti.com>
 <56994640.3090704@ti.com>
 <20160115192224.GD3904@atomide.com>
 <56994B72.2@ti.com>
 <569CAC97.3030703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569CAC97.3030703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [160118 01:13]:
> On Saturday 16 January 2016 01:11 AM, Suman Anna wrote:
> > On 01/15/2016 01:22 PM, Tony Lindgren wrote:
> >> I doubt this platform_data is dra7 specific. I believe it's
> >> the same PCI controller that has been in the omap variants for
> >> years?
> > 
> > AFAIK, this only applies to DRA7. Sekhar/Kishon can confirm. I did take
> > a quick look at OMAP3/4/5 TRMs, and didn't find any. Neither did a grep
> > on current hwmod files other than DRA7. There's a DM81xx related PCI
> > clock domain, but don't see any corresponding driver/device for the same.
> 
> Like Suman, I do not know of any TI SoC that came off the OMAP mobile
> business that has PCIe.
> 
> DM81xx has a PCIe (but no mainline driver). Both DM81xx and DRA7x use a
> designware core. But, the glue layer (which is the subject of interest
> here), is completely different. I looked at the DM81xx driver in TI
> kernel[1] to confirm this.

OK thanks for checking.

> I remember talking to Kishon about similarities between the DM81xx and
> DRA7x PCIe subsystem and remember that he too mentioned that they are
> quite different.

OK

> For an IP like PCIeSS, its quite difficult to come-up with unique names
> without using the name of the platform they first appeared in. Anyway,
> the driver is already called "pci-dra7xx", so I guess there is no harm
> in having that name in platform data as well. That in itself should not
> preclude its use on other platforms later (although I agree having a
> generic name would be ideal).

Yeah seems OK to me. I still have some PM runtime related questions
though.. Will reply to the related patch chunk though.

Regards,

Tony
