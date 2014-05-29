From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 03/18] PCI: designware: Configuration space should be specified in 'reg'
Date: Thu, 29 May 2014 10:03:54 -0500
Message-ID: <98E18225-3C63-4106-901A-A5D3DEC268C8@codeaurora.org>
References: <1401345500-20188-1-git-send-email-kishon@ti.com> <1401345500-20188-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1401345500-20188-4-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, arnd@arndb.de, tony@atomide.com, Mohit Kumar <mohit.kumar@st.com>, jg1.han@samsung.com, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-omap@vger.kernel.org


On May 29, 2014, at 1:38 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:

> The configuration address space has so far been specified in *ranges*,
> however it should be specified in *reg* making it a platform MEM resource.
> Hence used 'platform_get_resource_*' API to get configuration address
> space in the designware driver.
> 
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> .../devicetree/bindings/pci/designware-pcie.txt    |    1 +
> drivers/pci/host/pcie-designware.c                 |   17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 2 deletions(-)

Why should the cfg space be defined in *reg* instead of ranges?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
