From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] arm/dts: Add initial DT support for AM33XX SoC family
Date: Fri, 6 Jul 2012 00:24:13 -0700
Message-ID: <20120706072412.GK1122@atomide.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
 <1340358050-29560-3-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9EF09F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9EF09F@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson,
 Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* AnilKumar, Chimata <anilkumar@ti.com> [120705 01:21]:
> 
> I realized that for mcspi and mmc, the compatible name supposed tobe close to
> omap4-mcspi. 
> These changes seems to went from my local branch, so could you please merge 
> below patch with this
> 5fc0b42a98556bd9f01cecc6a64fcbd15ec363f0 "arm/dts: Add initial DT
> support for AM33XX SoC family"

I don't quite follow, do you mean you want to change some compatible names?
Your patch is just removing entries though?

Anyways, please just send a fix with a proper description and Signed-off-by
on top of the devel-dt branch.

Regards,

Tony 
 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 1e7b98f..258b10e 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -166,36 +166,5 @@
>                         #size-cells = <0>;
>                         ti,hwmods = "i2c3";
>                 };
> -
> -               mcspi1: spi@48030000 {
> -                       compatible = "ti,omap2-mcspi";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       ti,hwmods = "spi0";
> -                       ti,spi-num-cs = <4>;
> -               };
> -
> -               mcspi2: spi@481Aa000 {
> -                       compatible = "ti,omap2-mcspi";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       ti,hwmods = "spi1";
> -                       ti,spi-num-cs = <2>;
> -               };
> -
> -               mmc1: mmc@48060000 {
> -                       compatible = "ti,omap3-hsmmc";
> -                       ti,hwmods = "mmc1";
> -               };
> -
> -               mmc2: mmc@481D8000 {
> -                       compatible = "ti,omap3-hsmmc";
> -                       ti,hwmods = "mmc2";
> -               };
> -
> -               mmc3: mmc@47810000 {
> -                       compatible = "ti,omap3-hsmmc";
> -                       ti,hwmods = "mmc3";
> -               };
>         };
>  };
> --
> 
> Thanks
> AnilKumar
