From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 03/13] phy: omap-control: update dra7 and am437 usb2
 bindings
Date: Thu, 6 Mar 2014 21:11:54 +0530
Message-ID: <53189742.3060705@ti.com>
References: <1394116729-28811-1-git-send-email-rogerq@ti.com>
 <1394116729-28811-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394116729-28811-4-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, balbi@ti.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On Thursday 06 March 2014 08:08 PM, Roger Quadros wrote:
> The dra7-usb2 and am437-usb2 bindings have not yet been used.
> Change them to be more elegant.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   Documentation/devicetree/bindings/phy/ti-phy.txt | 4 ++--

Here too..
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Regards
Kishon
>   drivers/phy/phy-omap-control.c                   | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index 5c5b1b0..28e674b 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -9,9 +9,9 @@ Required properties:
>                           e.g. USB2_PHY on OMAP5.
>    "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
>                           e.g. USB3 PHY and SATA PHY on OMAP5.
> - "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
> + "ti,control-phy-dra7-usb2" - if it has power down register like USB2 PHY on
>                           DRA7 platform.
> - "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
> + "ti,control-phy-am437-usb2" - if it has power down register like USB2 PHY on
>                           AM437 platform.
>    - reg : Address and length of the register set for the device. It contains
>      the address of "otghs_control" for control-phy-otghs or "power" register
> diff --git a/drivers/phy/phy-omap-control.c b/drivers/phy/phy-omap-control.c
> index 17fc200..a7e2d7f 100644
> --- a/drivers/phy/phy-omap-control.c
> +++ b/drivers/phy/phy-omap-control.c
> @@ -228,11 +228,11 @@ static const struct of_device_id omap_control_phy_id_table[] = {
>   		.data = &pipe3_data,
>   	},
>   	{
> -		.compatible = "ti,control-phy-dra7usb2",
> +		.compatible = "ti,control-phy-dra7-usb2",
>   		.data = &dra7usb2_data,
>   	},
>   	{
> -		.compatible = "ti,control-phy-am437usb2",
> +		.compatible = "ti,control-phy-am437-usb2",
>   		.data = &am437usb2_data,
>   	},
>   	{},
>
