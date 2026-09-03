Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EE4C6813
	for <linux-omap@vger.kernel.org>; Thu,  3 Sep 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447637; cv=none; b=UB3qV1XoxihOpg+cPmrqB2VHLELXHuA6urMeag9IsLM+YP4C7NF2BaboUCcmSKMQKIh3iV+WCSJZjb9DeyUQqHLitjDK8ckm0xkwF8VGcckMwa6iA85S+EkNrWEG8CZVqyqTd+C6cxw0jzNKsqd6VRTpleLQs5olroXMFzY3L4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447637; c=relaxed/simple;
	bh=rEiGuSHpvriUqLhToDYgt8FFSKdOnEQptXqAy0J5nV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLE8+bsjY+V+c5zyUE9Tql8/zZkSQYghT196gNgOW86M2vRZN+x9pqpPGUxTpIUbMBKPj432Wqr3b/hYAnuv0quDwxRCdbDOPZOdJFFbTA0T3nVIeXZgBdAFVtqdXfpL+gaJCCLg2q10JQ/X52F8uVdBEbHMIvFu7n11Cx3dK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97bf8e907b0so12678241.0
        for <linux-omap@vger.kernel.org>; Thu, 03 Sep 2026 08:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447635; x=1789052435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7IpOefrxKq1W8FoUG8547LazHe9zeJ3Q1wTKXTvt3Y=;
        b=lTgarO+KDKmhET0aCPA/jXFYvBeNs5tvtBbIAqtg6j0DvfoTp8m0NBl1iJ4b7KEPj2
         sNj5oqfau+IUMgZMRT7F3dURjF1X6HX009mYfHmeODGjzjIM3Hmy53uWogYOpKv7Mdj5
         WXT4hW4RUd9Y0gu84CO7mwU4LMbkl0pbFVSbsB/QWTKiutygwczApo9YuodbLav4ZKEb
         t6evCvds5Ul7KBo7RekujQGuGyDon8cfb9iH+iZo8xA3AKet+h34FK3x1mHsap2kQDbm
         5crLNh+x9xLO9rPrOVcsthnhsvLfLg1p6U4+irLHZSfycnYJpemVtj2/Cj4/ojLYfhz1
         D2Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzYF5yikV/GQDlqdjK+OlBTSu7QyVlBQ4/5pjV4k14cVjqrHybLtOuv1+Q6WKCGVW1egxGhhpn6InFB@vger.kernel.org
X-Gm-Message-State: AFuF++krXl0g6rOQ6jNZ8oGJ8SQHmUt9U8eqNpbhQ0LRzO7iZQ5IkgUz
	BNQnje33WWnC7M3hiauFTP3kI5eUS5Pkj/vOKHPqm8SsHcTJzsKYkrmQJGGEnxKKm0s=
X-Gm-Gg: AYBFou2DZjd+xgDlV6Uik+G1dyoEW3fsLujKSeBc3DNy83nKMQVdiqWLMifWrJWlTtL
	4Ukmr6znAV+froVVieijiVnp+mIuxD3X+SXq3TfXlRI/gZPKhhFdyrzd/c+WeSl2n79c18Kixxg
	Lu9uY8Lyv/eZLKxWY5ze+g5QIHfxdGcM1Lz6DNh00wzNAzYJosNdwjfE6vgovRVvsTg1Tie0tRU
	fFlFPjGEx5/FHMPkCg5EJZu4NvjKgyLpzIYk72PZEHIr3AsAcNgSVHeRiS566hesDnisr23xau3
	B7ftsJAO1tjXhtPWEiSgOsfEcz1dMWEtFfUV5tWIw2QJDBmypxDOLlyNY8D8oMoNUbWO/TD2xGP
	mcj7rJh+geCjQQ0b/98bRDGECsDIXTxEfHbgFSw4ceh3gWS/pI1bfnoB//tjDrYf7L+h8jRR3Hz
	BhUHRuqYajhMj5Gp/hPQ1igI6ckaNF/XAMGnvTy44i6o1uwObcv+xBLd4P4qno1+1JlyftUulEK
	L1oTy1EwvfJZCXkFf9k165wWQ==
X-Received: by 2002:a05:6102:b0a:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a1f27745amr4235183137.6.1788447634417;
        Thu, 03 Sep 2026 08:00:34 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9806714fd39sm4751823241.0.2026.09.03.08.00.32
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:00:32 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-977258a75d9so1513174241.3
        for <linux-omap@vger.kernel.org>; Thu, 03 Sep 2026 08:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByA3iFUKIcR0t/gTOtCI3zlEuMjNlPp51++dcoqz+h/ZFaCtFMqoZ09xGAPZhmBrKb7oY4BxRuUJRyA@vger.kernel.org
X-Received: by 2002:a67:e704:0:b0:77c:6bdc:824f with SMTP id
 ada2fe7eead31-78a1f1d4903mr5471476137.1.1788447632007; Thu, 03 Sep 2026
 08:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e481b6de46cecc6ea604ae165272c667274cc621.1788437140.git.geert+renesas@glider.be>
 <abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch>
In-Reply-To: <abec6831-d344-489d-b70c-1e5dd4d43c2d@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 17:00:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV98HRJEy2s824VTnXXDMGcfuMN-s0RFertQ4ymjPyp4w@mail.gmail.com>
X-Gm-Features: AcwNN1XbkTCwkdzzCUI--td_POZtF6rqFVqNEudn1e6PV9_tB5kgdfNf5dSHIDE
Message-ID: <CAMuHMdV98HRJEy2s824VTnXXDMGcfuMN-s0RFertQ4ymjPyp4w@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_mdio: Drop commas after match
 table sentinels
To: Andrew Lunn <andrew@lunn.ch>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-omap@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 3 Sept 2026 at 16:38, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Sep 03, 2026 at 02:06:47PM +0200, Geert Uytterhoeven wrote:
> > It does not make sense to have a comma after a sentinel, as any new
> > elements must be added before the sentinel.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> net-next.

Bummer. I have added a check to my checkpatch wrapper script,
so hopefully this was the last time I made that mistake ;-)

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
