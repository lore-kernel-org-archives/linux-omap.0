From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 04/37] PCI: dwc: designware: Move the register defines to
 designware header file
Date: Fri, 13 Jan 2017 16:35:03 +0000
Message-ID: <0913dcb3-ecb8-b926-981d-f5d3baa9d8b7@synopsys.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1484216786-17292-5-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


Às 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Move the register defines and other macros from
> pcie-designware.c to pcie-designware.h. This is in preparation to
> split the pcie-designware.c file into designware core file and host
> specific file.
> 
> While at that also fix a checkpatch warning.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |   70 ------------------------------------
>  drivers/pci/dwc/pcie-designware.h |   71 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index d68bc7b..0b928dc 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -25,76 +25,6 @@
>  
>  #include "pcie-designware.h"

Make sense.

Reviewed-By: Joao Pinto <jpinto@synopsys.com>
