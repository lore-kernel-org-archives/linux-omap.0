Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118176;
	b=GJbTYRcHASTzXkMiPG1kou4hwWGnPEyc4BRPmKK/s6ZdkBWa19YNichkvfMUoK6W3cZu
	 PoTWh6hJF2RcJZzmx1BeRspa90D1yXZOCYDrzUxGHT0e8bGluHKGE6uSyCQwUSAtOGVXZ
	 PAQNgh5K+JWj4kZcyCRMbX0dFbTD5fNzh7qBHHindPGId7hZFEQZjfiHpzRy8Wdwcin/k
	 65+80t025o31NMjcRYlRxJcPyALxzHItr1FbA5NLNJmAOwBT1NlAHCyxHf31JjevZ7NMA
	 HLzg7o0eg47yKXpkXlIiblwQ9ZjDME4txyHvreTyCoJS9VJsRolgBw/i364z/iVB1sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
	b=lR3oFvefyrkIQRUolEX0e5DP9oEzeI38q9KgEUu/ArO5r/mWj+HF/AtB9sJ7zQHmqcnO
	 v3r7tGv8Z/hxNeB9xWew7fffjdQli6/eKNuA1h5i5Ls+RDitKYrP4rQscZClwUIm8jRDg
	 dFOiwTxgCoRQa+rkApEq2PeGYX9/ZW19UfgCGoBZ8zgBeDkN4Vc/kv3ACG3mZ0LiOJGHr
	 nEroNu3UgyP4cFi0H1ZcjarriNBGA3z9E00CdhhS6UXJyvSPu8mE+yfZ86bnhk3l/dPuJ
	 zpUVgaY8pym3uAiL/AmHRm+VNibWZobmX7VQnskl/O+WtkSEAZL0dk5StTbX6zx8Z5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgV9nJRE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE160A262E
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 16:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CE160A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgV9nJRE
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab43af5e97so140967b3.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 09:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118175; cv=none;
        d=google.com; s=arc-20260327;
        b=cSojK7ZZT0S4OJ/FpiFbMsZ2OhHCY8gCfDjlM07sgg7aH5TBRmdDvs/AD8DippoH88
         kavRC5cPNZ0QyrXFxGpUXjUPbFoV8s415xhjmUhioG45YTByay1/3Uq1nImBgc9cNg8H
         ox4n9y/HZEbf2oRxTFG7TmOpiwLQU/m6VlXTcUO+rjHAnMcnDYLKKyMNHb5fLo16BoAr
         bV9P1oALLh5KW0E/pSiOwuJG8s5uRV7R+AyRVXakeJlvH9i7vWQesRGFISd7DlB8fRli
         f8JeSOMsJxoeRkwZiqL+pMl/Tv8SZPMOTXzA6I1iuTZ9Zi2i3hGHyURvZ8yQUGaHdRe0
         fWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        fh=HnW0Vlpiwxdlo/VJ5aR1acOBxy9azH/hDECuDYq/ER0=;
        b=S6XZfddJBFwGOtpFKNIEDINwkLkhxy1DE+CRrksRhz3i6tQcWF9Q9CprCIAGu+XYCP
         EfMFB2i6Xh7JU15QsHIk4oRSpkvfRDe8XR9+vBVWygEzAhFjGg7xDHDkEltefmFQwX80
         +Ii2oJM8GZmxxa1wXvcHfFCQzz29airhpiTQlqeKJTYMyrm5IJwWoq61fINwgxvQvNcs
         vU0aFvBoF8gbCXhjPcIncr8TXqkC57zk6gi7RU6JtxdI1duqbvgeZVgG1xCbtJhMo4eg
         MipRt1BOl127HdGCh028C3RcJfcSrSAnZ0ZmVuHkjYHkLo/b+gVpjVp+X40ZyjAiTu1k
         2KUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118175; x=1793722975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        b=dgV9nJREEGJRJ9QmZnqkErrAe+48xCQlxpl768uv/UFrYOpJ5vGmw1FdZrXRTu2cXN
         xdxn9LTkyvYmnAfpAeId+I87c6foglCe0e7IOk+MUjOI0KWkQ5+6WvOzSkNuiegFa62z
         PgVusNWxO5SqIq2OHRAWlFvaZ4SD4HksuK8nvqBBVkZdxU4f+5hyNawB365EHUmD50SX
         xd1fP9w+WSJT26mMvdN+TZLDrWisKuL/C2T22PkvAWscLcIZmOC/mHidXEnM+pQa+f8E
         GwVzeEnIaj18wcAo07Wb3PNMFzzLUXjv3OQJVqky8xgIUWOBLVSB7oHfumhlX4TLFuuv
         +9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118175; x=1793722975;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        b=jjKrdiLR0ByhxC1VHpxTYt15raNImzTIm4RjIYGoE3i2Go2DFi+vcfHcyBhF98Q6Uz
         fiJ1dmzGQbDYfmKVPpixYjMFKFA1whgvTY9mfFCrLFmzdXRWcGDoii3jbLDh+KR3vSZF
         7JV/4r1bt/DPo6Oi64sdMxlNt7X18ABgrs8PRqTcUdGr9MRXwZqNeJf5bJL88Cy6w4gq
         zSQbxk29P6hBV0lJNDDseV/bYH3ApyQGIt2SbMRsY3pQQ1beI6R9OpMxU+VzhhXCUgXJ
         APbMXByFJg5CthdEg7t9dz4pnhbNkJ+QDnuSRGXDLatBIghXuVZtfnEpX5LdW6yRWPLy
         JVKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbiWHgXx7+tBl/ptWVPDPW6eUjhPkKbFFU6Fc6nUqOU8zaiQd/0GOUeCo3t9vUo/Ol65r6e1KdDkv+@vger.kernel.org
