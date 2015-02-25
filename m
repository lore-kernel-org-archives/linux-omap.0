From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: enable aes and sham
Date: Wed, 25 Feb 2015 12:36:11 -0600
Message-ID: <CAOCHtYju0ZPV-BZS=L5S+JUX4gcRkJwqUZQBuURgGMo_Nmqt7g@mail.gmail.com>
References: <1424884070-25891-1-git-send-email-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424884070-25891-1-git-send-email-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@konsulko.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 25, 2015 at 11:07 AM, Matt Porter <mporter@konsulko.com> wrote:
> Beaglebone Black doesn't have AES and SHAM enabled like the
> original Beaglebone White dts. This breaks applications that
> leverage the crypto blocks so fix this by enabling these nodes.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>
> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 5c42d25..00853ff 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -33,6 +33,14 @@
>         status = "okay";
>  };
>
> +&sham {
> +       status = "okay";
> +};
> +
> +&aes {
> +       status = "okay";
> +};
> +
>  &am33xx_pinmux {
>         nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
>                 pinctrl-single,pins = <
> --
> 1.8.4

Shouldn't we just move these to: "am335x-bone-common.dtsi" ?

(and then nuke the 6 lines in the am335x-bone.dts )

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
