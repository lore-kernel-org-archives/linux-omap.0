From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 0/4] usb: dwc3: dual-role support
Date: Fri, 10 Jun 2016 16:26:09 +0300
Message-ID: <575ABFF1.1040503@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/06/16 16:17, Roger Quadros wrote:
> Hi,
> 
> This series adds dual role support to dwc3 controller driver.
> Series depends on the OTG/dual-role framework [1].
> 
> [1] - http://thread.gmane.org/gmane.linux.usb.general/143568
> 
> Patches are based on Felipe's balbi/usb.git testing/next

This patch is also a pre-requisite for this series.
http://article.gmane.org/gmane.linux.kernel/2240761

> 
> Changelog:
> 
> v7:
> - rebased to v4.7-rc1 + balbi/usb.git testing/next
> - cleaned up otg irq resource code
> 
> v6:
> - use just otg irq to get otg events and don't depend on extcon at all.
> - follow OTG flow in TRM strictly.
> - use tracepoints instead of dev_dbg().
> - match IRQ flags in dwc3_omap and core.c for shared otg interrupt.
> 
> v5: Internal revision. Not sent to mailing list.
> 
> v4: first version that was reviewed.
> 
> cheers,
> -roger
> 
> 
> Roger Quadros (4):
>   usb: dwc3: core.h: add some register definitions
>   usb: dwc3: add dual-role support
>   ARM: dts: dra7*-evm: Enable dual-role for usb1
>   ARM: dts: am43xx: Enable dual-role on USB1
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts     |   5 +-
>  arch/arm/boot/dts/am437x-sk-evm.dts     |   5 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts    |   5 +-
>  arch/arm/boot/dts/dra7-evm.dts          |   5 +-
>  arch/arm/boot/dts/dra72-evm-common.dtsi |   5 +-
>  drivers/usb/dwc3/core.c                 | 546 +++++++++++++++++++++++++++++++-
>  drivers/usb/dwc3/core.h                 | 114 ++++++-
>  drivers/usb/dwc3/gadget.c               |   6 +-
>  drivers/usb/dwc3/host.c                 |   2 +
>  9 files changed, 677 insertions(+), 16 deletions(-)
> 
