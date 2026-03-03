Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40308381B11;
	Tue,  3 Mar 2026 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572004; cv=none; b=XrwCL35O4xVG1/wTnC3BiBt1JkVc5UlBMGeQMDI/P7aeMH3jKHZ3JTH6gOe1f9DQLNT+drCXpPztIz2B/Dru7N46zUd0aR+ucTATeXXsbejNszaUJFHy0gN3CUEWFH6EuT0Kdwynfnx6Yv9uba5Z3nsfh/nr45QaDfcTJEci3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572004; c=relaxed/simple;
	bh=kYnWUgRL3sTYg4/l/wC6tnaEcVUKqac2pESHIb9CdGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXxAWh/qFeeMivm5eb7S/WM5vYAEHi5UIq3QkBV52cQ6uuCGNsg+3V2QNF2gUFUsijEraDe2w1/e1UDEOiijAhI6kCav9N7GyRDSprujhDx3iP1QVkdoufgKEei8uPWCqhDELcnxwb/fVxfLT4/HGXtLqPOT7oRaNDiF2gdQFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=q1IDxgym; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="q1IDxgym"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LDFG9DPYIpvq9oiYO0M+siA6D36LqBTmO1v0hsaPuVU=; b=q1IDxgym3dWjzVWJCUhTXFjh9u
	NU038r4jUjfinDodFMdzy2Svc72Lx2hlT6p6Wue+OLdItaPEHbyoz1VLZaeQap+JEUdVg9FYcgA3v
	sdVSTRu0llV2G/bl/70Io19bfZ5My0o3PWBsL/Te7PiqMyvwVvWhpxpECGcw+xXzUwGvTDfFbqBSK
	JPS55TXvKRsoPlm+W4MYcELMx/DBo9jE57kPAHe/qtUry/uChcpsImbWFeer1QZjAjO6+VnPBSURu
	A6CAHfKvW1anJETwgIRxqRZPfuds5N2LFIH4qzI677Sla2zLZM97A37it6grFtrLiPFktYA1c02YP
	vjg3EFCg==;
Date: Tue, 3 Mar 2026 22:06:33 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: aaro.koskinen@iki.fi, airlied@gmail.com, conor+dt@kernel.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, khilman@baylibre.com,
 krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jesszhan0024@gmail.com, rfoss@kernel.org, robh@kernel.org,
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com,
 tony@atomide.com, tzimmermann@suse.de, andrzej.hajda@intel.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v9 5/8] ARM: dts: ti: omap: espresso-common: Add common
 device tree for Samsung Galaxy Tab 2 series
Message-ID: <20260303220633.72619664@kemnade.info>
In-Reply-To: <20260303203017.511-6-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
	<20260303203017.511-6-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:30:14 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Create common device tree for Samsung Espresso series devices
> 
> Create a shared device tree for all variants first.
> Device-specific trees will be added later based on screen size.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

