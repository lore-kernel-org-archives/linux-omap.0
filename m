From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-lxm: Use rmii-clock-ext
Date: Fri, 6 Mar 2015 09:03:01 -0800
Message-ID: <20150306170300.GS13520@atomide.com>
References: <1424969294-5993-1-git-send-email-george.mccollister@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1424969294-5993-1-git-send-email-george.mccollister@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: George McCollister <george.mccollister@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* George McCollister <george.mccollister@gmail.com> [150226 08:53]:
> Use external clock for RMII since the internal clock doesn't meet the
> jitter requirements.
> 
> Signed-off-by: George McCollister <george.mccollister@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-lxm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
> index 7266a00..5c5667a 100644
> --- a/arch/arm/boot/dts/am335x-lxm.dts
> +++ b/arch/arm/boot/dts/am335x-lxm.dts
> @@ -328,6 +328,10 @@
>  	dual_emac_res_vlan = <3>;
>  };
>  
> +&phy_sel {
> +	rmii-clock-ext;
> +};
> +
>  &mac {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&cpsw_default>;

Applying into omap-for-v4.0/fixes thanks.

Tony
