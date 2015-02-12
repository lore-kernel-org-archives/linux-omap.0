From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: omap3-pandora: include in dts Makefile
Date: Thu, 12 Feb 2015 08:04:29 -0800
Message-ID: <20150212160429.GM2531@atomide.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-5-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1423746226-700-5-git-send-email-marek@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Belisko <marek@goldelico.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek@goldelico.com> [150212 05:07]:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd..69f3106 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -343,6 +343,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
>  	omap3-overo-storm-tobi.dtb \
>  	omap3-overo-summit.dtb \
>  	omap3-overo-tobi.dtb \
> +	omap3-pandora-600mhz.dtb \
> +	omap3-pandora-1ghz.dtb \
>  	omap3-sbc-t3517.dtb \
>  	omap3-sbc-t3530.dtb \
>  	omap3-sbc-t3730.dtb \

This change you can fold into patches 3 and 4 :)

Regards,

Tony
