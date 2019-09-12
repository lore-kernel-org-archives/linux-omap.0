From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 10/10] ARM: OMAP2+: pdata-quirks: add PRM data for
 reset support
Date: Thu, 12 Sep 2019 10:09:53 -0700
Message-ID: <20190912170953.GT52127@atomide.com>
References: <20190912113916.20093-1-t-kristo@ti.com>
 <20190912113916.20093-11-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190912113916.20093-11-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190912 11:40]:
> @@ -565,6 +566,12 @@ void omap_pcs_legacy_init(int irq, void (*rearm)(void))
>  	pcs_pdata.rearm = rearm;
>  }
>  
> +static struct ti_prm_platform_data ti_prm_pdata = {
> +	.clkdm_deny_idle = clkdm_deny_idle,
> +	.clkdm_allow_idle = clkdm_allow_idle,
> +	.clkdm_lookup = clkdm_lookup,
> +};
> +
>  /*
>   * GPIOs for TWL are initialized by the I2C bus and need custom
>   * handing until DSS has device tree bindings.
> @@ -664,6 +671,11 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
>  	/* Common auxdata */
>  	OF_DEV_AUXDATA("ti,sysc", 0, NULL, &ti_sysc_pdata),
>  	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
> +	OF_DEV_AUXDATA("ti,omap4-prm-inst", 0, NULL, &ti_prm_pdata),
> +	OF_DEV_AUXDATA("ti,omap5-prm-inst", 0, NULL, &ti_prm_pdata),
> +	OF_DEV_AUXDATA("ti,dra7-prm-inst", 0, NULL, &ti_prm_pdata),
> +	OF_DEV_AUXDATA("ti,am3-prm-inst", 0, NULL, &ti_prm_pdata),
> +	OF_DEV_AUXDATA("ti,am4-prm-inst", 0, NULL, &ti_prm_pdata),
>  	{ /* sentinel */ },
>  };

Hmm I think I already commented on this.. Just one entry please:

	OF_DEV_AUXDATA("ti,omap-prm-inst", 0, NULL, &ti_prm_pdata),

As the auxdata is the same for all of them. Note that all the
dts files need to have also the generic compatible
"ti,omap-prm-inst" after the SoC specific one.

Regards,

Tony
