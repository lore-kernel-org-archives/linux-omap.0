From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for
 am43x-epos-evm
Date: Fri, 6 Jun 2014 01:53:10 -0500
Message-ID: <53916556.10608@ti.com>
References: <1402035454-25676-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbaFFGxh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jun 2014 02:53:37 -0400
In-Reply-To: <1402035454-25676-1-git-send-email-george.cherian@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, tony@atomide.com, bcousson@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On 06/06/2014 01:17 AM, George Cherian wrote:
> AM437x EPOS evm use external clock for RMII interface.
> Enable the same in DT. 
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 19f1f7e..90098f9 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -319,6 +319,10 @@
>  	phy-mode = "rmii";
>  };
>  
> +&phy_sel {
> +	rmii-clock-ext;
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  	pinctrl-names = "default";
> 
Where does this apply on?
With linux-next next-20140506 tag, and this patch applied, I get the
following error.

  LD      kernel/trace/built-in.o
  LD      kernel/built-in.o
build fail, Error:
Error: arch/arm/boot/dts/am43x-epos-evm.dts:219.2-3 label or path,
'phy_sel', not found
FATAL ERROR: Syntax error parsing input tree
make[1]: *** [arch/arm/boot/dts/am43x-epos-evm.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [dtbs] Error 2
make: *** Waiting for unfinished jobs....

in the future, it is helpful if you can point out that this is a
regression seen on next-20140603 and the patch needs to be applied on
some specific branch.

for the record:
last working next tag:
https://github.com/nmenon/kernel-test-logs/blob/next-20140602/omap2plus_defconfig/am43xx-epos.txt

first broken next tag:
https://github.com/nmenon/kernel-test-logs/blob/next-20140603/omap2plus_defconfig/am43xx-epos.txt


-- 
Regards,
Nishanth Menon
