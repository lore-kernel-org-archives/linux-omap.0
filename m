Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B2385509
	for <linux-omap@vger.kernel.org>; Mon,  9 Feb 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655836; cv=pass; b=F7qzFlxN+trc8adpQCMe3NpP6U61hNuXxtqmu3X8DUL7umLEIWQI1oLCplUIIu0fqSZV5pmPhI5NEfXXbNrEUR/uazAOCZTKzLj3hhXJ+7vc6fYW3rBf5AaUh5Ws8DpPZVVNNjdvTRuAcgyYbzu0uapx96/TpIUq58RDjMkCZ+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655836; c=relaxed/simple;
	bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abadBjhv24HBe7q+XG1m78/pUNoqa/5hs1TI+U4VPDxerniAfjgXHoQt3Lte4ytHgNl4oCU7WCSG2YjwJf4W8alukHpjRRAgeulz/f6pOYNIenXySHtEL/Ug658CHPUD/E1DVn8zGJMtHJt2p7Re1lFawfTEjx8OiJRYCuEdmF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bd0YslLZ; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd0YslLZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dd22b9895so6241228e87.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Feb 2026 08:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655834; cv=none;
        d=google.com; s=arc-20240605;
        b=QgJUudnEP5Qa91hGfCRKLxudj1rXFRZ0dYnbPp9vpFgHmFHjYmq+193Ue2JqrDGbFP
         hzn/s1eC4O19QmKv7usn6tXzSU6cAVzsCRh4EmojdI698PEyrVUOQTyZsFrCQAfYifAu
         NRvZRg+Ly4xH020W0AXTLj+QFwZbfv5RvCar0jkMMHNCOF5porM9TGbY8QS21fLV6lvg
         yZzh6FJMcwnwuBF+MZTyKzStrXiVH1Ii5BlssNf2n4vcViyZkJiZOtWKsG3qUzErMeFd
         0GisCCI9lJ/jBpv5DiHw2wdZWWW5d6lIGG/xPR3rCHBRNK0FQIlQfJKIqEnW+kyb7Yrw
         LoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        fh=FYNgALypsfYMEZtz51kMr8nwBPP4lIJoLeX4NAl4UPE=;
        b=Mm55w+kzbqUPODZ8eOnYweAIMvUS2EkFOyi/rwbEqBdf37Vxd2fNxHK3cgpe+4LbvN
         WuGoqxO3yqhQFoSQlEYcBqyvqevClC6ebjCwsf/uRhIYhrXHnLjoe5/9cePj0eV5sJSc
         ZFinlaIVYLrD8zYIs83n9ELVDXoMVUl3AQONlAJb80qOEXO9G7MjIGAaymRrl4s5sIfQ
         kr5c7X+IxTrNj/vwJiGyJS2ySdt59qROinp9lhF1J1Xlr9SdGJ/VAmgepJ4Cfalb+q9R
         xKJlvLtksOIAL4YSN7Sr/T93nsGBh7ILns9zukq2gbC8RX/AVvwDI5O733i8bw6535Wf
         z58g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655834; x=1771260634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=bd0YslLZKFA0AqfhMWqkF0xpNqGgg2NKEmE7dE2cye2xsPGqBNkqik4BwkSEsPb9eA
         nmauDKs8yxZKLTWYzQ3zMRZBypPs/rkVsf0jrVwUTDQ7o3nBTbDlTi/sTYLKlWXUfvXf
         azMBwgthmeVHZFNXpD13gofK/nfZ2jxeTCpMnE4XgZerDqBXRZBwiU40lsgxicdtvkQ3
         pL7QVnig1G58pueOmntY9CtGPK2RFFeC2PWIm76NoizJ6N1Kr0rp10P6MtpAhECKIamt
         YEl+Yl0dURQc8xGoLQPKJqm/CzJffy+0McPyxe84oZdODzuESF4mnq01EM3yiIUzoIIm
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655834; x=1771260634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=uElfImY49sPpgvcoaNjqXzWtsVqKv7pq3zPi/i3tBYTuI75jGPmd4SWWbB4hZD298o
         PwXQsuG1tI/Wg+Z4M9LYQxmvZtlr5KZLpuiX5KfB+x/za1VXjtz2qiXNmapVzHOEbOOF
         3B06+I0lr6xf3Ea1tq3Vmc1gMxsPERYFyLeGgd8vrXgUxasw6PjrWgnA6MTxTTfiXQ94
         jsant7NgTAP/qJ2i7TGI/1bVQ8Y4h+D0Cn2+DIb0sJG/pGXDroizO3t/zWan5RLYPBNL
         chbBva52QzYoL7yGGufT3i/GxvPDKNkW5o/3nZ83MqruT6hnaouCWRgOPS72TodQHaT0
         Dvjw==
