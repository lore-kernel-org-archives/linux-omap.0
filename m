From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: dts: dra7-evm: fix qspi device tree partition
 size
Date: Mon, 5 Jan 2015 14:26:35 -0800
Message-ID: <20150105222634.GK4081@atomide.com>
References: <1418977385-7886-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418977385-7886-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm@ti.com> [141219 00:25]:
> 64KiB is allocated for qspi dtb partition which is not
> sufficient, so updating the partition table size to 512KiB
> for device tree partition.
> 
> This also aligns the QSPI partition definitions between
> kernel and U-Boot.
> 
> Fixes: dc2dd5b8 ("ARM: dts: dra7: Add qspi device")
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
> 
> This patch is tested on Linux next and the boot logs at [1]
> 
> [1] - http://pastebin.ubuntu.com/9567672/

Applying into omap-for-v3.19/fixes thanks.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7-evm.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 736092b..235d001 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -499,23 +499,23 @@
>  		};
>  		partition@5 {
>  			label = "QSPI.u-boot-spl-os";
> -			reg = <0x00140000 0x00010000>;
> +			reg = <0x00140000 0x00080000>;
>  		};
>  		partition@6 {
>  			label = "QSPI.u-boot-env";
> -			reg = <0x00150000 0x00010000>;
> +			reg = <0x001c0000 0x00010000>;
>  		};
>  		partition@7 {
>  			label = "QSPI.u-boot-env.backup1";
> -			reg = <0x00160000 0x0010000>;
> +			reg = <0x001d0000 0x0010000>;
>  		};
>  		partition@8 {
>  			label = "QSPI.kernel";
> -			reg = <0x00170000 0x0800000>;
> +			reg = <0x001e0000 0x0800000>;
>  		};
>  		partition@9 {
>  			label = "QSPI.file-system";
> -			reg = <0x00970000 0x01690000>;
> +			reg = <0x009e0000 0x01620000>;
>  		};
>  	};
>  };
> -- 
> 2.2.1.62.g3f15098
> 
