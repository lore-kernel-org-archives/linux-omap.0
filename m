From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Tue, 25 Mar 2014 10:02:21 -0500
Message-ID: <53319A7D.1060904@ti.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbaCYPCy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Mar 2014 11:02:54 -0400
In-Reply-To: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, nsekhar@ti.com, rnayak@ti.com, mark.rutland@arm.com, Dave Gerlach <d-gerlach@ti.com>

On 03/21/2014 12:20 AM, Lokesh Vutla wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Do not reset GPIO5 at boot-up because GPIO5_7 is used
> on AM437x GP-EVM to control VTT regulators on DDR3.
> Without this some GP-EVM boards will fail to boot because
> of DDR3 corruption.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> This is applied on top of current linux-next.
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index df8798e..a055f7f 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -117,6 +117,11 @@
>  	status = "okay";
>  };
>  
> +&gpio5 {
> +	status = "okay";
> +	ti,no-reset-on-init;
> +};
> +
>  &mmc1 {
>  	status = "okay";
>  	vmmc-supply = <&vmmcsd_fixed>;
> 


Tony,
any chance of having this in 3.15 cycle?

as of today's linux-next tag, the only platform I have that does not
boot is due to the lack of this patch.


next-20140325-omap2plus_defconfig
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s20o6CfGL8
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2Ogu1zPtD
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s2m2WhHYO8
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2jOybaVno
 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21tt52N4b
 6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21eDQmFWJ
 7: beagleboard:  Boot PASS: http://slexy.org/raw/s2q7vzrZHb
 8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2HCAJVz0H
 9: beaglebone:  Boot PASS: http://slexy.org/raw/s2NioACYsM
10: craneboard:  Boot PASS: http://slexy.org/raw/s2s7jyo52c
11:       dra7:  Boot PASS: http://slexy.org/raw/s2OQ1BMerx
12:        ldp:  Boot PASS: http://slexy.org/raw/s2cWgQrdjb
13: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2lOaznVLO
14:    sdp2430:  Boot PASS: http://slexy.org/raw/s21RCJlUDU
15:    sdp3430:  Boot PASS: http://slexy.org/raw/s2181J9eWO
16:    sdp4430:  Boot PASS: http://slexy.org/raw/s20UumAiXK
17: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21ypXvTNc
TOTAL = 17 boards, Booted Boards = 16, No Boot boards = 1

-- 
Regards,
Nishanth Menon