X-Forwarded-Encrypted: i=1; AJvYcCV1OeYovJfUyEkQpETOJWCJi/tStqxN3gBlZsBzKBSh9mMs+2LbSjuWuE7bq9mI7XhtbZqoxnBHIHH+@vger.kernel.org
X-Gm-Message-State: AOJu0YwegIjK7CM33UO+tOhrZy7L+teL/mqjGjs2wlW80DHI2vTdZFqO
	NgnD21wpG4sqhwJbBT1JV+x8L9jvSKS6tgNP7IZG6CXP+k6l3Evz/ante3kBf+4q6WdR+0jHoK7
	zWeHs7hfW6KnCrjI+1wri93SZq5xNOZFVbisO4c06YA==
X-Gm-Gg: AZuq6aLDD/v9JmpiPGNHacw5wKy9eE9UWpin9gxoKbI36NJtAIZ3sxZ7i37z/DrDiIg
	aa0I9IzkevlbBGGf6mk08OkV/1JAaVZFeVa76onEJl64g5NRA/eKpJTNNxTYJBeLFA0dK2kVaKD
	YUkQOQhEbOqBmEEsv+qM8t3+EC7TWofgNDFrVva7N2iAIR3DPL08rqhFaVtmMTFMj3DOvambUOb
	c5mQ2h3F19Ses6yhqGWYIze8yXzz0ZYlSqD+2fYSx2+/q00cclPxp63MikaWa2+8qlH0cmaTL1z
	7Ij0ipfMv/bSsMWtawQSmjGgQm+j
X-Received: by 2002:a05:6512:118c:b0:59e:4d85:d82d with SMTP id
 2adb3069b0e04-59e5437754cmr14477e87.13.1770655833649; Mon, 09 Feb 2026
 08:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se> <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
In-Reply-To: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:49:57 +0100
X-Gm-Features: AZwV_Qh1nXgInou2tkuYLPeqnXQDy8RDhZJ2fx9TuiqfqWwczkYvBAKEQ3MJW4c
Message-ID: <CAPDyKFrDLEzKrFY0GeevptDdRe7JAUzXgqM7fVtQ_PnYDi+N_A@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 17:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
> >
> > Hi!
> >
> > 2026-02-09 at 14:39, Ulf Hansson wrote:
> > > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> > >>
> > >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > >>> I have already applied for v8 and it's going to be in my pull-request
> > >>> for v7.0 in a few hours.
> > >>>
> > >>> Please send incremental fixes on top instead of a new version of the
> > >>> series, then I can pick them as fixes for v7.0.
> > >>
> > >> Hi!
> > >>
> > >> Sorry for being late with this, but as the mux maintainer I'm not
> > >> fond of
> > >>
> > >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> > >>
> > >> and would not like to see it in rc1. Can you prevent that some way?
> > >
> > > Sorry, but my pull-request and branch was already prepared.
> > >
> > > Please send an incremental patch on top then I can pick it up as a fix
> > > for 7.0-rc1. Unless you want to manage this yourself via your tree.
> >
> > That unfortunate. The patch series has not yet made it to the next
> > tree since it has not seen any updates the last few days. What testing
> > has these patches received?
>
> The patches didn't make it to next, for some reason. I queued them up
> last week on the 4th Feb, definitely a bit of a stretch to pick them,
> I admit that, but I trust Josua to help with any kind of problem to
> show up.
>
> In regards to additional tests and reviews, lots of people have been
> helping out with this and we have also received patchbot reports that
> Josua fixed too, along the road. Moreover, the first version of the
> series was posted already in November last year.
>
> As I said, let's fix any of the problems on top, it should be that hard, right?

/s/should/should not
