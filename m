Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2D429CFF
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070587; cv=pass; b=CaM8BD4+PxjwHMfLgJWeASAp6ZCU1VmxmEELTXOa8CeDt4pXKKjMrLrUaVfTK8X+7nxTiiZxDR5XEDtVPprExTPxZZvfOgixF6GrPJJVEepIqEeW9XLjnbbVzd8hSloiFg2Up6ueD9A/ZeGe8FaW7tmutTgvUvDout+iP/38Aa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070587; c=relaxed/simple;
	bh=DY5A1oWwEBN0VKyLnOnlH5sjYbIRDBe8tPMQMp7pkQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHQl672X9KwVTSYZFBsdR+rhhYzgVA4rQZShzloaoC0Jths/u5pRxJivxKTjtf6YDjbVKJAnoCSgMKJTiDTWVIY2mRywTFej4YyXL+V25gyW8LLm8XCQU5oHkPgvRlPVNXqS5L5QzD1AFhzMZ8SS+rEs0lVRhwthkhB2abNnTRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZl6ILGu; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZl6ILGu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc61541f8cso1021065ad.0
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 16:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784070581; cv=none;
        d=google.com; s=arc-20260327;
        b=P1+VT597iJ6Gf7y6aYhXS/c5SVgfYIBvL/0PhVi42JuCLkjjeYtnfgba3XuHnkhUfg
         EOSLzVXVJEpqWTeyu+9cp31RY/2BwiYQPfiT8j/zY18uMH9zpDiFdrFVOUR9fDZJmSCz
         qtmq+BNdX1k9tc0M5y8Ypy/Xbfh9sYvvPJDCeOtfFvViDaRe+yEG/XYIi2vw/DB+t8kr
         rMNrkJTfBaqPlx8D98AX6iVtQMn3Slf77DMGwuY8qe39+EXs8Bv4SgDf38qvcmYCdzuO
         rvlEepd8hpRJAN8h9ngPLGXzLLqzcZQ1oV7WoQV/I/zf/Dbp26nHc/odZ2TVu/yUWU7Z
         SY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MmzNq7zlle7zsDCKvLICynJuteFH+SgQHCQ2iOLA/lI=;
        fh=7NW60cAAHZUyvPlI2epi5q6laRb1pMsPePY15vQ7zsc=;
        b=Ycu8UzoELZIg0E1eeSGLndcsIUK/Z3cRGzh1fr7RvK5gazQV2Ig4na9/73ty5EWKTS
         VjhFiZO+NJZuLB+FZ6VhknUAvy1NmLOvv3sNqV4+wGybJVW+mECrhtiUM2MEVlQ5wjvN
         wIuzKIqxqTJfAwFsRP8UIRHpELTt4iePqS1HzvGTq8J3b6O4d+/L4N5gdwUHcqbaZSGx
         7Rk2YV6+RYIQ77hJCb7Kf5ZqBIVEexB36RKiPIUNqD8jMQqUNrHvOvqJwdXLCDv6xUfQ
         bZqzUeSQZqt51JOB3tJHx/mv8NdiPARUdvbHjtT9tCdLL5bVAiNBJ/Wl5fAXpaCtbozi
         q9mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784070581; x=1784675381; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmzNq7zlle7zsDCKvLICynJuteFH+SgQHCQ2iOLA/lI=;
        b=pZl6ILGumQ84L9xLnXhhetfYSyZaspRgdAcHspSwR9XeHeYPyG8Y9bYlS6aYveZ7x9
         aAKlvw+7TkyO1bgtP8JDt+aNZjB66kwx9bRYsjYLBT7XZz+/sInltsVOssDveCsvDD3+
         a84AcOUvv2R1YCfg51zs+4DFE991/A5+kGnLEVZ1o+u7N6r2U+sJF5hTpWA7KsqJpvtP
         Og9+gbDpaCbxlEZu6VqGIcLz9RjqysBNyCXAfqodzLkxSxNT2LEvWuOfd4dSm2HDajWU
         KEEKvhWVAYSkZET82R+6olhiH7lSV0wigqMChq2T7hCzWFw5GK7JCZQLvhxhaT2y9RxH
         eNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070581; x=1784675381;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MmzNq7zlle7zsDCKvLICynJuteFH+SgQHCQ2iOLA/lI=;
        b=adJW7/z1flQuv08yfeeHCqmxdKAAOWtfrvPja8a2EVXIp2gNfchRzbcy5GJ0+q0lLP
         q0dS3FlyyZ75N57q6hglXVeii41L4YVjeRlnCiwbp45ux67RQpiMm4fciM2nrFp1IgAp
         trXm7DfFK9fP8zj8lYQyQKABoXKQD9Y2MM4pFXOhKEma9/nrqAbavpcVw5yY6YNOWalB
         7EX1r8mD2nhVO/gQmgcukCfxcOa7gCjB7iY6bgx6yNp6Q9emoXh1ElYa1VvhhsClhq9x
         Vn5BgwtWzDZTcDFSPMMm/fHmFJfwIOdxaxtnVx/0oZ9CaXj517bqRH6pYr32wSuXmXUK
         rEsw==
