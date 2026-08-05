Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E93932C5
	for <linux-omap@vger.kernel.org>; Wed,  5 Aug 2026 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900273; cv=pass; b=nVJW9DsaGqrJKL1q5EaKyGxFxZ+iFKVK6c9l8hfF00I9ejOhklvzmh50k5cKU7ffm1t8q8djSlwUQzkGZmN6IT7I0evMRI7OLO3UWGezGWXFd3WF9f5tbQeUUJJLCAY5yL0RUaPHLs/AmlkbSQO9JLX2s0cLwiS5j2ty3a7gS4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900273; c=relaxed/simple;
	bh=kzHUs4aFlrfw29jj/2OPq7Ny3j2bosxRBn0wvjn9Hpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=untOqmWKuIAYqlQ6PbKCRbqdlvX4O6v+QrALMQQB17kHdVpFXcbouHb4tttTvvcBENME4aTaK47BwMMbgvthlpZlNztCBB9gXH48rgwtLHh0P04ssYRtAi6rMMPUX1aFfFecJA4JR3vOQhOl9opU1Tj8yuyWpNa8JR7OBDp3/wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyRttAO6; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyRttAO6"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso622769b3a.2
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 20:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785900267; cv=none;
        d=google.com; s=arc-20260327;
        b=cfO7w3z0KQ4fLOaKn6fYSx34P1jqctTt2pGZzAhLdzHTFnJbHi4PbkHMJHmXK2j2Nz
         o8szkKi93Es+qNZQkLDMLSTnD/bUoTXfzF4x/YGJtgTFiabgb2JXL6aKacRdAaSHwLpt
         h56leoVMI5AU0RoqlN+BLVKKL6qP0gO09pZRG9Ty1NUvxFdOHB4+QvccgJIYY445HJqp
         6hKl/E7nvwhwQ7hWvQHm+q8dC04Ik+g7WGwGkLlWogsJ3LT2nrue5dR66LyxGk1JRkp9
         oiza1UGiIKVk+i8/0tCqjk9lxeqwZuYnpz4P2ZQ3dsH4f6Epm9ZhjNHlOk4oJpjgpKX+
         jG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kzHUs4aFlrfw29jj/2OPq7Ny3j2bosxRBn0wvjn9Hpk=;
        fh=/+UspNPTv7d9G2Jzo97VKAG8RR9azoO5JFR2hLjTNQI=;
        b=Npjr12qmbsqMZgD6jagmutWPMQaWizyYQ4Uwk2esN5qoo2XbJlozjGq1lPUkJ6Wd7p
         2X63iWWa2LwAwQxpoxAImNUAm4wIlohulL+FF4aSPzCpcipQNKL+dZNDG7SEa2XnV95M
         wVs4XAtweemj6zM5/EUs1pfeOPxGrVq6fFrPop7o6SGGukzNgAVAxv95eVSpCSwuLR0G
         BdepCmeQLp28MkTnRcMVFDbF//Nbz+b8IsSF/Tq5on+AKehsB6JUU61Yu6MOedF49bQm
         T0T9ak6RkokKQR1M+TBsC0EjZPk7wGi8rj2mEpXGfqRawWVYfbrn/pOId1T5aEwmO9cG
         c/qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785900267; x=1786505067; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kzHUs4aFlrfw29jj/2OPq7Ny3j2bosxRBn0wvjn9Hpk=;
        b=AyRttAO6e4gndq0MVbbLHU8Ks6ZRK95Vw+FMrYpXYSbxtGpM17KMrlKONRbXtryPM8
         2EcIfVcfJ2jVV8d9TIosMfnvgou1tybWRM/ZSwfijFbnnoEU8rC5iARtVxOJKiTcdvFx
         U3sYpIR2WXTx28KoKxoCcLwkbRwfmTRmeRmylxBLJEYqm5oEDqq9WVTbMerVzEvy5uct
         QsQ9ZBD69SIYYVxKrTKNkj1xDkrXJujcRagIWNOvOhxZVjnODkpVFkqPhm+NBIP4XvB+
         jCKOzCZLv5x+ERN6KoWVz3JmyPjZ/qZ+yBKbCi4S8pLSLqgSbJKOowjo5sop8C7/bW6R
         o0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785900267; x=1786505067;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kzHUs4aFlrfw29jj/2OPq7Ny3j2bosxRBn0wvjn9Hpk=;
        b=jOjFDLwe0n7aWG4XMN7j9+bp9fRq8hCMGrXVZgoWR56dN+/0Qqle31KPScZ61VXs1B
         SbRWJZozvt0oi51YPJ3lEgy8YhZUGUAicerQM7hjrVIUtvbq7vyTq89sIKulPRaGPmTv
         1W3H7QHH5vWHYgoo9ecrapwCz0v/8rv9tW+P4I5PySbMNbGcGvdXw6B93q4/1WNxFU/F
         e60KzkF1pzuWZ4SD6U1WHxDbsFOxZf/GsfW77Qdj3yQcUoBZtZ4Kiowmd/JG5pABoPCn
         3/pkwfTOvxBv4/vEiTnFE6Fxo9knxX3qA8c++oJDtZgeQ0H/b3iGRbLPpogun+rgNDwo
         95LA==
