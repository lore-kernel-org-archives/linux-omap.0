Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6D2D5408;
	Wed,  1 Jul 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924345; cv=none; b=m2d3qnfO2LUtLRjXvLLy/iWS0PqrX+s9ZWK/KoKtIszonXfim9MYgT16r8RADj2bv0DwUQR61tdyCqdjGOEnm2Cd99zyol9S0yxJS2HVdBv5wKMWYBvJTSteJuEEN6OCzkRYkDNGoEm3X4lOtCoJKk5W6W1CPSiMcSM2HsudWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924345; c=relaxed/simple;
	bh=g2FAJ3MZ6WTq5XPr06Cie+9t3S1YgTQ5fz7dZk70lsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfaT2hP7nHP1Is+ZqJ1RSCAdXzIBCqOBSlfMC4C0ZB34glsLW142m3loP9nUChPwNerAx4QDwVP0SHYAtLH5dKfeH/rPQtxcuhSWttyRQFgJc+B40xzHzBwRM6HD5S4bbVa/SlHg5ee2CZ4yQnbqdb2ddH9wn8YBuQlqCd1CfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=EdIJJCW/; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="EdIJJCW/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=WdspS75NOxfLhQ84f5cjMDOmswQRpBYDCdh0Opc/BZM=; t=1782924343; x=1784133943; 
	b=EdIJJCW/F+OTzYaOMifTBEXP6uNs98fqNo3deOQy72kUCdb+OuLQRDhAJXkHsvO6CXYDTeBJT+k
	dPsfC4aegqf1xElcKKRvKYEFPGYSRIeMkSW/BVxTa8/EA+76JTPE+Hsy8OeQcKrmhaJWLuFjMn1nW
	koarrDAcxd6n9WnYWNC38aHSwm8sKrzeYEzBhCcUe0a8XOT0J0SntQOsFazAcWQkDDjlJk/PNCQju
	1H7XKOtHpYlp+h4sYN594r1YR/wdLfbSVbjL+ptnjnJFzY29Cf2enPlRqFxp69bg5jDTe986qlafu
	W7nd6oRAtCljGjkYyYW+Cfbm4lLgE4e5dn5A==;
Date: Wed, 1 Jul 2026 18:45:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: omap4: Initialize DPLL_USB_M2 during the boot
Message-ID: <20260701184525.6d80ad79@kemnade.info>
In-Reply-To: <20260701-clk-ti-omap4-dpll-usb-m2-v1-1-02d8a3845a55@bootlin.com>
References: <20260701-clk-ti-omap4-dpll-usb-m2-v1-1-02d8a3845a55@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 Jul 2026 17:06:28 +0200
Thomas Richard <thomas.richard@bootlin.com> wrote:

> Initialize and lock DPLL_USB_M2 at boot to make USB devices work.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Recently a series [1] adding back OMAP4 support in U-Boot has been merged
> in next branch. While testing it, I noticed USB is not working on
> omap4_var_som.
> 
> usb 1-1: new full-speed USB device number 8 using ohci-platform
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: new full-speed USB device number 9 using ohci-platform
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device descriptor read/64, error -62
> usb usb1-port1: attempt power cycle
> 
> The USB_M2 DPLL was previously initialized by U-Boot, but [1] lacks USB
> support for OMAP4. This patch initializes the DPLL in the kernel to avoid
> relying on the bootloader.
> 
> If you want to test, as U-Boot does not handle pbias regulators, you also
> have to apply the patch series "[PATCH v2 00/11] Add SIM pbias regulator
> support for USB on OMAP4" [2].
> 
> [1] https://lore.kernel.org/all/20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com/
> [2] https://lore.kernel.org/all/20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com/
> ---
>  drivers/clk/ti/clk-44xx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
> index 9b2824ed785b..3944c50b7cd0 100644
> --- a/drivers/clk/ti/clk-44xx.c
> +++ b/drivers/clk/ti/clk-44xx.c
> @@ -811,6 +811,11 @@ int __init omap4xxx_dt_clk_init(void)
>  	if (rc)
>  		pr_err("%s: failed to configure USB DPLL!\n", __func__);
>  
> +	usb_dpll = clk_get_sys(NULL, "dpll_usb_m2_ck");
> +	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ / 2);
> +	if (rc)
> +		pr_err("%s: failed to configure DPLL_USB_M2!\n", __func__);
> +
>  	/*
>  	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>  	 * state when turning the ABE clock domain. Workaround this by
> 
we have assigned-rates in omap44xx-clocks.dtsi
for similar divider clocks. I have a patch needed because of recent u-boots
not having some abe stuff initalized to have mcbsp working in master mode
on omap4. I think should have some consistency here and agree on it.

So I would say if it is all about setting recommended defaults, probably
a better way is to have it in clk-44xx.c (as you have). Reparenting might
be a different story. There might be reasons to have it reconfigured.

Regards,
Andreas