X-Gm-Message-State: AFq9FYLeEBiJ7uX6XGT7Fo8ekFytXiDpAHS1qdCLDovwe3OwtD6MiQfj
	/S80rZ3Ah/qSLuaGk+ji5LDDpE4Pm7iUiAffgm6yGddATPcpV3W5Utjkdit5sJy9Uu+z5YAHeEd
	4abcaqI4rSKiDKksq8k5aUDTfjaZMBDk=
X-Gm-Gg: AYBFou0bcZMNZ23xzjfawmPS+qycrCflrqzO9Ytm3v8LCKMNk29WRcJjc4+bMb8sna1
	IrRwlUlQQDCAf3W07MCOWphEElbWhybRZesXGOw68jIK8xZ3sH7rwdx9pGcKE2+evxn2g7+BZTe
	qQmj2vDlpd8UChSowmE2VvTyu9uyfrj5cXAGmQMgtEfD5+s9WrQTEJLfMXmJO2YBy3sHbn6Wy7c
	Wi/ASErX8wx7XadAMM7TC6TsqIEclfAu4dwV2Wsft9H/GeIGVdGaQe7ku9nK3fwAHtnCU+o83Ub
	9O37zwEbC9DPtCE6ZItTFRjAcJ8pM0hPITBQS5zDKWK74sUTbBj2MTKD59kSjEqHM0oY2F15H6J
	JT/wi65B0FdV24mmbzXRy3h8cmG2sD6Nr0PPB6w==
X-Received: by 2002:a05:690c:fcc:b0:8a8:316e:5973 with SMTP id
 00721157ae682-8b19c9f0c84mr27894277b3.14.1793118175296; Tue, 27 Oct 2026
 09:22:55 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com> <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org>
In-Reply-To: <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:22:44 +0800
X-Gm-Features: AclHuK_rUH-wQYjXcUxpNAITglYIi677x8p05GEnBtjGRev3n8Z0DOrQJ-qbQ2Q
Message-ID: <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 04:26, Guangshuo Li wrote:
> > twl6040_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. This destroys the IRQ mappings
> > before the child drivers can release their interrupt handlers.
> >
> > The parent driver also registers READY and thermal interrupt
> > handlers using devm_request_threaded_irq(). These handlers are
> > normally released by device-managed cleanup after remove returns,
> > when the corresponding IRQ descriptors have already been removed.
> >
> > Consequently, free_irq() cannot find the IRQ descriptors and the
> > allocated struct irqaction objects are not freed. The associated
> > IRQ threads also cannot be stopped through the normal cleanup path.
> >
> > The probe error paths have a similar issue, as they destroy the IRQ
> > chip before the device-managed IRQ handlers are released.
> >
> > Remove the MFD child devices first, then explicitly free the
> > parent's READY and thermal IRQ handlers using devm_free_irq()
> > before removing the regmap IRQ chip.
> >
> > Also update the probe error paths to release successfully requested
> > IRQs before destroying their mappings.
> >
>
> More of postings by bot ignoring any feedback.
>
> Best regards,
> Krzysztof

Thank you for your feedback, and I apologize if our recent submissions
gave the impression that we were ignoring your previous comments.

We did take your earlier suggestions into account and subsequently
submitted a patch series accordingly.

For the more recent patches, however, since they address issues in
different drivers, we thought it would be more appropriate to submit
them separately rather than group them into a single series.

We certainly did not intend to disregard your feedback. We appreciate
your time and guidance, and we will be more careful with our future
submissions.

Thank you for your understanding.

Best regards,
Guangshuo Li
