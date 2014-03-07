From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v3] phy: omap-control: update dra7 and am437 usb2 bindings
Date: Fri, 7 Mar 2014 11:37:57 +0530
Message-ID: <5319623D.5030909@ti.com>
References: <1394171280-13359-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394171280-13359-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Cc: balbi@ti.com, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

On 3/7/2014 11:18 AM, Kishon Vijay Abraham I wrote:
> From: Roger Quadros <rogerq@ti.com>
>
> The dra7-usb2 and am437-usb2 bindings have not yet been used.
> Change them to be more elegant.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v2:
> Kept only the drivers/phy part in this patch
>
>   drivers/phy/phy-omap-control.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
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

Tony suggested to keep the compatible

ti,control-phy-usb2-dra7 and ti,control-phy-usb2-am437

http://www.spinics.net/lists/linux-omap/msg104040.html

Since we already have a ti,control-phy-usb2 I think it make sense to keep the new comaptible for dra7 and am437 as above.

>   		.data = &am437usb2_data,
>   	},
>   	{},


-- 
-George
