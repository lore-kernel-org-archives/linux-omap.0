From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/4] phy: ti: Add AM654 USB2 support
Date: Wed, 9 Jan 2019 11:14:21 +0200
Message-ID: <5C35BB6D.2030509@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 05/12/18 17:03, Roger Quadros wrote:
> Hi Kishon,
> 
> This series extends omap-usb2 PHY driver to be used
> for AM654 USB2 PHY.

Any comments on this series? If it looks fine, could you please
queue this for -next. Thanks.

cheers,
-roger

> 
> cheers,
> -roger
> 
> Roger Quadros (4):
>   phy: ti: usb2: Fix logic on -EPROBE_DEFER
>   phy: ti: Don't depend on OMAP_OCP2SCP
>   dt-bindings: phy: ti: Add support for AM654x USB2 PHY
>   phy: ti: usb2: Add support for AM654 USB2 PHY
> 
>  Documentation/devicetree/bindings/phy/ti-phy.txt |   1 +
>  drivers/phy/ti/Kconfig                           |   6 +-
>  drivers/phy/ti/phy-omap-usb2.c                   | 105 ++++++++++++++---------
>  3 files changed, 67 insertions(+), 45 deletions(-)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
