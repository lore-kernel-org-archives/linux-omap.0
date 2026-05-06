Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBD31716F;
	Wed,  6 May 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070070; cv=none; b=bfwY2eQUbb2YsxgWJIdMgdDGjOF3aZ0eYhK/o7PVhvo+Mg3qxZXd90onykmW9jhr/VtylixsMVhXetlfOnzFpN3VeSvshFxwJvwm9Lwvqdg74lWbA1kXqawXK1GphracQz/mLCXms0Bp5RFru6HtK2/za6pRtyDtv5pW10LhfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070070; c=relaxed/simple;
	bh=MEcilob3lIa0Djuvxe+8G/SiF3Ck8f9Fw74juQCNS4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2ds2loLmGh4aD8hk2GP0t5u0kY1/vDPkyqojj7ucPPHfeEaLJs8bk7T8ixEOC/p9F/gdTEI715B/7QhwyFnNzKWHdF35H0lIqBUYux7Rn2jdd2d0AzxGsqoh8XrHne1u5KsYF3muRtgB0zE+y4LRWSjOXjnrq4FIrIRcYXydAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=DBA9+0qw; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DBA9+0qw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/4qEkQwBeZBXmPpSGuA2DsdKBoBKWN8Kcgu73ejEo9o=; b=DBA9+0qwOxXnnHKSp6m1ufmG9f
	jSLEwl4qIf/wO9UPBs0kfkPAQT7aST7lkuMm+zcH3o7z16qh9qGniBd2PclrsbXNND5PbBq1Ma+VG
	P8ePmEj7ZxSqCV7YIbvy9YELBnEPSqw20XhoLAKz2J6hHBcLN5rgczJ4v0xeXIii+iumTpwJ2BDus
	2kTncE0pufzoBqvWcJB71feVe82q31aNGjyNoNhJtPHooklX28+mcwrL2uYZeUPDhHwiPc5QWB826
	MC5QLwo3a1jwzulpO7zVPl2qJx7SxE7EnZwqNiEM0uAhNbMFUIO1z2AhV0dQkLIH7vyHfjxKi1kG1
	0HK1gThA==;
Date: Wed, 6 May 2026 14:20:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, akemnade@kernel.org, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
Message-ID: <20260506142044.6456b2d5@kemnade.info>
In-Reply-To: <7ha4yfzv2t.fsf@baylibre.com>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
	<20260111123200.6871a41b@jic23-huawei>
	<20260112094259.4648cfaa@kemnade.info>
	<7ha4yfzv2t.fsf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 14:30:02 -0800
Kevin Hilman <khilman@baylibre.com> wrote:

> Andreas Kemnade <andreas@kemnade.info> writes:
> 
> > On Sun, 11 Jan 2026 12:32:00 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> >> On Wed, 31 Dec 2025 22:14:17 +0100
> >> akemnade@kernel.org wrote:
> >>   
> >> > From: Andreas Kemnade <andreas@kemnade.info>
> >> > 
> >> > Define interrupts properly. Unfortunately, this hides a bug in the linux
> >> > driver, so it needs to be used with the driver fixed only.
> >> > 
> >> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>    
> >> 
> >> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> Not related to patch 1 so if TI soc folk can pick this up that would be
> >> great.
> >>   
> > well, it needs things fixed via patch 1 to avoid creating havoc...
> > But from a strictly dogmatic point of view the devicetree describes the
> > hardware, so it is unrelated.
> > ... but from a more pragmatic point of view, I do not want to have interrupts
> > enabled for drivers which do not handle them correctly.
> >
> > Of course this should be picked up by omap folks.  
> 
> Based on the changelog comments, I will pick up the DT patch when the
> driver fix gets applied.
> 
the needed patch is in. So it can be applied.

Regards,
Andreas
