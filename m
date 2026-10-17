Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98135AC0C;
	Sat, 17 Oct 2026 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792220031; cv=none; b=i4co81dsxaWS9oMcX8cKoyYNL1Sqn8fomrtew50tpnlsCP0FH0fYgd00xasc1VJHHzNp3SzIc7aEHebnH6r9mhiihtI3P7BDXIKIH1OIZMt437Dgvol/wiwEJm6eTjEqqNXW8ZUWTTuWd8iJ1hC9JU7Y+TPA5/8QtmLKAA+T1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792220031; c=relaxed/simple;
	bh=JGGrFt/l1uiDVDMnrh6pnkl1FqwJyD5TxJUFya6+muA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbbRE7BlgyjLAZ1Wh+dEk4ux7UyVsvB8V5P4shSUAzrf9b393cFdXMdj8IKs4kXHf7gGNR31MOWckTzGUl08H7M4ooZUHnHGKro2ofhhj4gE3mBTpbVRlkL3Kwbd2ggxTu8z3hr3RliLDTEMHXmRCVt0OwRF1dMPD/xJf2ye5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ttDv/Pcd; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ttDv/Pcd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=ktvi53IU3mbKmGya4FnS/Pieemw2knzJym2TO/2fBOM=; t=1792220030; x=1793429630; 
	b=ttDv/PcdQQI3mJPmiXcUl1torAh/HWzCNMMCothLhHOpKv/Z0Z4JqbyeEN2erRdVDLjlb+yr+OR
	7NIPInVGQgKMDnPkAG7Y+5M1KssZtlY701Mq4gNEt5Cwq06hWywlmJDjkhPSA9yyowWKqfBBL8aaN
	JEU8eLE18C4s4iG2BJAYwHW3mDIXpWn8cItaMFU6QslnzLxAyl3AiY2tzauci7bkGBiyhh9glFv5Y
	651kA4sd6n7YXT0H0CAAHpygQEPB/XDqJ1iYY+yFcvjX14iKn2lMXEGzpgvI0pXV3i1T9+1iNSF0O
	gb3o4aJArN8aXct5aHl8+xDEgP0RDkUR11lw==;
Date: Sat, 17 Oct 2026 08:53:39 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Christopher Obbard
 <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Linus Walleij <linusw@kernel.org>, Rouven
 Czerwinski <rouven.czerwinski@linaro.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: ti81xx: Prevent USB being put into idle
Message-ID: <20261017085339.3533e9ab@kemnade.info>
In-Reply-To: <20261016-patch-ektor5-dm8168-dts-v1-1-b4ce30217028@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
	<20261016-patch-ektor5-dm8168-dts-v1-1-b4ce30217028@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 16:41:16 +0200
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> There is an issue with USB being put into idle with DMA enabled and that
> is mostly prevented with usbcore.autosuspend=-1 on the kernel command
> line. Stop the ti,hwmod code from putting it into idle by setting the
> appropriate flag. This stops the log entry 'clk:0058:0: failed to
> disable' being generated.
> 
So the module cannot be put into idle in certain conditions. Why do you
disable idle under all circumstances and not e.g. adding some
runtime_resume/suspend pair somewhere?

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> index 9b5c728fb7da..2f55dc32e150 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -650,6 +650,7 @@ static struct omap_hwmod dm816x_usbss_hwmod = {
>  	.name		= "usb_otg_hs",
>  	.clkdm_name	= "default_l3_slow_clkdm",
>  	.main_clk	= "sysclk6_ck",
> +	.flags		= HWMOD_NO_IDLE,

and why do we need this here and not in the ti-sysc node?

Regards,
Andreas
