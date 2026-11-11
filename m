Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382611;
	b=cRbF+9iSBFc+FDwQanvAQL3hXPGybTeMvHO8zhxLKlXPa0DfF7oLgOOIm0Sd+J6o/v1n
	 7L+lUuMz41d5Xnr1eIQ5EAXgpYIUh1giRlNMIWBKd/w5w5OsCSjs2YGlUewgZlHDRn9+v
	 6ACozZ3Ij4VWlKEkwfzeIfPwe3xxgbUB2l1pMS3oGIXVRImE0lwsrHBMhYWtrGBvQSU39
	 KwqRnHTYmhmMkSq4/VfeBf53tDwuHlLg7VS4/pNpXXQFGwy1nr472+t7Xu24JJiJsxQiN
	 GbDyry+YYddRbSXIH+FwPQg8/kBIUHpgMTpbaFYIa2lIa2FJfbS5LoGyFV9PuI4MYGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382611;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kj91ruAXFWtpquSVovP4UbrV+4Yba9A/2t3iM/rZHdc=;
	b=Yo11vI6Nr5WYLxZLI8Alz8dSrIlJBlBXp1CMdh9/S2N4vj2PZMaAR9teDJnT53IlCgmR
	 sqW8q+TFHCvTavEMYC6iKNMTrUBAUmcl/ega027/eqCXmyr3NElMyw3OJ0Q/T5KHd8vmK
	 kCUZ51XdJp7S5BnLcqEuepQmua/24VcO4fW910LJYPedYvsActgn+Zfj7EFJBayPfxzJx
	 kQ4W8JPPAOEts5z8XpOcYyV0Zz3yOINWNkHWh+ELJk9ye48LY99uvevQ+WdAq3RntM2N1
	 pTJxHYeklpQ2dY4f6x92Z9ywbFOsH9GhEV/ZFfziMhprlXsv+pAXSo+3AgBVRr6cA7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=qtMqotWU;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA23606A320;
	Wed, 11 Nov 2026 07:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BA23606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=qtMqotWU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=kj91ruAXFWtpquSVovP4UbrV+4Yba9A/2t3iM/rZHdc=; t=1794382610; x=1795592210; 
	b=qtMqotWUuW1Dq3BGDrJMhlVjpGMcwzwKhKEMMDiIZjAY9k1eyaA6iVybrAENoVJLv3eQUKkQ3kN
	91bOCqU6IjDwbJqlxGuYfnF++6a5l5ZGpuUYcV98DuDUM5UtPGKAOgKFlF87o/XQm+JxUCGeB6cJj
	awx23/JLA5+u8VEd37gD94NFRUKAnONU2AxFIKpiW/NXpDLqb01V+aY2v6vabS/Zb4feF98pPyzOo
	lY8BB56PfuHWBMk6E5r8CK6uxuvZVkwxeIlxjNx/gshRvrUmt26OQS8r0pv1qOgN+jtVlxk7EMj4r
	gDlM2ocnYsnLasqEVsU79rRMGHPF9iHrACmg==;
Date: Wed, 11 Nov 2026 08:35:23 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Kevin Hilman <khilman@baylibre.com>
Cc: aaro.koskinen@iki.fi, rogerq@kernel.org, tony@atomide.com,
 linux@armlinux.org.uk, andi.shyti@kernel.org, thomas.richard@bootlin.com,
 wsa+renesas@sang-engineering.com, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: OMAP2+: fix omap_device with noirq_suspend
Message-ID: <20261111083523.657cb7a6@kemnade.info>
In-Reply-To: <7hwlqktdww.fsf@baylibre.com>
References: <20261110211531.679943-1-andreas@kemnade.info>
	<7hwlqktdww.fsf@baylibre.com>
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

On Tue, 10 Nov 2026 16:22:39 -0800
Kevin Hilman <khilman@baylibre.com> wrote:

> Andreas Kemnade <andreas@kemnade.info> writes:
> 
> > Fixes cases where device runtime gets resumed in _suspend but then
> > pm_runtime_force_suspend is used.  So the device is disabled, but runtime
> > active in _noirq_suspend leading to duplicate runtime_suspend calls. So
> > rather check for the device state directly to indicate if changes are
> > needed.
> > This relies on pm_runtime_force_resume being used in a balanced way.
> >
> > Fixes: 7da7fd7e66ac9 ("i2c: omap: wakeup the controller during suspend() callback")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > This really needs intensive scrutiny but might be a less invasive patch
> > solution better suited for stable and paves the way to get out of the
> > omap_device theatre without too much hurry.  
> 
> This looks & feels correct to me.
> 
> I also tested this (along with my WIP patch for that NEON count
> mismatch) and I have a very stable suspend/resume on OMAP3.
> 
> I tested on omap3-beagle (retention) and omap3-beagle-xm (off-mode) and
> both are now reliable across multiple suspend/resume sequences with
> these two patches.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
Then feel free to ignore the RFC and apply this one.

Regards,
Andreas
