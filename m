Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C6357D01;
	Wed,  3 Jun 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508009; cv=none; b=Dqa0wScD7rsMOer/NkZyNAkbhtsr0rLdVBBN4VIZxd0i4QMh1ccIvMjem/jc7MaGn5AgkbcTLWF9BI6o0gCzJWZCgyQ81QmuF6qvBJmLZb18yBvdDdo3x1e2URd/ySsFR3wbhsxvhFIPDusRJ0pK2y54tbLBr3nSaXRMV6cry7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508009; c=relaxed/simple;
	bh=2vHLmC15uLhj4+IbNe7PXuBzP5nGwlBd3gJSl6kpJm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJuT7VitB8SIGpYG3X3n/0fVK5xE6LqHVG4ePwKnuDjRs8wkZ3DkOaLosioM1ugDbXIIL5UqPrj/MV1LOBg7jEXW+iW/6crKG7+mA7LWEvk87JSUGj7xVbGaseBTMZ25E0mcoTRs/csExNVv71vvwBJBLosbfcigC8GAeZ4G4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Rv5cW2y6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Rv5cW2y6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o+qAvDxFAlAJGYhXW+dW8a0HJL0fgLiodu+41TvurYI=; b=Rv5cW2y6qXAyvF6+26uT/+lbSr
	cKDSsQD5W8KRul4C2olnHj1FXdPbkhA8wUhXC1XJDbQBrYE4Q5FpPQvp8BKZEawu/1Igh7txLWziR
	DtJ4rRzfc+1tCF/MUlY77tDaQCSoa9orQ2pMv+J0NGOJhZLVZSd9EH+ecABpMH9We6tgqK4irWe/0
	xAxCXd4L2NFM112xQPvewyLnoqHGgCe4qgxvdl6qYyfg5Nmy3o4njxDlHKQWjGxSVmKV8wMfpGgTY
	StVeuytSVRXmcufLYJ25y8BZqpRgD2DaWHDJTu3oJVLDdSymOCPeXVWf0pDvbdXhMQZQT6gvkXTr2
	dJm4yhlQ==;
Date: Wed, 3 Jun 2026 19:33:07 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, grond66@riseup.net, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sen Wang <sen@ti.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Discussions about
 the Letux Kernel <letux-kernel@openphoenux.org>, Stefan Leichter
 <sle85276@gmx.de>, s.kerkmann@pengutronix.de
Subject: Re: [PATCH 2/4] ASoC: ti: omap3pandora: remove
Message-ID: <20260603193307.0a27264d@kemnade.info>
In-Reply-To: <52C0E6AF-7162-4FF8-ADE7-E5BF42551237@goldelico.com>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
	<20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
	<20260603160021.11cfae7c@kemnade.info>
	<52C0E6AF-7162-4FF8-ADE7-E5BF42551237@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 18:26:52 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 03.06.2026 um 16:00 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > On Wed, 03 Jun 2026 14:09:23 +0200
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >   
> >> The omap3pandora driver entirely depends on machine_is_omap3_pandora().
> >> Pandora has been converted to device tree:
> >> 
> >> 7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for Pandora")  
> 
> 11 years ago :)
> 
> >> 
> >> Since then machine_is_omap3_pandora() always expands to 0. Remove the
> >> long unused driver.
> >> 
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> ---
> >> sound/soc/ti/Kconfig        |   9 --
> >> sound/soc/ti/Makefile       |   2 -
> >> sound/soc/ti/omap3pandora.c | 290 --------------------------------------------
> >> 3 files changed, 301 deletions(-)
> >>   
> > On the first glance, this looks ok... but
> > I know there was work undergone in converting this to devicetree but it
> > appeared not upstream.  
> 
> Thanks for spotting (before we would have been surprised).
> 
> > 
> > So
> > Grond, hns: What are your plans in this? You are effectively maintaining this
> > out-of-mainline. What are your upstreaming plans?
> > 
> > Do we need this kind of glue anyway? Or can we use some of the
> > audio-graph-card stuff instead to wire up things?  
> 
> Tony also had mentioned something like this in [1].
> 
> I have checked the status of the LetuxOS kernel [2]:
> 
> There are patches for the device tree (a simple one without audio graphs) and patches
> for sound/soc/ti/omap3pandora.c and adding a TI PCM1773 driver.

Just a quick glance:

audio-graph-card2 seems to accept amplifiers. 
So probably it boils down to just remove this and
add a compatible to ti,pcm1754.yaml and a devicetree patch to use
audio-grapch-card2.

and maybe the regen stuff.

Regards,
Andreas
