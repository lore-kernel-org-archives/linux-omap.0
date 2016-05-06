From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-idk-common: Fix input supply names
Date: Fri, 6 May 2016 07:48:12 -0500
Message-ID: <572C928C.3080308@ti.com>
References: <1462493125-27832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462493125-27832-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/05/2016 07:05 PM, Nishanth Menon wrote:
[...]
>  				ldortc_reg: ldortc {
>  					/* VDDA_RTC  */
>  					vin-supply = <&vmain>;
> -					regulator-name = "ldortc";
I deleted the wrong line here!

Will repost. Sorry for the noise.

-- 
Regards,
Nishanth Menon
