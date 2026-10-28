Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216287;
	b=uU401qb03/W176GFziePBQvXGr7Kug4E4K9qWrYuxr6z1d+r73H/fPIN+x2mO4fIU0Hn
	 pqZuhZjj9tNL6RKQ9CxzGEnshbONACmRKT0wMc7NN4+XpXOqi3+g/G4yVDqB5u/bhIxrc
	 58yanaJ8imsHXL3eXoOeRVZonTD6GLPq/9m40B68mXUkYWwhNv4OzmLKyUqiWsBTI5X95
	 9qN8FvTKQnO9IYAILI7SSjMhhAUs9+k0Y2J6TNCHSAPy4yg3lGvUWgME/MnXeGrfnkeO/
	 gymVifTvLLFtVPDNU0I7DKQ5C64V5QJzj1JQm4xbODApeYjNcVzWQ/NjyGfF7qVs/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216287;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RKeXRhrML1PnlJAJrOBPCA9w4pXg5kd97C5IqSm6NYg=;
	b=TJRc8x2jzIU96EBVl145JarbTXvdYRoEZtPyMv+J4+1rkLtrpWrcPoO/0Q4r+H7D1xQk
	 QSN377RBxteFcZfEX5Hv1QKGNf8jMQwceq80nZu4s1zvyanbHRXhHf9MTra2W7vp/Id3t
	 I4vQGAF0J9Ai0erPNMfo1AJvkBWfF3ljE+MCBjt2kha5xFA7fqdfR3mAi7M5urIqLsYr+
	 Nq5+lu/Rt+Fi2wqlcbxWLfXLah89IvDM+7haqLhfETBfOF1R0LZP8plJDumPmxa0GRFGm
	 s0X4fyS33YBWa0/yiDwd5xYyIigIOrp5ul5DATm/1mveWLoVX/bSk6c8kBIxNLHAlkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b="66c8/zyk";
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49A606A31A;
	Wed, 28 Oct 2026 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE49A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=66c8/zyk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=RKeXRhrML1PnlJAJrOBPCA9w4pXg5kd97C5IqSm6NYg=; t=1793216286; x=1794425886; 
	b=66c8/zyk6azHbjLu6FI3RSwpkoDmYn9xOyV0rDY/A0SgN7pZMiAvGYM+/5/5eHYLXhpVt7m9Mx9
	Fe0TkDjNuAM4p28o3NMK8axRUSrOglkt6jBcuaUdhk37YHG7A0MB+6ZpombwdQdJjCA7l/thSlUp4
	Ffu9t7wx4WSU1lD83BIXt3SKgg6/BiOjXMDQ0PGKsZ2nbfVeMe+HQoGJMsm9DbhaewkCtCRSFVJf9
	mZeXu6iAbHCRuTEQJFIY7uLowzzuLBSfJrGWWD24tyMtasKOmbwd3C9sW5zZti54jKX3qiwLOy6T2
	kH3tYf7qOypCXI7+6W/pCjdMvHPLDZtU18eg==;
Date: Wed, 28 Oct 2026 20:37:51 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Andrew Davis <afd@ti.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Adam
 Ford <aford173@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, =?UTF-8?B?QmVub8OudA==?= Cousson
 <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 03/11] ARM: dts: omap3: Add device tree entry for SGX
 GPU
Message-ID: <20261028203751.73100e37@kemnade.info>
In-Reply-To: <20240109171950.31010-4-afd@ti.com>
References: <20240109171950.31010-1-afd@ti.com>
	<20240109171950.31010-4-afd@ti.com>
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

On Tue, 9 Jan 2024 11:19:42 -0600
Andrew Davis <afd@ti.com> wrote:

[...]
> diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> index e6d8070c1bf88..c3d79ecd56e39 100644
> --- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> @@ -211,10 +211,11 @@ sgx_module: target-module@50000000 {
>  			#size-cells = <1>;
>  			ranges = <0 0x50000000 0x2000000>;
>  
For quite some time. I see
sgx_pwrdm (INA),OFF:0,RET:0,INA:1,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
in /sys/kernel/debug/pm_debug/count

with a status = "disabled" here (so practically reverting the patch it is:

sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0

All without pvrsgx driver installed. 

What is going on here? OFF is more power-saving than INA I think?!
> -			/*
> -			 * Closed source PowerVR driver, no child device
> -			 * binding or driver in mainline
> -			 */
> +			gpu@0 {
> +				compatible = "ti,omap3630-gpu", "img,powervr-sgx530";
> +				reg = <0x0 0x2000000>; /* 32MB */
> +				interrupts = <21>;
> +			};
>  		};
>  	};
>  

Regards,
Andreas
