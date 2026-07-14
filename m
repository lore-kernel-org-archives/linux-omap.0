Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A003ECBD9
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070402; cv=pass; b=odI15Z+I1baZT5rGcBSxcYYvEilrxlSnjmEY4Re8gYyr6A1omwDV0Xxsne53Gsa5kFNIv3yROhyFP+xXW5JTXTo8rFJonUsV4kapqecdfMRw9gxr5hGVpFgJqrpU/dg1ItMj6niv3tJ73BE90YCFHFQN/eF6eWAhJFIGi3XHHFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070402; c=relaxed/simple;
	bh=rlRcfcnT+ValWu5eD3CROgJ8ttsCpBtQ3lizbY4CaNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjQ+vBgKr7YoPC9aHs+K/NQDbV0HoQw6vuxtYMD2VMkmaQirYauNevRgLhFn4RWg5+cb0MAp8TuY/sMcdeHZUnBzgQV71T7tqitLo0Blm4jV0LY4/3yM1JABmZVB6o7+zf6ue4hmRPznB4z7ZUS63t00UPiKxxoL278XTHXtdRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaTbS6sv; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaTbS6sv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so81769305ad.2
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 16:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784070397; cv=none;
        d=google.com; s=arc-20260327;
        b=hm0+CQrmNbdUMrDrF0pBGIO6tjAycou3NA9gHFVqB+ZRBRd74pLlChzLtberFbvGs5
         Bb7GxjdOutxL/bu+d9hx7yq7+DJwsDizBhJQxrgs042zHFmMW0gCsBQrDct103uLuu38
         jJHo0+W3ndLpTC++okkbvuJU12DFTgZLO8ADxPIMzJr6hHozzimpD/7oikyClVHwuE/+
         nyzcx0Lg9hq8WO+mLBzOabl3unll0FAGu0/erOm45WyZoXLsOKxTX4YlIxELkKNRzbr6
         R1OJAHsp8tiC4pnRgPLlvorszDSBwRgbergUUvD6VSy7hnW7xWU2CEQWQ/8mmns8wyBC
         VqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rlRcfcnT+ValWu5eD3CROgJ8ttsCpBtQ3lizbY4CaNQ=;
        fh=OONaSeDMyFHqZZE0hqRq7S6jYO+LxDGgOWfFEL5AwGA=;
        b=DfsaRxfNQcBKyCoIliQRH3kE9HlrCceFbDf0T8LKoBkLr9MQKQbJevAzcynKqpUOKu
         9jEvw/lW+auDQt6UwvYp6GrU8WJ7x6PW3x/It6cs/A1QkQNG9Wd7K/I1TppSVA8pWi/G
         ngsfCkSX8PAwFQ8ftYrJF8P8NdEqd2NvVoh62pHaNBN+C7XQ7ERyoywIsORwb5WUlXg5
         iFD5PfYFoX1rF4nib+kcZd9CTQ3xNcXc1fQ7D88/nnhYTTR0irTNXAArKW8MjFhEQ9je
         UxAUbI47tZGSWfHNOCQZkHNZeVHyHbdSwxBP7uEoCFGE0oUgCupje5U4s5bxwoBan73n
         LEqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784070397; x=1784675197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlRcfcnT+ValWu5eD3CROgJ8ttsCpBtQ3lizbY4CaNQ=;
        b=JaTbS6svqDysJdwppwr151FpltpF0cGDXvTIxETwBrOb12+qYsclC3nJ0bgzyGnmLl
         bFOXZyDXtTqZZfO1L555XXQd7z7UEV5oVEZ7xUUFft6DqI8GxIOgPkfZS9YKo96IGbu0
         yrVOG2xTgfkP+wfFWicXknpzBIYRz6j80K0TCOmicUwqYk0OVXI0CPV++UWsOHkbQxMc
         t1vxSZ7fuoMdagnH7xvNqP/hosQVIRNlcXsFJ5a6jzfvd/G4hASStFrsY23SMrGtRnBr
         U8NYojS7gVvnUO52LOL4NGAsxfkQPV3vJrAf3hQghl0eE411oJ/xKwcbH7JKjm19t/RB
         DJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070397; x=1784675197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rlRcfcnT+ValWu5eD3CROgJ8ttsCpBtQ3lizbY4CaNQ=;
        b=J7Btqy+/K/5HBJXDg6G8MhqLqE6aBUUWjB3DO+LrtU3/xHfKOq9hyME4BpUhpzogCp
         EW/OBYAloBTs59ZjDA6CMOynlq5z6Hhgc9y1l2ZGiGNxL88F9SFksYX7kjmj8VS8zDvq
         ja32oG9IIy7MrqGowkDZ49P13esqD5RVbDnPq8Scnfx5SCO+De8JR/qXPufczYGs4+GL
         tMQwEjJI4jJW9+i2O2C7/mQHWUKcs6kqSS/kHVOWQBM/AeW5KcygVpLieGL4Cxr0g4ye
         Sc2yJ691mpX1bM1KlWmPpP6PL15OSTMbw04WxJpgTkl7HBZmonnlvN4YUi4MlLDFfPF7
         HDCg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa9DUrpE+deORevoc/RH+RfgxMZTu2AdoUH0p7XXFSfSu31KdqolEWuYKzSI5Elt9RDZji9isB6SRy@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUniDCwAyYLI4Io4z9u8qC8oDnugZCTQsHLbPWONbmxu51Dk+
	dGJN/fg0okp5YBT8aYnByAHIvOhM6RTSImT3NMLbdNIpgKQuaTTt3afNaI8/qOYBaXB9T7PaJo3
	hwvxyENfY4dff8XuJHeYt1dK7JRENY7Q=
