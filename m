From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 03/22] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
Date: Fri, 17 Feb 2017 17:31:13 +0530
Message-ID: <58A6E609.9070709@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1487325042-28227-4-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 17 February 2017 03:20 PM, Kishon Vijay Abraham I wrote:
> Introduce a new configfs entry to configure the EP function (like
> configuring the standard configuration header entries) and to
> bind the EP function with EP controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/Kconfig      |   14 +-
>  drivers/pci/endpoint/Makefile     |    1 +
>  drivers/pci/endpoint/pci-ep-cfs.c |  427 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 440 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
> 
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index 7eb1c79..8470f0b 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -6,7 +6,6 @@ menu "PCI Endpoint"
>  
>  config PCI_ENDPOINT
>  	bool "PCI Endpoint Support"
> -	select CONFIGFS_FS
>  	help
>  	   Enable this configuration option to support configurable PCI
>  	   endpoint. This should be enabled if the platform has a PCI
> @@ -14,8 +13,19 @@ config PCI_ENDPOINT
>  
>  	   Enabling this option will build the endpoint library, which
>  	   includes endpoint controller library and endpoint function
> -	   library.
> +	   library. This will also enable the configfs entry required to
> +	   configure the endpoint function and used to bind the
> +	   function with a endpoint controller.

This chunk shouldn't be added. I've missed removing this (it's added below).
I'll wait to get other review comments before sending a new revision.

Thanks
Kishon
