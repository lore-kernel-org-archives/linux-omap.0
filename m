Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324C1B652E;
	Fri,  4 Sep 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508230; cv=none; b=U6xjvNuJ564/0ioeBdw9Lnqm2AaXQOvMd01h9cv6qFfzj/wabymRSdxE+dik5W4MCg9KB90gvgDAdAMQ4EjJi+vT0VvW95vVl0MUXQnqyscRjj17xp8jsJRvgy35loaEjRBjBGgllHRuC16xBag6xMSJUF+Zp+WJU0CKoz1OoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508230; c=relaxed/simple;
	bh=DFJqynbfJcyY/fT0IlcnvoTXr3kzJwBLLpR+NqyctEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=TotgMKlGMkLYm+lQmvk1k5SrD88+kWGeDGIehOSbDGHKya3AxqR/cbO9xjY7wdrX0yxzMEwhq/yPxxn4lLPq89FvsWS4tpVeQ/qoMlzsQq8cG5DxtlPMGPQx+XELcLFeF0CRWu32bHiExnelhDLy5+X8pfy52WNANPJRkL3P5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e/U9fjWE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e/U9fjWE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 849D31A199B;
	Fri,  4 Sep 2026 07:50:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 579196057F;
	Fri,  4 Sep 2026 07:50:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64C7811C7A30E;
	Fri,  4 Sep 2026 09:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788508221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DFJqynbfJcyY/fT0IlcnvoTXr3kzJwBLLpR+NqyctEM=;
	b=e/U9fjWEXF+m6hVFLQ53wEQs6l+kDrU+3Z9815kN2RMOJtWME0bjtdKiMvnlMqjPUMWa5/
	IeuU0eKb/zWFgbqU4Xr/HkhHI2AKUhTBy1Mx2fu7K+/0XxnbhuQHnOMssBUUvjzlbJo9Ib
	MJxzJSYjK+OEzLYNEQ8EkRziUKMuGJFF6DUBSAfrbNDFsyQ+XwKZiUA7URE8H5b7/q1vDm
	sYJARvCyPNNqfLiqoCms87ZCF0Jd9+7WAae5Eqobgyym8aSon6IGBcLaU8OBCE8VYzwkOP
	/7Walyrll6l+NM8ogte5ZS+pG9VYiW0OlwAxp5I2YTKUoi3xQAcXOMmHkawmzg==
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 09:50:17 +0200
Message-Id: <DL6D90JSIJCC.FE91IM9ILYSI@bootlin.com>
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Tony Lindgren" <tony@atomide.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hns@goldelico.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andreas Kemnade" <andreas@kemnade.info>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260902082639.69643254@kemnade.info>
 <DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
 <20260902111556.38645f32@kemnade.info>
 <20260903115308.2a569a30@kemnade.info>
In-Reply-To: <20260903115308.2a569a30@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Sep 3, 2026 at 11:53 AM CEST, Andreas Kemnade wrote:
> We have:
> localhost:/sys/kernel/debug/clk# grep '(' */clk_possible_parents=20
> clkout2_src_ck/clk_possible_parents:(missing) (missing) (missing) (missin=
g)
> gpt10_fck/clk_possible_parents:(missing) (missing)
> gpt11_fck/clk_possible_parents:(missing) (missing)
> gpt2_fck/clk_possible_parents:(missing) (missing)
> gpt3_fck/clk_possible_parents:(missing) (missing)
> gpt4_fck/clk_possible_parents:(missing) (missing)
> gpt5_fck/clk_possible_parents:(missing) (missing)
> gpt6_fck/clk_possible_parents:(missing) (missing)
> gpt7_fck/clk_possible_parents:(missing) (missing)
> gpt8_fck/clk_possible_parents:(missing) (missing)
> gpt9_fck/clk_possible_parents:(missing) (missing)
> mcbsp1_fck/clk_possible_parents:(missing) (missing)
> mcbsp2_fck/clk_possible_parents:(missing) (missing)
> mcbsp3_fck/clk_possible_parents:(missing) (missing)
> mcbsp4_fck/clk_possible_parents:(missing) (missing)
> mcbsp5_fck/clk_possible_parents:(missing) (missing)
> sgx_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (mis=
sing) (missing) (missing) (missing)
> usim_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (mi=
ssing) (missing) (missing) (missing) (missing) (missing)
> localhost:/sys/kernel/debug/clk#=20
>
> All these clocks are composite clocks.
>
> so the early-registration of timer-ti-dm-systimer seems not to be
> the main issue here. Looking around what might be affected,
> mux clocks build into composite clocks:
> :~/linux/arch/arm/boot/dts/ti/omap$ grep -l ti,composite-mux *.dts*
> omap2420-clocks.dtsi
> omap2430-clocks.dtsi
> omap24xx-clocks.dtsi
> omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> omap36xx-omap3430es2plus-clocks.dtsi
> omap3xxx-clocks.dtsi
> omap44xx-clocks.dtsi
> omap54xx-clocks.dtsi
>
> So havoc all over the place, just worst in omap3 because more critical
> clocks are affected.
>
> So I think we need either a revert of these patches or a some
> kind of quirk in clk_hw_register_composite_pdata to pass throuch somethin=
g
> between the mux component and the composite.
>
> Regrads,
> Andreas

Hi Andreas,

Thanks for taking the time to investigate this issue.

I believe I won't have much time to dive into it in the coming days, so
I fear you are right and we will have to revert this patch for now.
Except if someone else want to have a look at this.

I will try to get some OMAP3 board and come back to it a bit later.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

