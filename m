Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472438BF81;
	Wed,  3 Jun 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495273; cv=none; b=QIcxT80MDT2ww2hj8TGMIf1/pELhnaJJ9AdAizGFwAdx04JUuGLGZYJKahtbapdm/iUF+eJCao2hqi22XGiQkfz1mnmWuO8e/JZg91+Lc3kHDeD91FrV0djac2Usrh7bAZVYAYOEACk1ROaTWD20n2gxDP+c+8PHW13AutASxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495273; c=relaxed/simple;
	bh=uuUqhKWEKZxwZNiUuEsG4zpxnkjceIdkOKCVud5SynU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3nFo5bApBdt5Oc34g5xq4nVNFZxbul1kRicQ8so99dOfWMi8TQtUbarwBbwJPtt4Ts6mMWtoL3A6dxbKQmg4+vXfRE04vSmsMqIXEQ+olLLpHq76xuum4zoZmbk9ggwiaKhCzewGRyMBxbTO3Mt+iUo7jcLqQHpVPTPL9I9H5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=PESTnN/E; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PESTnN/E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=prfXAt9tKfPdDbq7Qad1x/j/7Y7QtTKcS9qzpdfUzxs=; b=PESTnN/E7GxHedSIBBjkPS7S74
	hfYbiyebs+2yHMxD9KRayLv+CKnzknrUHt0R6C3npb1E1xhPCnEY5sAS8l7AFHGyY15agM3xwesv1
	JQxJ4Fcp8ticjgDLSq+bdQuZ9ZAENiSH4mtnDNX/5cGkDqe2IShIKDQZL56AmcSJMCqfP1Qo2zd34
	N/TVkxOxafIq2XVFP1CJVvuLbzfIiaSjf8GNLWHuEJ09mKfcXiLDt6M4N895RaKF9YAL31jlttvMC
	5iSD9IbtPV2k+QN+IPazXkkZt213PpeRYipqFWrIhmTpE3LA607mMsiptKpqF2wSiO2pgJPMnfXkZ
	fVjGl1lQ==;
Date: Wed, 3 Jun 2026 16:00:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Sascha Hauer <s.hauer@pengutronix.de>, hns@goldelico.com,
 grond66@riseup.net
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sen Wang
 <sen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: ti: omap3pandora: remove
Message-ID: <20260603160021.11cfae7c@kemnade.info>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
	<20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jun 2026 14:09:23 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The omap3pandora driver entirely depends on machine_is_omap3_pandora().
> Pandora has been converted to device tree:
> 
> 7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for Pandora")
> 
> Since then machine_is_omap3_pandora() always expands to 0. Remove the
> long unused driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/ti/Kconfig        |   9 --
>  sound/soc/ti/Makefile       |   2 -
>  sound/soc/ti/omap3pandora.c | 290 --------------------------------------------
>  3 files changed, 301 deletions(-)
> 
On the first glance, this looks ok... but
I know there was work undergone in converting this to devicetree but it
appeared not upstream.

So
Grond, hns: What are your plans in this? You are effectively maintaining this
out-of-mainline. What are your upstreaming plans?

Do we need this kind of glue anyway? Or can we use some of the
audio-graph-card stuff instead to wire up things?

Regards,
Andreas
