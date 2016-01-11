From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/3] dra7xx: get pcie working in mainline
Date: Mon, 11 Jan 2016 11:12:35 -0600
Message-ID: <5693E283.3090000@ti.com>
References: <1452440488-28398-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452440488-28398-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 01/10/2016 09:41 AM, Kishon Vijay Abraham I wrote:
> This series adds pdata-quirk mechanism to reset PCIe as a temporary
> fix till reset controller driver is added in mainline.
> 
> Without this series, a stall is observed if pci dra7xx driver
> is enabled.
> 
> Kishon Vijay Abraham I (3):
>   ARM: DRA7: hwmod: Add reset data for PCIe
>   HACK: ARM: DRA7: add pdata-quirks to do reset of PCIe
>   HACK: pci: dra7xx: use pdata callbacks to perform reset

Please drop the HACK: tag from the commit headers, that was an internal
convention/choice made by Sekhar, and we had our differences there as it
is. On the same note, my internal Reviewed-by also mean nothing as they
were done against a different kernel.

regards
Suman

> 
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 ++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c        |   11 ++++++++++
>  arch/arm/mach-omap2/prm7xx.h              |    1 +
>  drivers/pci/host/pci-dra7xx.c             |   32 +++++++++++++++++++++++++++++
>  include/linux/platform_data/pci-dra7xx.h  |   22 ++++++++++++++++++++
>  5 files changed, 81 insertions(+)
>  create mode 100644 include/linux/platform_data/pci-dra7xx.h
> 