X-Forwarded-Encrypted: i=1; AHgh+Rrmrs6vk7DGjbYsXjqbwuRiNvynWgf+Wmk3+ex5BSvWySW5ZAe6I98uvnrpYiVtCTsX9vJXP/nw7i1K@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJLxRI+d6vQ/rAUVZlg0r/pI/vHQEOUMY3YCggR42AFwOH0Uo
	MG/+E4QQPcgYVaF1MMdP5lV+2j9ZmE9gKqjm+gIHB/C/3TtupsAI6M/iUA/muBHipVW6sV7tKgj
	hi5Z0qfda68kjEOpAn+5wpZUhpxkxi3s=
X-Gm-Gg: AR+sD11O/cjTC8c6PfxBaXe/xLx6sYLF0gBKlDMUQsIXdVc6gOubk4R6Qb0m15ZR8z0
	YYVbi8U/MbvHdVGpFh45QKDqkYjTIrGDlW9DrhfM6brnITlE501H75CENKEe8Xo3aNDaWu0I3ei
	95oKfD5Hry54gInU4cIYonNQCzngGH1c+BL2cDRcWa1GMyLY7XU8Rq20AfTZTHky/QfkFwAbX+x
	E7b4yHjzhov41VPk+4h+DmgGIwbvqxcrxTw6DPTnApCZslEz+52WtNXRZ9TYjUf1XbclWaT8zdB
	6IAQHAdpOzwOn7zjiO2x13fsZloF7CKOYksC62GhQjC0p/fmwDrhGZW38w4rprPb8/rZ7Uorkfv
	1zQgQrmwJskkEey8X0KxvqoDuUy25aGRRukNlSxF+fsXnx4qNyy7EUJVw
X-Received: by 2002:a05:6a00:c95:b0:845:3033:6cb7 with SMTP id
 d2e1a72fcca58-84f2dfc8ec7mr2949970b3a.9.1785900266722; Tue, 04 Aug 2026
 20:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
 <20260714120042.491712-9-phucduc.bui@gmail.com> <20260804193542.3a83d4c3@kemnade.info>
In-Reply-To: <20260804193542.3a83d4c3@kemnade.info>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 5 Aug 2026 10:24:13 +0700
X-Gm-Features: AUfX_mzxWGTQnXbJqsCTv5UKdmfzTCF4sry8IO68g78FicqfF5OshtP5CK9wMR0
Message-ID: <CAABR9nFc-7HnB_4FKXGaRzA=SuGCy1dT=vWUn+Sjq62BqLT7WQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] ASoC: ti: omap-twl4030: Return the original error code
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

Thanks for the review.

> The error message seems that is wants to catch a non-existant property.
> snd_soc_of_parse_card_name() seems to ignore that error. Which is then
> really catched by devm_snd_soc_register_card(). It would be good to
> point out the error explicitely, so probably printing that error message
> on if (!card->name)
>

You're right, I can't be sure what the original author's intent was here.
But as you pointed out, we do need to also check for if (!card->name),
since snd_soc_of_parse_card_name() silently ignores a missing property
and only returns an error for other cases.

This patch has already been merged, so I'll send a separate patch
to address this.

Best regards,
Phuc
