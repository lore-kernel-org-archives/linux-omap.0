Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3B3EBF3D;
	Thu, 12 Feb 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934762; cv=none; b=rohBvH1avSyyILRtb12mNBpTJMFv/64Q/r61oxE9hyb8vtDpjALkV6j+qxHWFhkbAp9WGyVNWyXXX3SxLoOVeE1Ss1Id3nU1/2FjDdO56Lpm5iXENglde2/cXKgIIL1oeuPT2ORDfEWG2civX1HbXmJzYB/Soldlm96SCIHchAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934762; c=relaxed/simple;
	bh=Btev3tidk4fWW2gklUalUiURfnfOP6aldQ+A9eS/HNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSVmzA0PFD/L0/SMEPAFRowaI06z92i5a9+aQFg0CJcYgIvt9yu8SXjy9UlmHTsQ65R31iTpTUNGpn2w5YmSbZ9kpEoyQKpBsQk3UMBg+SGzVaPzIEPsRaqQTjkvKH410Tzr3aGQkymTyICbLGQRY8/gewiUfUihF/7lwmkz5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=fTrjlnTJ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="fTrjlnTJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zn6U+s6nKrFVxchAXEA+zzkVNw+Uwh9myW4j41Chco0=; b=fTrjlnTJbHR9mHHDsRFLB1u5MS
	cHDu4x/pQ+9UvqI4onwLN2MEDiON8bVlXS6XkeGD2THz78GAj4g+vKPCdoI32aoadakAuuTnFhke5
	CuSVIXeC+YMGyIjoz2HC1ecnUGbDbLidWr1hWIRCkal4Ij+WhBSqNzchuNgl4mOtjFMCrV2epS34v
	6BavwZGcv0uIZOhF9byHr4hv9kGD6OsRjs4+yYmmsUmI+tEzvsHnZjyZBy8Htr/3W8ST8vF6S4loG
	md/G94cs5SHN0bhZGBfv0TbpglBVy8Sd6/i+gKxf9hMRcXs2iVCWGdDK/BvcDEIvaZBX+5NPnZZ32
	BFZNo3kQ==;
Date: Thu, 12 Feb 2026 23:19:07 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: "Kory Maincent (TI)" <kory.maincent@bootlin.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Louis
 Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
Message-ID: <20260212231907.6120a2e2@kemnade.info>
In-Reply-To: <719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
	<20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
	<B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
	<20260212174718.7daccb70@kemnade.info>
	<719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 17:55:43 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 12.02.2026 um 17:47 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > On Thu, 12 Feb 2026 16:49:43 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >   
> >>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI) <kory.maincent@bootlin.com>:
> >>> 
> >>> Allow overlays to be applied to any DTB. This adds around ~40% to the
> >>> total size of the DTB files on average.    
> >> 
> >> Is this unconditionally enabled or can it be turned off by some CONFIG? We have
> >> our own defconfig so I would not worry if if is enabled in omap2plus_defconfig
> >> and disabled in ours.
> >> 
> >> We have several devices where the boot loader can't handle overlays (never touch
> >> a working boot-loader :) So this seems to only contribute to build and load time
> >> without benefit.
> >>   
> > As long as you do not add overlays, the bootloader does not care. I would
> > like to simply carry around the 1-bit mmc overlay for one broken board.
> > That would help me. So I think there is a benefit but nobody forces
> > you to use it.  
> 
> Well, it does not force to use the really good feature, but it forces to add
> ~40% more file size and some more compile time, if I understand it correctly.
> 
Compile time, hardly measurable even if you just do make dtbs.

Size on disk:
a) if it lives around in a /boot partitions with kernels and initrams in it,
   then we are around 1% more space needed.

b) if it has separate partitions maybe on some mtd: Looking around: GTA04
   has quite some headroom left. Usage is still <50% even with symbols
   enabled.

But on the other no one else seems to enable that besides for devices with
open expansion boards carrying "hats". So overall, should we really be the
exception? 

Regards,
Andreas