X-Forwarded-Encrypted: i=1; AHgh+RpURYxra6vd6a79ODxWYyO+67ur7w6wKNzNisWjj1ERPWndAfuiAt72QjQjCeQHfX2DEEsnQ6wE0M4Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjg2WbYg2eo2HnDTdjz94aw7muWNHekuuXU9temQRlxXVsg+1O
	pHD9LD6JVlVc2pLALUJpO5G4vzS6A6PXoZjwOWdxXe8q/HS9YPhbCZ/T3A8ZElrdoPGe2GEQOd8
	7AGV/hKm7/ew5Bhl28rHY2mmYyIX4C3g=
X-Gm-Gg: AfdE7ckL4HgYuCtoRnMlwVXBYGYK8BpJShhZO1UolcgAXz2IDTdxPlZ9JM8u3LGO9kC
	Vl6V6OVslOsq/qxZXSrBfv/ivnGS1kGeq157lLn5GnWYZLRcMh3WnF7h75gYtH1uKJKBgpJLxJs
	fcGQ1IwWqG6mvR+slac8z2QAhHswOOIpVX4ck7oC+CquJKqo0EBVKVZRzWLK/LC9+fruLbP5uiM
	ssE7CyfGJ6iv2hn/1QiUcBhpikM7tRcGk/7gmIRox9sRo/zbi9mH7yPTqtFNrFU/uo423NjEIfN
	u+u+O4SJuifSnuG8lSWWngy7pb7oFjcksDQhZqhQ7YgJJ/yWl6gsSNMl0WZCKw==
X-Received: by 2002:a17:902:f60f:b0:2cb:402:70cc with SMTP id
 d9443c01a7336-2ce82988044mr185566725ad.28.1784070580677; Tue, 14 Jul 2026
 16:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
 <20260714120042.491712-3-phucduc.bui@gmail.com> <08dc1142-0ca0-4bd6-b59f-12a167216c03@wanadoo.fr>
In-Reply-To: <08dc1142-0ca0-4bd6-b59f-12a167216c03@wanadoo.fr>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 15 Jul 2026 06:09:29 +0700
X-Gm-Features: AUfX_mw4y0TRwTsXh-IuUCF1DYinIeTjIvxOhl0u7w5b8FRXnViXEK_7O8jyI1M
Message-ID: <CAABR9nGTcjgo2qkTCazUTLQP_aMsv3M-cx=DRSHys8Anja+91g@mail.gmail.com>
Subject: Re: [PATCH 02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for
 error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thank you for your review.

> Nitpick: this blank new line could be removed.
>
> >       if (ret) {
> > -             dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> > +             dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
>
> Nitpick: Could be snd_soc_register_card()
>
> >               goto err_put;
> >       }
> >

I'll fix this in the next version.

Best regards,
Phuc
