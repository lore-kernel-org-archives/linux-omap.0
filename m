Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8431355B
	for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124054; cv=none; b=j1VdZFiiYeF3jkH8lRWEGcWtt5Wmgmwv8X31ANDiejfGpOTDRnSx/tTIpI1Eez4bwtZ0jMiGaZxrU8hVOGW7Gyf7CgFfQ7xS50Xnh2dywsh5TM8DAS2WnSvlK4O42E/aO9lDn2pgKO4pZAoyS9Qj/4SiiIV9I0Q4a2GOK6Hryuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124054; c=relaxed/simple;
	bh=CE68Rb9kC/HDA2cBAQQX3Im6WA6S7tlqNN172Y2yO0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZysVByyQg0nNTmrMhx4Z7lWTp3z6vDaNiPEsokhvZHXHV+byZoATxMabyUrw2V7rqJbX0fxnNsvWTNZFOCoxZHen0TKazaxqxpO++ZON+uVCeD2al0Cwbn+alnHb+/4dcwE+a+BmRbkw87kSSrnrqivkvEJcjhEOp9BobBF351I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF0chKqZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF0chKqZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f75f7172so38348935e9.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2026 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784124051; x=1784728851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BArhhnpdI/Cv8HoI1hRJgRyqIoDXROOU23KIbFFyDpY=;
        b=NF0chKqZXNAYbYItWEXZ3DZExK7A5RJqN7QOeYBSh12Ajs+OHrbRqoa1TgPTK7Z6VQ
         K6tVtB0AbXfJH+51zDu1y9qZ7mLX7JLvycymiqvgE+wweAekdS5hV7L+y+XV5xNxrcqU
         WecjiUe0oNE4WIc1JN3DWs4nj61fgiXuRzxBFEeMEIYPwM5b+2FRIsGn3m1YLBJfDuXH
         BsHkkCvRRDkE7bO3igyluWt+nH1OC0LqBUis8g5HJLF92lA9rtTkwENQX2cydE6pFITG
         NWXeZIV77CI52qRVolSjJHWbrVz2GuWEotUEPB+7PG+7d1beyGhYNHcG3cPP2lYlMQqi
         c6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124051; x=1784728851;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BArhhnpdI/Cv8HoI1hRJgRyqIoDXROOU23KIbFFyDpY=;
        b=OTZ7wWTNxeUZHEbaqjdRJScBVmkXFzEtug+IaSZ9V9ZIABIsEFJIJ7qr44G/7nKOLs
         M4+ms+IUVSrNjXpJuEmGkuXPHLfq83QrlNORhVPJqI9Q0JB+2a579QcW3kXxGAJYwMf3
         9ARfyN5z7EcHX9Vy8C3t2r6DBvE8jI4wJvEfiquINF8rtgBma+O1DrEbluTS29te5RB/
         /XTIR9kGhCNooS9uoHmWBRrxHROZww7yt++I+4oNLqpuFOl/rAa3WBZdNNPJckSXIBee
         H72Voooq+xnGmdq6rKkplxLS4ZQivRZ+KIYsrYyRxy2Eb2zDeeh0wh9vcwN8u/WGX6k8
         8Zxw==
X-Forwarded-Encrypted: i=1; AHgh+RpZf0cm4f8pel0HfRQ6UnT6ugZgvZlsEoe4Pp7lIo4JzJ8vfDLZLaYHYXpoP2yVJviCLYw9nuiI/mRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9syAt1AGoMRLm0wWOspXQyXYqtcqsL/H0zAGf94+LKd7AFV8
	TZBRZICefr+TG41m6tqp/QL0nc0h8gbUHmJo03b5rE52TOjkhWP3ohQo
X-Gm-Gg: AfdE7cnZknDQZiQ31FCr3YK+2iAxECv25Nn1EOxIdgOPuGxmgbVK8IZw0/keHaenAqd
	kFJZ8fx1Q4dU7HJ5FOkCG2fqPc/dmShCOY3bIevMR+ZMpG8j8lODBE+1DJgskq0Q9/p7fGX7L+h
	/Kq0zz+xTXPE50JrmRPtWbSXM5smLTP+Gow4l/cS0JmfdA2kP3kGXJrHa6rKtWolQugmWZ3G8Zt
	9xSV39CyZSSEyI3uanG2V00ALz1gQKXjONOLhNS7tPvHDbnY9MTaHh8XUXIggkR3epbmvKwkXO/
	eO8X5bZz5yMdY+xHl25ouqkvOasJQuH+pMNcVS0hu5vEwV9eWlwXXRmKoqEU/liAbQcGbri6Ro6
	Wz6pI4zbGhYfQmNnCigWnGxIj+ZoUjkFg2n0/OTqFFdK6R2U8EiWPreevXh1Q8Uws1MMtBOHI4l
	Yq3Egh1wSj50mYgj9+MOM7JTezDGblvrU4V/lGt4eSTYbMolbMkEVP8QCF16rwxNy1jz5Dzui9m
	kMkBgpGFI1MJ7DV8GttwcIYkOfMXh4SWqanhLdxDo9AUq18aw5TY37qbw5SmUzNWc0GTx5Arug6
	GHsHiuF4k4u9lYXKY+6k4NUXkKVX5phhoSuaMKP3lxYuLm/XRnekZtFrhftm0JSt5ZRW47dyKJK
	7MUXO+nOllaAwmcWN0xhAMoI=
X-Received: by 2002:a05:600c:6211:b0:495:3a21:4e5d with SMTP id 5b1f17b1804b1-4953c001211mr34667645e9.0.1784124050314;
        Wed, 15 Jul 2026 07:00:50 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2edd6fsm150750035e9.11.2026.07.15.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:00:50 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:00:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, William Breathitt Gray
 <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>, David Lechner
 <david@lechnology.com>, linux-iio@vger.kernel.org (open list:COUNTER
 SUBSYSTEM), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), linux-omap@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP)
 DRIVER)
Subject: Re: [PATCH 0/3] counter: Remove redundant error messages on IRQ
 request failure
Message-ID: <20260715160048.00000737@gmail.com>
In-Reply-To: <20260715135030.326290-1-panchuang@vivo.com>
References: <20260715135030.326290-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 21:50:27 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in counter drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.
> 
> Pan Chuang (3):
>   counter: stm32-timer-cnt: Remove redundant dev_err()
>   counter: ti-ecap-capture: Remove redundant dev_err_probe()
>   counter: ti-eqep: Remove redundant dev_err_probe()
> 
>  drivers/counter/stm32-timer-cnt.c | 10 ++--------
>  drivers/counter/ti-ecap-capture.c |  2 +-
>  drivers/counter/ti-eqep.c         |  2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 

LGTM.

-- 
Kind regards

CJD
