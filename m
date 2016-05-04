From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-board-common: Describe the voltage supply
 mapping accurately
Date: Wed, 4 May 2016 14:50:36 -0500
Message-ID: <572A528C.4090302@ti.com>
References: <1462389618-28860-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462389618-28860-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/04/2016 02:20 PM, Nishanth Menon wrote:
[...]

> @@ -551,6 +590,8 @@
>  
>  				ldo9_reg: ldo9 {
>  					/* VCC_DV_SDIO: vdds_sdcard */
> +					vin-supply = <&vmmcsdio_fixed>;
> +

There is an extra white space here, and vmmcsd_fixed is the regulator
to be used, looks like vmmcsdio_fixed should ideally been vwlan_fixed
or something.. the actual rail to LDO9_IN was called vmmc_3v3_SDIO..

Sorry for the confusion. Unfortunately, I can not recreate the fail on
my board, but this sounded like the closest fix I can think of.




-- 
Regards,
Nishanth Menon
