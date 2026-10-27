Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120195;
	b=VyEEtF9HPkF3B+ckMSpOqY7exiPrQ2vq6sOTsF9NeMg5+YGUkDEX9ht2lRUEpWqPaWvy
	 /8o3Ss0w/v84O/hYAOpRJcoMeBApWrPxSw7SEzXqLXnUHbvvMtmTsOQsAomqXbEMQC+cp
	 sRadnX+pSvjuK2XXiGoz5Z9XAJ1X+ALsfV5tzgDTHSZ19v3ipqUjO4Prcgtvugx0wrrzx
	 1WoxD9aC4DM5aI5NlEY1n6qOe95Rxxm3PVkJWetudjhtX0rgFc/U+WdobzI9aSm5s+/rr
	 8DnMxmJbj8KI8gPJPRPDdpS2kX31xqMnMWx317A+T5x7GsM205rmYLaBxWv/wkf7cVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
	b=myDO3+JDPLXdO1X5G/HUZ9dmSzxs5KC45fDXuOo8vdmDKWodisb9dmkBBrd80hkeC+uP
	 ETgGiJ3sLAgm0ubbhqSAc0L9CFaubqa8r+iMB0jSsvij78G6SNlKluX3ysmAaz/XsSTIi
	 F2DeoaiaCGQhV/vsGUSWvoZXXC06SqkjSAbQvzVNyuHdOpsw3yA7Jg51Kwyq6EYQ9MtPv
	 qOQTOzuCrV9RtY798zTCrNLLKY+Jkm7BLqAynj77hRZbYX42nkVhEMmHZhCpIIpZL0oKp
	 45c55nq8yh1LM3dBwOdrnAgTD1ZMI90p7SqUQxsjAmJ4EEgJ4NtN42MfbaejL/8mq0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDYw6Die;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2091606A325
	for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 16:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2091606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDYw6Die
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6798eb0d13fso114212d50.0
        for <linux-omap@vger.kernel.org>; Tue, 27 Oct 2026 09:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793120194; cv=none;
        d=google.com; s=arc-20260327;
        b=g7+7354JCERNFNpEXNFPXHhM3caU7aRPhtNOFDCqkXYa7bDd70T3mqlhhRKqjxmGFt
         Xqvo4qwHuM/kaiWtE7LCC/SyeHNvh2fJu3BYjlvZ7hHsJuPvjl5Bu8UP51/IJ2kciZDw
         vw7kYfPyUC+Em4iZ4v1z4JHsQxjFanb7dp9tewsydxhEKzXX8cMOG8GXXX8YAakTGolW
         jS6/4EtjUCISf1jpDPUnYecK6SIwlvudiaxCjCEU8kC4CmsdusdjWpUC/o96MkUOYV8W
         nvZ4a/V6QzJVsWfWflTxkyxQng19i1JIVZbruR9LeE1uYTGn39FBrFSX19h5UDkfS2sk
         7afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        fh=Umtfr3v0egrZeM1pWb8yRNJbX5Q6Auo5vzCB+Emvyrs=;
        b=szk2S7mT+gjgqZLjF8EmotuytVDY6TqqhifDiwSLQ/n12B85d3xwzdO7ENsGR3cMIr
         GVBHaNMURU4OiW4UqINF+f9UINrIQ/5GA9i8YtP+wWFFIDDGLnWw0RZu9m6sYWxVvaIi
         ljVfw9eR8SOE82eVTProXyT0q3gr/SVPAdUUdxMsfIndLV/+wXoq7foKA0LLAkrK2gq5
         BBIPElqCtuffxzg93gKFfDeIUlLNtT+mxncjiXjrjrnb5CR6cm3rxUW6dnmM0gAYPE1i
         PMEdDoCXzxEXARnHnxPi6LEEeeqIQItduaezoT2WW4vkHdQtMlkOMQFoqh0FUKLjbHWA
         WxgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120194; x=1793724994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        b=lDYw6Die2KdQMWd22enGnH9RlSiNSaboywe6ax/oHn4JWnEhFXiXrIqditAtmJIz4I
         ANqYdr5TYj/tBJQHNYsA3aOq5YM15k96itt/c90Myyon7yfyT0bzGguqHz1VlUG2n6oR
         XT33uTMw7r7IxXA98eA3MP69MFkoW/otenWvUEPHAH26nzbYQXFNOtWSOmWo7owoRg9G
         vdaf2sNz2nAnCUaFRYL6r5zLtAIJ+0gEauj9gVt6wzQpXb0Q35Y2BE7A30wkQuXzNG7K
         mlsHLYwqaxo/loPbgNy5h3B9vZPW24h+8UWJfrwr4yeqf7/u2Ts+6s0WKX98fipmIy89
         ldLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120194; x=1793724994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        b=ghQfJCHntVzcQmNNYHDsoKTttNF+v9+sXY5Q3pF0zCdGv3CWoOoOohsWS6vXBLlauq
         vjd3WKppMeHNt+BuucUFEVkihHfSJkGw1FiuO3L83ENRB3gaTM8wUE0CsJzjqza+ry6J
         GMlk9s1fjeqITC93sGtcyeZi+wnv8QQa/1ov46dRXV9tHGb7FvZQ3ZKrudU5tcUulNjs
         DqMZSZXocmwAU5LYfB9zpNge20zGaWWigjYfr/pkFb6WOwY/vkhHk4EaD9vJz27ABqEi
         R9yc4HYFANxwYs96Jw1K3Zklt1Yeht/bpnK52RgbI1E6BAMN28/+noj8Ui9mRuZrt3vF
         TGJw==
