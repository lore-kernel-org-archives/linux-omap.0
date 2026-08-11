Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1343E099
	for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450188; cv=none; b=MScunf0PJ2ACoNaWF83Td8KzJ4Nlf3b5AgdYrLt3aw7uAMnLs9phuYGOKteQ0tte8rU5GFCl6B7+ZtTZZoIvbjM32QSERwqDAu4G/UExWtZFl6K3dUcMiM1Au8CRZODYytWXKW6RMF37APCagojQifWaGHCJLBWf+FjdFNSQKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450188; c=relaxed/simple;
	bh=jOz8/RKCdao82EWzssvpPQu6MldBuHaOzLydpj3dJ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbE9xsFzObKB76L8Dq9YHZBDgd8I9l6VmOqjulqZu7qoOdkipgMc53uSG+Wp2KDrpfi/mR/CUh2spJMIG6tEIY2W2+1fHtB7JvImIM0QiDUzVG8T0It8N50ULi/VqI29KJTMG3tbYTc43gUwMFPnBHZ0mFEDsOjhcXot7jo/yF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-76535268562so611816137.3
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2026 05:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450182; x=1787054982;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uoVTJmbd8yKwYcWWlgS08ZgHIJGke3bvkQlHT1fmSY4=;
        b=TuuV0zfzl9GT+bTIGfApfcysUioouRobFa3I2XbEAWtakF+l/K381Qn0jkux+Nk9Pv
         YYaoIAxUHP6/HSAwHW1pYmLtCyi5vc2YxBXbmnYqrifEpdWpeps/nj/SJqYrbhJCOJMA
         bKLvJDLD5ZE87kFco5JJNRtOjVOlem8MIQ5z5YhNN+wp1tBA9gB+yDwuqF8ebgOeQT0L
         rNwRe4G43iaEDbv+rT6VkgnNoBAZhr26U6BGFzFYqsRodS1hU/G7mazlguowgfTfyO0Z
         bnJjINKNJfPodp50uZ8qslTuEDhaQZT5xnqjB3B0jnLVwaYuTYhlp7sbmGoSZ6LKzcwS
         maUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq51kn/getxXKc/XQ+3lhMwtri3/8aIuDFOhihKYDCvGucnzdVkVHqZinp3vPPrSBXvKh8RrFEEul0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OI/echsOrXCaTeprgGaPpPdb3kP61H0qR28OEKk6uemAUYH5
	ADFiv2KMOn+6uMNtoZi7w+HSxk7EejssYdFG+GvKc0qm1XNlQ0XjvZptVQciXtmr
X-Gm-Gg: AR+sD12mBJJ8sMsU0x6hdeitmy2fC2jwbqW1b+f4NmUvpY2JA0oh1h/OFpcivyMdWSS
	NHUvnSIyHnbXOvog3tM+Ry92WcY2Bp6lXxBdbC3jQgpN2iCD3CGolmTHga/G+J7pvhTG86Tb9sY
	WNFvhlgOAN5H/nPTcytCDu/urouG+gpTVR40E/xjNhDWJlmtjUvtNLgGIpG+h2SW7IznEK/oNbS
	2SpruaQBl/Vl1uSQaM2TEjrBLD59IZPHwyJtYp5NqKjfwC1O9SAHZXH25rPoWhy3n6GDevfyrQP
	+SxMvLbk+skgVctt0MO+ySh3tWTyUyQAVnl0lF4O9OcVGojBIw99yMY9W5NQPGG1NKbgH7+GW46
	DhdG92bSqRNv/dwKMPXjTJNYNHPIN6O9P0zZuJTAGvdo0uaRuPutJgVqOwjNbshv6kqNw2HlsYB
	wRYDt5mnAugV09lyz/BXfq70OXMPl6VwoREJ/zjw/bnL9VGjBj7au6f+pAYPb7iuHz+1mYqe1x1
	5LClrIARHQr7/ON/3E5QcZAdg==
X-Received: by 2002:a05:6102:3753:b0:738:84c:6b3 with SMTP id ada2fe7eead31-76b54e7ebabmr632494137.3.1786450182181;
        Tue, 11 Aug 2026 05:09:42 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c451bdd296sm311916e0c.2.2026.08.11.05.09.35
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:09:37 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-76535268562so611777137.3
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2026 05:09:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqWwV5FsXLrzJGqpgNb6SDlRFhTr41DGhMbzSI+Cnv9SaR7t6Olx4aHD5lo0nNL11wwXyBzCZZxZIig@vger.kernel.org
X-Received: by 2002:a05:6102:15a3:b0:738:cdc6:f59a with SMTP id
 ada2fe7eead31-76b573b9e9amr650405137.9.1786450174738; Tue, 11 Aug 2026
 05:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
 <20260724-clk-provider-simple-clean-v2-3-56f306156d25@baylibre.com>
In-Reply-To: <20260724-clk-provider-simple-clean-v2-3-56f306156d25@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 14:09:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW15QrpUhbra1Jg1_8rQWf8CE5TQiE5SUAsqvz5YmEwpQ@mail.gmail.com>
X-Gm-Features: AUfX_mxAADqzKHeccKVpUAgUM-G2gOwUTpW15Dago95Bl-ey6AOZpFlGkzHgs7Y
Message-ID: <CAMuHMdW15QrpUhbra1Jg1_8rQWf8CE5TQiE5SUAsqvz5YmEwpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] clk: renesas: clean-up simple provider misuse of
 the consumer API
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bjorn Andersson <andersson@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jul 2026 at 11:04, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
>
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist.
>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
