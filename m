Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795334194;
	b=YBZaXXTneMHkU9xx8tyTWpNZw+sHgEep8UXERsde6dDAnIjlx/3fjEYErgHjCijL5wUW
	 Ft39gNPOqiwEs7/tL7pG+kQOUpiwT2p0b3MFuwv3KCuzpVMfLAWB5DdTC/TLOQzknPtVa
	 VvM8CfrURXm//QeMtdYiw8YZBxuAg6NWjNS7h3z1IWC72DH5QwUyFR2EsjC9ZX2e63RSx
	 tij/kqCvdkVEpTirxugtZQ7K24ldCcCTokAycVAbe1L9Ka1Z1rzIDEPkVnu4DMcjtJt2B
	 hkEZqxR4OPUQns+UwAhajeHgbY4urmI/Udx8j1z8sJLNRWs4VA7Z8zkXLD0rE6FzeEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795334194;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qd3Iy0gK6elNVfdZMyUtCcq4GMv3WywAgl2WNQQdHhA=;
	b=3RELYMl9ERuRTWGYocSBiqGmI2s8BsYy6LB9/BnUxAwDKU+EaKY3zgwahJhX2syNp2jj
	 SYwEOaTI0NbBfHAtIWUgcSJOGzinChlownIiYlgaIh7pkgaTN5nHSq/e6MOSah/BcgwGt
	 VxwCHO9HNK78mTE5LRRx7PzE9LOmN1k9ieqJHDxJKZtGNAoai4HXECjtr7igAVV/XTIfx
	 39nJ6t5L3hvnDqjV2LXoDnJq4KBbsUFtOI017wHPwQw+nLsaBfNvqBDzN4GM3TGaPhUbu
	 7gCAC1GL2gd/AKpCN8iiWUcT5zk5v0pKpxfeu7MEBBAs1ZfhldocBXB986GNKQaNvzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=CKtdFnTp;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E3606A320;
	Sun, 22 Nov 2026 07:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=CKtdFnTp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=qd3Iy0gK6elNVfdZMyUtCcq4GMv3WywAgl2WNQQdHhA=; t=1795334193; x=1796543793; 
	b=CKtdFnTpYXAEWsY/25CYRR6uKgOGdGIxzTMxnWQgRezJHMgXZEdVgDciodU9saJMIs0q2mxIWvr
	/D6hxGu4oLWg6/AzSwXoE47UAp09jmUIt7NKpLXzYSnL66VIiaPPl/TnLp13LNgTfsfIZ5MlHjHMT
	TbR2lMRtFMbfur3pktnYaCxDPd/MbrtTNpFGr0CjNa+nXDFxya8a+XRqv8Lz6YQwJFw6kzZj9tWsX
	aTY4iRErzDP/YpuEWuk2x8xU8LeSv/x86RM06vG1j+G+d5jTOW3A88Uj7wPC7L60IPf185M9RvQ64
	ZsDuHvXLuaeEK4udBz5VPu6i2s/LCK1l09rg==;
Date: Sun, 22 Nov 2026 08:56:10 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wanhui Fu <fuwh1120@163.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, dakr@kernel.org, kees+treewide@kernel.org,
 giorgitchankvetadze1997@gmail.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] iio: twl6030-gpadc: Add error handling path in
 twl6030_gpadc_probe()
Message-ID: <20261122085610.4a630af0@kemnade.info>
In-Reply-To: <20261121192448.78041532@jic23-hlaptop>
References: <20261121082419.376423-1-fuwh1120@163.com>
	<20261121192448.78041532@jic23-hlaptop>
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

On Sat, 21 Nov 2026 19:24:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 21 Nov 2026 16:24:19 +0800
> Wanhui Fu <fuwh1120@163.com> wrote:
> 
> > Add an error handling path to call twl6030_gpadc_disable_irq(),
> > as twl6030_gpadc_remove() does.
> > 
> > Signed-off-by: Wanhui Fu <fuwh1120@163.com>  
> Fix is fine, but I'd rather not make already ugly code uglier.
> There is an oddity in here though that makes a simple cleanup trickier.
> 
> Why is in remove is the interrupt disabled before the userspace interfaces
> are removed?  Looking back at the history (lore search for the
> disable function) it seems that the driver was way off on ordering,
> most of it got fixed up back 2013 but this one didn't.
> https://lore.kernel.org/all/1376910580-7545-1-git-send-email-oleksandr.kozaruk@ti.com/
> 
> Given how old it was I doubt this ordering was intentional.
> 
> So...  Lets do the more significant cleanup.
> 
> First add a devm_add_action_or_reset() to remove the manual handling
> of the interrupt disable (which is equivalent of this fix) then convert
> the only remaining call to devm_iio_device_register() in a follow up
> patch.
> 
> Long shot, but last real change to this driver was in 2022 by Andreas
> so if anyone is likely to have hardware to test probably Andreas.
> +CC.  Given it's remove path anyway and that would be rarely used
> for a soc ADC driver, I'm not that concerned if we can't test this
> change.
> 
Not only me. A new devicetree using this driver was just added this year.
If we are about to clean up here, we could also remove the error messages,
twl_i2c_write outputs enough.
I see no reason to disable the interrupts before tearing down the
userspace interfaces.

Regards,
Andreas