X-Forwarded-Encrypted: i=1; AKwUvBxokvxzPLGbc8WigTZ2dDF3h3iCrFwrvc9hXTMlhRb6bf+DwBfl7lnz7ydV2pvDK2YDDCeQ7eL06viF@vger.kernel.org
X-Gm-Message-State: AFq9FYKnwJ5TpLrfpVj9DVwz5cFw65TSRjfVxnejAkkpdynGOuJIQC6m
	h05texJfr4qgAETlh/UGILMM94Ml4KDvFcyxOsfhav1wdzOuTlaLZRUgav9DSU9UvtLbfBUXvUN
	oGTECsAalL3ghvEA/b4uuKocun4yGzzM=
X-Gm-Gg: AYBFou3QUExgTVdvFcxhRlXqCF8r0joIC0uTI34ZqtONMvyvbCLGd/Xgwej88UYfJih
	0srWY0lB7CSS9hUDUfOIs60C3XQegE4SHvhdXW9gTuwpDbJGnzbBF2g4lhnD4o4Cf8UqNcvruqX
	hHvzxOemBac8bs0XyIPoZ9Ksb9p75Ls9u9ueYjt7zIeW/YMNztG9Goh1e8eeaQ6pIBanq7d2WMq
	do6eenGpr3fiDpsOwsHObmb/5XNN5ip0mh4+R5Amj1y3VSoVt5UI5b3i2m3ARQcG7vhjonmc0AQ
	Y+GCb0I3JPcvBlBkq1EcuAHiLomkTmj30CPoXOAUaMS05k8vapW9bbajC6RXGgDu9EaWC+cR/HL
	h0WTkMiVrRzquphsX9UIb9v135474nI/G13E85w==
X-Received: by 2002:a53:c092:0:b0:676:9578:672f with SMTP id
 956f58d0204a3-67a7bd3d839mr38638d50.135.1793120193486; Tue, 27 Oct 2026
 09:56:33 -0700 (PDT)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com>
 <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org> <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
 <585b45bb-a9b8-424b-abd4-66d53076b501@kernel.org>
In-Reply-To: <585b45bb-a9b8-424b-abd4-66d53076b501@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:56:23 +0800
X-Gm-Features: AclHuK-GfmT7NjkDsFJqpYDLgkQ0C0xdaJPsVN0W4Sw0aag8wcbtxfBX0j2KDkk
Message-ID: <CANUHTR9u0CMsRWj12EN-b47BazJ8Gjk0yvRHfe_G-BEbrJgGNA@mail.gmail.com>
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

Thank you for your feedback.

On Wed, 28 Oct 2026 at 00:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 17:22, Guangshuo Li wrote:
> > Hi Krzysztof,
> >
> > On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 27/10/2026 04:26, Guangshuo Li wrote:
> >>> twl6040_remove() currently removes the regmap IRQ chip before
> >>> removing the MFD child devices. This destroys the IRQ mappings
> >>> before the child drivers can release their interrupt handlers.
> >>>
> >>> The parent driver also registers READY and thermal interrupt
> >>> handlers using devm_request_threaded_irq(). These handlers are
> >>> normally released by device-managed cleanup after remove returns,
> >>> when the corresponding IRQ descriptors have already been removed.
> >>>
> >>> Consequently, free_irq() cannot find the IRQ descriptors and the
> >>> allocated struct irqaction objects are not freed. The associated
> >>> IRQ threads also cannot be stopped through the normal cleanup path.
> >>>
> >>> The probe error paths have a similar issue, as they destroy the IRQ
> >>> chip before the device-managed IRQ handlers are released.
> >>>
> >>> Remove the MFD child devices first, then explicitly free the
> >>> parent's READY and thermal IRQ handlers using devm_free_irq()
> >>> before removing the regmap IRQ chip.
> >>>
> >>> Also update the probe error paths to release successfully requested
> >>> IRQs before destroying their mappings.
> >>>
> >>
> >> More of postings by bot ignoring any feedback.
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Thank you for your feedback, and I apologize if our recent submissions
> > gave the impression that we were ignoring your previous comments.
> >
> > We did take your earlier suggestions into account and subsequently
> > submitted a patch series accordingly.
> >
> > For the more recent patches, however, since they address issues in
> > different drivers, we thought it would be more appropriate to submit
> > them separately rather than group them into a single series.
>
> How this that differ from last time, explain me please.
>
> Last time you sent x separate patches for subsystem foo. I asked to send
> them as patchset.
>
> Now you sent y separate patches for subsystem bar. You keep repeating
> the same.
>
> Best regards,
> Krzysztof

We did follow your earlier advice and submitted a patch series, which
also received feedback from the maintainer:

Series:
https://lkml.iu.edu/2607.2/05103.html

Maintainer replies:
https://lists.openwall.net/linux-kernel/2026/09/28/2917
https://lists.openwall.net/linux-kernel/2026/09/28/2932

However, you're right about this batch. When manually sorting the
patches, we failed to group the related fixes into a series. This was
our oversight, and I sincerely apologize.

We'll be more careful and submit the related MFD fixes as a series in v2.

Best regards,
Guangshuo Li
