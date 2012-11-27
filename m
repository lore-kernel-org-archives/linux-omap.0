From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable twl4030
 SoC audio
Date: Tue, 27 Nov 2012 10:58:10 +0100
Message-ID: <50B48EB2.1040804@ti.com>
References: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/27/2012 02:21 AM, Javier Martinez Canillas wrote:
> Many TI OMAP SoC based boards that uses twl4030 as codec have
> been updated to use the unified audio driver (omap-twl4030)
> since they have similar audio setup.
> =

> So, is good to have it built to add audio support to these boards.
> =

> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

I also agree that it is a good practice to enable this in the defconfig.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap=
2plus_defconfig
> index 7c6cbdf..022212c 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -172,6 +172,7 @@ CONFIG_SND_DEBUG=3Dy
>  CONFIG_SND_USB_AUDIO=3Dm
>  CONFIG_SND_SOC=3Dm
>  CONFIG_SND_OMAP_SOC=3Dm
> +CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dm
>  CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=3Dm
>  CONFIG_USB=3Dy
>  CONFIG_USB_DEBUG=3Dy
> =



-- =

P=E9ter
