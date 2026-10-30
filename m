Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362044;
	b=atUkhKDe33hI2YsdWfhZWfqfVXzl7F7BcIyEulkzywlz2W28r+JrF2kjWCMetStzkb/K
	 0bsmy/jHStL5M72ajKgu9CpSyaj2dB1QiJHIe/0rujei2AHJsG5YAjnWd8QjqKI+wOwVB
	 lqEH2D5OvO78nf8gUkGvcqpPYV+py5Nrzs6U7WAH47CMVKehNPofjgY8ABn2xGbFX3lIM
	 wmislCy18ZW/MORyp99OgL2yKXNFddVfXahVuVtGQosfnb9zDgft2XwMHjOinZ8IacbZI
	 IZWk2xRdp2E3L0ALrBzSktqaTTWrz5zZ46Vl9kdPb15LP/B84D7SK1KAqU+65N9dyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362044;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3oAdiQL1BBq/8Wx7+7+nnqKAavDIGqolwKSp3zNe53I=;
	b=Wr1K77Fnccpm4aXYM0HukQtGi8fVoNZYeQoHn8wyINxHPARxtOzg5OvJ7SN7doErPIom
	 U134TFsGNnhMHE2o9ICaKNYVF6S64D9oUtcILaQBd18Z6Abp4/jiw1wUqxXQ1ImHm9wHb
	 UkcsZ8HNvxisryZwWk0607jHQ+hca6LewpbijQ8jYtyrQKh+sjeb6cJAUG/DYJ+Hot0Ll
	 qIqzfbbp5EC/TENf7yu199Jlq2qgEWk0Q/C5S4b7MF2/RNVcvBBCVIymYYDH5SYBrC5ur
	 8D6FL6P91QjOifcVelx3prSL7j9GsqJY6BzE3K1icVPdrrMKf/4tN52h2mzzwqWw9JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=GGswo4Q7;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEA606A31E;
	Fri, 30 Oct 2026 12:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0EEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=GGswo4Q7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=3oAdiQL1BBq/8Wx7+7+nnqKAavDIGqolwKSp3zNe53I=; t=1793362043; x=1794571643; 
	b=GGswo4Q7HNBjO4TfOrDi533WVeLpu59cRClXWYh0gpDWgaqTjoYJnO8+pvf6UcH2rLHZKbThxQq
	viNF6E6i5bqdgDSES5G929idm8vQjuxXFaqnVQhyT2TTBQJf6sBc7dVQ7vRtt408Jn6Nl9JEa3riK
	U5YbTj4tUKJSv2xNTJd5ea/AGHKN53vsxRBdRfGfJW31LtKHmk5ZqQMUdEW8vUN6zuN+48ZSmbwa9
	0We4Q4+JbchU/sTlIA6kNimHCLaIYpLaSZi7+nZNv7bDc8u73tomUSG+FEZPhpc1sU/AYoTR8CX/j
	bQjBbtCZli+pQXsLyE70BKEN36sIlIKxEQEg==;
Date: Fri, 30 Oct 2026 13:07:13 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christopher
 Obbard <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King
 <linux@armlinux.org.uk>, Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/9] ARM: dts: omap: dm816x: Remove hwmod code for
 USB
Message-ID: <20261030130713.3a404d50@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-7-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-7-4544429251e2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 17:06:08 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Remove the hwmod property from the USB controller node and the matching
> code from the hwmod data file as this is now deprecated.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi      |  1 -
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 21 ---------------------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index b839ee29e9eb..55f4b91fa1fc 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -576,7 +576,6 @@ uart3: serial@48024000 {
>  		/* NOTE: USB needs a transceiver driver for phys to work */
>  		usb: target-module@47400000 {
>  			compatible = "ti,sysc-omap4", "ti,sysc";
> -			ti,hwmods = "usb_otg_hs";
>  			reg = <0x47400000 0x4>,
>  			      <0x47400010 0x4>;
>  			reg-names = "rev", "sysc";

As I have also some hwmod -> ti-sysc conversions cooking, I think I have
an idea why you put these two in one file. Doing this in lockstep should
be justified in the commit message.

I guess you have removed this and seem a fat WARN().
Analyzing omap_hwmod.c I found that every module action is guarded by
if (oh->_state != _HWMOD_STATE_INITIALIZED)
So I think it is time to just denoise that WARN(), since the
originial authors probably did not have ti-sysc conversion in mind.
I will prepare a patch for that. But then you can add that snippet to patch 6.

While merging this patches we just have to ensure that the hwmod removal
comes after adding ti,sysc stuff.

Regards,
Andreas

> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> index 9b5c728fb7da..b9735b507d6b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -646,26 +646,6 @@ static struct omap_hwmod_ocp_if dm814x_default_l3_slow__usbss = {
>  	.user		= OCP_USER_MPU,
>  };
>  
> -static struct omap_hwmod dm816x_usbss_hwmod = {
> -	.name		= "usb_otg_hs",
> -	.clkdm_name	= "default_l3_slow_clkdm",
> -	.main_clk	= "sysclk6_ck",
> -	.prcm		= {
> -		.omap4 = {
> -			.clkctrl_offs = DM81XX_CM_DEFAULT_USB_CLKCTRL,
> -			.modulemode = MODULEMODE_SWCTRL,
> -		},
> -	},
> -	.class		= &dm81xx_usbotg_class,
> -};
> -
> -static struct omap_hwmod_ocp_if dm816x_default_l3_slow__usbss = {
> -	.master		= &dm81xx_default_l3_slow_hwmod,
> -	.slave		= &dm816x_usbss_hwmod,
> -	.clk		= "sysclk6_ck",
> -	.user		= OCP_USER_MPU,
> -};
> -
>  static struct omap_hwmod_class_sysconfig dm816x_timer_sysc = {
>  	.rev_offs	= 0x0000,
>  	.sysc_offs	= 0x0010,
> @@ -1250,7 +1230,6 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
>  	&dm816x_l4_hs__emac1,
>  	&dm81xx_l4_hs__sata,
>  	&dm81xx_alwon_l3_slow__gpmc,
> -	&dm816x_default_l3_slow__usbss,
>  	NULL,
>  };
>  
> 