X-Gm-Gg: AfdE7ckBkZ+5YTxDZp4rQDXcvycE0HQWA1GsuaMHgF+iuwbMrMLrpFOeGB1t71+zGyz
	iQC55XU1bw3QgrvDuawp6ddXWGEJrwCDS1//jnxyx9IVJN5nExTyG6HSuTdiB3VAB+dOjN1HvAK
	PV8mjIbGp3SNNoHDfA2kSDbxEnkJct0J6qhG20rgDYALT0TrtPFq8tDHIjmVehPa6tcuSGze1B2
	KRcDEHiINHZ2eyklOdUI11FTjMjpORxRGXe2LLdAGU5015nlCpZ2bEwcqXh0A4HoCLZwPxVMzHb
	svqifXFp5AaAYVnoS1WmflUbEuA+LEWRgOIRL+ip4f5hwkBj3S/bxgcK4LMBgw==
X-Received: by 2002:a17:903:3508:b0:2cc:9179:335 with SMTP id
 d9443c01a7336-2cef12ea089mr45887525ad.8.1784070397005; Tue, 14 Jul 2026
 16:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
 <20260714120042.491712-2-phucduc.bui@gmail.com> <8fff715a-1386-4f2f-b21e-2f5e6a5b97c6@wanadoo.fr>
In-Reply-To: <8fff715a-1386-4f2f-b21e-2f5e6a5b97c6@wanadoo.fr>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 15 Jul 2026 06:06:25 +0700
X-Gm-Features: AUfX_mxyHp85o-voeqtQKqthUl5PsbH5sXWRljBDmkL-JXWCSd1R7pafJbLpYRE
Message-ID: <CAABR9nGK6Y3o3RL7YPTMjeH9-R4Rdb_jjiPQjrakhkZ77YjfoA@mail.gmail.com>
Subject: Re: [PATCH 01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thank you for your review.

>
> Nitpick: could add some () (i.e. snd_soc_register_card()) to match patch
> 9/10.
>
> CJ
>

I'll fix this in the next version.

Best regards,
Phuc
