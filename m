Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC064AD4AB;
	Fri,  4 Sep 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529298; cv=none; b=EyLgwl5GiSvZFo6QkXo3JrnPMRPtildAehiYifafhCaTkL5eB0vYrXKSC1udq2G6aSl4Kj6TFEy5JE9V1TizZimSx6n+CXosB2zEX3dx4knf6W44+X871KFTgjb9cc2XCOx3wDbGwMvM0z1HDi8bGEZwwxCM60Qviu9TeyhQqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529298; c=relaxed/simple;
	bh=D9iL8gkIMoSahIxAXwEZ4rZ5DC/fLiu/XF4LdcYsNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoaPkY+E2PLOI86BFfK2ChmKKr4VOC47jJ5TGqHsv+nHLjTxMUqIkQmpoFJa9IbqmukvBYUcDHbCiQynUx9hAPiN3IO3zcD26WlVXPL8eAZfKylePdy3CvapNJNwVvX5KshmIY4McEolKMNEOIdvqtsap/KWWPQSAgH8ghGkUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=f6ODtQC5; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="f6ODtQC5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=bwrYwvf4EE3LnWiuBDhZo+bPLoXTv8Ui/JdisuZmKag=; t=1788529296; x=1789738896; 
	b=f6ODtQC5aBMfC6veE0amOWpCYLr8dA4J7VlvUPg7Ch2+AgkjxJ6UYIh6PTw+XHrkos2wGa7u9pt
	E6Py4bLhu2kgCVXaF/hn/qetqkoblpcLWKwW7MhUPxWPs4FPl9Bq9C35A1RKrQpNtuneV6jnKhJah
	NeGbYldptBL5Fw52iZZgfEQNPmN+lUgJAt5MfD65N50FYPDItkHxa3EE0aWkQQ9lLjnDGvTJn6DNU
	jhYOdPGaQnA0f/7L3fKEfTDBhA/UUegDNI+yGSqZcf8dpScMUi3X2BjeanAmQSEU0YxQcg8hwLkoz
	PnqaeEHi4uIfuXTBS6HFs9m5xj9dMIFjmPfA==;
Date: Fri, 4 Sep 2026 15:41:14 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
Cc: "Tero Kristo" <kristo@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Tony Lindgren" <tony@atomide.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>, =?UTF-8?B?R3LDqWdvcnk=?= Clement
 <gregory.clement@bootlin.com>, <linux-omap@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <20260904154114.2d771ee1@kemnade.info>
In-Reply-To: <DL6D90JSIJCC.FE91IM9ILYSI@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
	<20260902082639.69643254@kemnade.info>
	<DL4OUCXRGBEA.2G2WHI4FH2AY8@bootlin.com>
	<20260902111556.38645f32@kemnade.info>
	<20260903115308.2a569a30@kemnade.info>
	<DL6D90JSIJCC.FE91IM9ILYSI@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 09:50:17 +0200
"Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com> wrote:

> On Thu Sep 3, 2026 at 11:53 AM CEST, Andreas Kemnade wrote:
> > We have:
> > localhost:/sys/kernel/debug/clk# grep '(' */clk_possible_parents 
> > clkout2_src_ck/clk_possible_parents:(missing) (missing) (missing) (missing)
> > gpt10_fck/clk_possible_parents:(missing) (missing)
> > gpt11_fck/clk_possible_parents:(missing) (missing)
> > gpt2_fck/clk_possible_parents:(missing) (missing)
> > gpt3_fck/clk_possible_parents:(missing) (missing)
> > gpt4_fck/clk_possible_parents:(missing) (missing)
> > gpt5_fck/clk_possible_parents:(missing) (missing)
> > gpt6_fck/clk_possible_parents:(missing) (missing)
> > gpt7_fck/clk_possible_parents:(missing) (missing)
> > gpt8_fck/clk_possible_parents:(missing) (missing)
> > gpt9_fck/clk_possible_parents:(missing) (missing)
> > mcbsp1_fck/clk_possible_parents:(missing) (missing)
> > mcbsp2_fck/clk_possible_parents:(missing) (missing)
> > mcbsp3_fck/clk_possible_parents:(missing) (missing)
> > mcbsp4_fck/clk_possible_parents:(missing) (missing)
> > mcbsp5_fck/clk_possible_parents:(missing) (missing)
> > sgx_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing)
> > usim_fck/clk_possible_parents:(missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing) (missing)
> > localhost:/sys/kernel/debug/clk# 
> >
> > All these clocks are composite clocks.
> >
> > so the early-registration of timer-ti-dm-systimer seems not to be
> > the main issue here. Looking around what might be affected,
> > mux clocks build into composite clocks:
> > :~/linux/arch/arm/boot/dts/ti/omap$ grep -l ti,composite-mux *.dts*
> > omap2420-clocks.dtsi
> > omap2430-clocks.dtsi
> > omap24xx-clocks.dtsi
> > omap36xx-am35xx-omap3430es2plus-clocks.dtsi
> > omap36xx-omap3430es2plus-clocks.dtsi
> > omap3xxx-clocks.dtsi
> > omap44xx-clocks.dtsi
> > omap54xx-clocks.dtsi
> >
> > So havoc all over the place, just worst in omap3 because more critical
> > clocks are affected.
> >
> > So I think we need either a revert of these patches or a some
> > kind of quirk in clk_hw_register_composite_pdata to pass throuch something
> > between the mux component and the composite.
> >
> > Regrads,
> > Andreas  
> 
> Hi Andreas,
> 
> Thanks for taking the time to investigate this issue.
> 
> I believe I won't have much time to dive into it in the coming days, so
> I fear you are right and we will have to revert this patch for now.
> Except if someone else want to have a look at this.
> 
I looked once more: I will try with just the composite patch reverted.
The composite patch looks more independent than I thought initially.

The composite one does not affect anything else than OMAP2/3/4/5, so
your AM3 problem will still get solved.

Regards,
Andreas 
