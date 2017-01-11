From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 0/3] PCI: designware/dra7xx: misc fixes and cleanups
Date: Wed, 11 Jan 2017 15:21:35 -0600
Message-ID: <20170111212135.GN14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1483091774-8332-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483091774-8332-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 30, 2016 at 03:26:11PM +0530, Kishon Vijay Abraham I wrote:
> This series contains
>         *) a patch to cleanup dra7xx probe
>         *) a patch to force DRA7xx controller to work in GEN1 mode
>         *) a patch to fix dra7xx driver so that even if CONFIG_PCI_MSI
>            is enabled, dra7xx driver can service legacy interrupts
>            (provided the device support only legacy interrupts).
> 
> Changes from v1:
> *) rebased to 4.10-rc1 (and [1])
> *) use existing dt property "max-link-speed" instead of creating a new
>    TI specific dt property.
> 
> [1] -> https://lkml.org/lkml/2016/12/28/34
> 
> Kishon Vijay Abraham I (3):
>   PCI: dra7xx: simplify the probe code
>   PCI: dra7xx: Add support to force RC to work in GEN1 mode
>   PCI: dra7xx: Enable MSI and legacy interrupts simultaneously
> 
>  drivers/pci/controller/pci-dra7xx.c |   81 ++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 34 deletions(-)

Applied to pci/host-dra7xx for v4.11.  I haven't applied the directory
rename yet, so I'll fix that up as necessary.

Bjorn
