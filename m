From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] video: fix composite video connector compatible string
Date: Wed, 03 Sep 2014 00:13:05 +0300
Message-ID: <5403142.A0DomZZZZ1@avalon>
References: <1409643346-8656-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1409643346-8656-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Tuesday 02 September 2014 10:35:46 Tomi Valkeinen wrote:
> The quite-recently-added analog-tv-connector bindings say that the
> compatible string for composite video connector is
> "composite-connector". That string is also used in the omap3-n900.dts
> file. However, the connector driver uses "composite-video-connector", so
> this has never worked.
> 
> While changing the driver's compatible string to "composite-connector"
> would be safer, as published DT bindings should not be changed, I'd
> rather fix the bindings in this case for two reasons:
> 
> * composite-connector is a bit too generic name, as it doesn't even hint
>   at video.
> * it's clear that this has never worked, which means no one has used
>   those bindings, which should make it safe to change this.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/video/analog-tv-connector.txt | 4 ++--
>  arch/arm/boot/dts/omap3-n900.dts                                | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/analog-tv-connector.txt
> b/Documentation/devicetree/bindings/video/analog-tv-connector.txt index
> 0218fcdc1299..0c0970c210ab 100644
> --- a/Documentation/devicetree/bindings/video/analog-tv-connector.txt
> +++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
> @@ -2,7 +2,7 @@ Analog TV Connector
>  ===================
> 
>  Required properties:
> -- compatible: "composite-connector" or "svideo-connector"
> +- compatible: "composite-video-connector" or "svideo-connector"
> 
>  Optional properties:
>  - label: a symbolic name for the connector
> @@ -14,7 +14,7 @@ Example
>  -------
> 
>  tv: connector {
> -	compatible = "composite-connector";
> +	compatible = "composite-video-connector";
>  	label = "tv";
> 
>  	port {
> diff --git a/arch/arm/boot/dts/omap3-n900.dts
> b/arch/arm/boot/dts/omap3-n900.dts index 1fe45d1f75ec..4361777a08d8 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -93,7 +93,7 @@
>  	};
> 
>  	tv: connector {
> -		compatible = "composite-connector";
> +		compatible = "composite-video-connector";
>  		label = "tv";
> 
>  		port {

-- 
Regards,

Laurent Pinchart
