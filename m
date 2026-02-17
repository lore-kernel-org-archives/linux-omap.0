Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3730E825;
	Tue, 17 Feb 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320899; cv=none; b=oUINHNaxSuBP5juU2SWfrAgc8Mhk2+kPmvw7ReWM73M2VQ1v670Htknq0/j5IVtQ49O11AJeDUJmUx19xoGU0iyGMAv+4BwAw1jfqPs2bHmpAFSvyoMzUrOEQMwFAMd7OaYGaSJII08I0ZFQ32p/7foAqn4dDBVJDraanFNZBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320899; c=relaxed/simple;
	bh=saxP91jgziXEZsqTt8BNYT7/drlvl4Pl8lkxRLzTBo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IniwVPug53qVZF1Tclpf4zUeYM1hYuMsJgnSMqCnVw2SPrIv/C91ltkI7nK+iGIQvqJ7EDMUiuhPP69iIKgOqSX8Zml1CPPWaByy5gDxWZJD0dHLBjQi4GwYhCtfue+s5G2pBnheq2RSM/EcUAfYEki6lItItokk/cCqosYLoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=RSQGvJp3; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="RSQGvJp3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VFrPWXYQT32uJfy+Itx8pbUU2F6AZS8gWr+T1oJUeBs=; b=RSQGvJp3nkM/KWKOE1V55N8Lrk
	pwlO9cyFM2UUUiM+OgmuyOXTYUN069Nn9ur8aenxt2oYUrfT6Xx36cTV6NlcBCMuL1z82zvRdQ7lM
	U8ix0yl1gi2hscTG2ZMJpv7qMAHudC6vgQ+mwh8s4jwXidPaR9XyGp2n/wQFTXRooXrbdZjHZU3f/
	f1Ep8TxJoLLF+trVeaFahWpGQk+AZjQ+chkOk7pPPTDIbxa7nCZYYfBNo1Jp9P6EFvqmD9FeeRHTg
	FaAxk25fMIvh48a4O4kYVM6SaC+hWi7f52xq92GU+oGnn16Tf2fe/EWR++vdz0bLhxPAx5P+8DsH8
	xxePVT6Q==;
Date: Tue, 17 Feb 2026 10:34:38 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Robert Nelson
 <robertcnelson@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin
 Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
Message-ID: <20260217103438.4697deab@kemnade.info>
In-Reply-To: <0EE0658D-56A7-480C-BF71-6B2EB81DC41C@goldelico.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
	<20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
	<B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
	<20260212174718.7daccb70@kemnade.info>
	<719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
	<20260212231907.6120a2e2@kemnade.info>
	<CAOCHtYicmeSzH5Q2_qTwAZw3s+__JRwUrXvz01+KCsJJHAznUw@mail.gmail.com>
	<20260216161155.09fae580@kmaincent-XPS-13-7390>
	<0EE0658D-56A7-480C-BF71-6B2EB81DC41C@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 09:58:04 +0100
H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Hi Kory,
> 
> > Am 16.02.2026 um 16:11 schrieb Kory Maincent <kory.maincent@bootlin.com>:
> >   
> >>>>>   
> >>>>>>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI)
> >>>>>>> <kory.maincent@bootlin.com>:
> >>>>>>> 
> >>>>>>> Allow overlays to be applied to any DTB. This adds around ~40% to the
> >>>>>>> total size of the DTB files on average.    
> > 
> > Yes, I will move on to this solution for now to avoid too many complaints about
> > the devicetree size increases.  
> 
> I have done some experimentation with this patch (on top of v6.19 and our private defconfig)
> but could not find any DTB size increase.
> 
> Does it require another patch or CONFIG change?
> 
if it is your letux_defconfig, then it does not require anything else.

I think something already enables symbols in your tree. Look with
fdtdump at the generated dtbs for a __symbols__ node.
If it is there, then it is enabled.

Regards,
Andreas
