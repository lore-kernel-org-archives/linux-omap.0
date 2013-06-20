From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: OMAP2+: Add mailbox nodes
Date: Wed, 19 Jun 2013 19:11:11 -0700
Message-ID: <CA+Bv8XZsn1ObNjx7pzwE4AtH2eAvZgrj90hZwP67QRPJJBbGNA@mail.gmail.com>
References: <1371594900-37640-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:42356 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935536Ab3FTCLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 22:11:12 -0400
Received: by mail-qe0-f54.google.com with SMTP id ne12so3743687qeb.27
        for <linux-omap@vger.kernel.org>; Wed, 19 Jun 2013 19:11:11 -0700 (PDT)
In-Reply-To: <1371594900-37640-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Tue, Jun 18, 2013 at 3:35 PM, Suman Anna <s-anna@ti.com> wrote:
> The mailbox DT node data has been added for OMAP2420,
> OMAP2430, OMAP3430/OMAP3630, OMAP44xx devices. Data for
> OMAP5 is skipped for now since the corresponding hwmod
> entry is not present.
>
> The mailbox static device initialization logic is also
> adjusted for a DT boot.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/omap2420.dtsi | 13 +++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi | 12 ++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    | 12 ++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    | 12 ++++++++++++
>  arch/arm/mach-omap2/devices.c   |  2 +-
>  5 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index c8f9c55..e0f4e47 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -114,6 +114,19 @@
>                         dma-names = "tx", "rx";
>                 };
>
> +               mailbox: mailbox@48094000 {
> +                       compatible = "ti,omap2-mailbox";
> +                       reg = <0x48094000 0x200>;
> +                       interrupts = <26>, /* DSP Interrupt */
> +                                    <34>; /* IVA Interrupt */
> +                       ti,hwmods = "mailbox";
> +                       ti,mbox-num-users = <4>;
> +                       ti,mbox-num-fifos = <6>;
> +                       #ti,mbox-data-cells = <4>;
> +                       ti,mbox-names = "dsp", "iva";
> +                       ti,mbox-data = <0 1 0 0>, <2 3 1 3>;
> +               };
> +
>                 timer1: timer@48028000 {
>                         compatible = "ti,omap2420-timer";
>                         reg = <0x48028000 0x400>;
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index c535a5a..b413423 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -175,6 +175,18 @@
>                         dma-names = "tx", "rx";
>                 };
>
> +               mailbox: mailbox@48094000 {
> +                       compatible = "ti,omap2-mailbox";
> +                       reg = <0x48094000 0x200>;
> +                       interrupts = <26>;
> +                       ti,hwmods = "mailbox";
> +                       ti,mbox-num-users = <4>;
> +                       ti,mbox-num-fifos = <6>;
> +                       #ti,mbox-data-cells = <4>;
> +                       ti,mbox-names = "dsp";
> +                       ti,mbox-data = <0 1 0 0>;
> +               };
> +
>                 timer1: timer@49018000 {
>                         compatible = "ti,omap2420-timer";
>                         reg = <0x49018000 0x400>;
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 6d05ee0..3cc7c28 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -380,6 +380,18 @@
>                         dma-names = "tx", "rx";
>                 };
>
> +               mailbox: mailbox@48094000 {
> +                       compatible = "ti,omap2-mailbox";
> +                       reg = <0x48094000 0x200>;
> +                       interrupts = <26>;
> +                       ti,hwmods = "mailbox";
> +                       ti,mbox-num-users = <2>;
> +                       ti,mbox-num-fifos = <2>;
> +                       #ti,mbox-data-cells = <4>;
> +                       ti,mbox-names = "dsp";
> +                       ti,mbox-data = <0 1 0 0>;
> +               };
> +
>                 timer1: timer@48318000 {
>                         compatible = "ti,omap3430-timer";
>                         reg = <0x48318000 0x400>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 463b97d..0155182 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -516,6 +516,18 @@
>                         };
>                 };
>
> +               mailbox: mailbox@4a0f4000 {
> +                       compatible = "ti,omap4-mailbox";
> +                       reg = <0x4a0f4000 0x200>;
> +                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +                       ti,hwmods = "mailbox";
> +                       ti,mbox-num-users = <3>;
> +                       ti,mbox-num-fifos = <8>;
> +                       #ti,mbox-data-cells = <4>;
> +                       ti,mbox-names = "mbox-ipu", "mbox-dsp";
> +                       ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
> +               };
> +
>                 timer1: timer@4a318000 {
>                         compatible = "ti,omap3430-timer";
>                         reg = <0x4a318000 0x80>;
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 73762ac..2058f24 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -655,11 +655,11 @@ static int __init omap2_init_devices(void)
>         omap_init_audio();
>         omap_init_camera();
>         omap_init_hdmi_audio();
> -       omap_init_mbox();
>         /* If dtb is there, the devices will be created dynamically */
>         if (!of_have_populated_dt()) {
>                 omap_init_control_usb();
>                 omap_init_dmic();
> +               omap_init_mbox();
>                 omap_init_mcpdm();
>                 omap_init_mcspi();
>                 omap_init_sham();
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
