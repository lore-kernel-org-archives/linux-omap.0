From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
Date: Thu, 10 Oct 2013 09:19:50 -0500
Message-ID: <20131010141949.GA13277@kahuna>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1381402195-29257-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 16:19-20131010, Kishon Vijay Abraham I wrote:
> smps10 should be enabled only in the case of host mode. So stop
> doing always_on, boot_on from smps10_out1. The driver will enable it in host
> mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index d784b3a..e06a04a 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -334,8 +334,6 @@
>  					regulator-name = "smps10_out1";
>  					regulator-min-microvolt = <5000000>;
>  					regulator-max-microvolt = <5000000>;
> -					regulator-always-on;
> -					regulator-boot-on;
>  				};
>  
>  				ldo1_reg: ldo1 {
> -- 
Always good to get rid of regulator-always-on. Thanks for it.

regulator-boot-on indicates that PMIC enables it by default as part of
OTP or some internal behavior -> Looking at the measurements done on
uEVM and OTP information -> regulator-boot-on should be kept here.

Hence Nak.
-- 
Regards,
Nishanth Menon
