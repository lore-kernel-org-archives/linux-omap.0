Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE23A8723
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041490; cv=pass; b=nHMX8GlPoJKh9lGZlWMQQsFzn4Ul8trbuj6ygAqMvnnuryaBZJhrty8lwZVSVBEXKpOvKH1GMiRlJ/HLqOFOi4LOOz0gyNyE6opZ8vgrzF3dMHYrXWpg5551IxtRLWU6MnTDmeWXygYGq88cvlf5araoOPUaQS0+d9/m1uZ3iYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041490; c=relaxed/simple;
	bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYDc5OYCBS39u22Zm5U3mUs1yoONRTyYY7zfzklfJirk5wrj27gPjNOOrVmrqXtgOej3pjfDUzUmMUGrh0LpI9xxEHl41N8yw9cRJPWylbau4l1zULFeB6ZTiZh3lWujVU+bh4Uet8vGOZ9KIsrlwOsFpxoBVhvgEGXtvUSGr9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPaWnZXB; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPaWnZXB"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8028fa6039so8916318a12.2
        for <linux-omap@vger.kernel.org>; Fri, 29 May 2026 00:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780041489; cv=none;
        d=google.com; s=arc-20240605;
        b=Gyg4bJrR5x2tlUHF1UpchFcu/WOC0zGcgccXNnvB0EtFTdI6H7m1dlYRRxijbSzG1F
         U8A5hMrh/ZUgmVVv9kS4P3MerQL6/6aHVxAwieIBguEhcyUGeZlc/3Shjp4oy5dsm4Rn
         Lee2cHDn5NJQbhAic4dhflsys1qQxRnm9e30q9fPcLonrdDs2lJCb7q/muQJBA69Bo13
         mQnec4BOwyhF22mitKLyV74hB5GMKGpK0JMafY98DUD+FIuv7tKwXKCHDmmmdeJWdKkW
         PpjJorNGoWjPnnnWFuFqs1y3pzyiuRBgxvKfU+glyyXjls1welaj+BQEU6lills8a5bD
         w9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        fh=f9OGAEf4N5/2JmWJvDdGvOjOaieVgiIiP9rUETXVRCM=;
        b=IarRAceurABabckT6yqnDbxR9Zq1qa8seGKHuEwGipGhk4CcurfRveZ3w9ovjTWfRJ
         FZ7qqjCV/MWsFeNaa0GvE6YhbLaqHkwOKMF2kSSV7+mciXDXXRTvxv63SjWTVX2gfscH
         wUzA2eFc4bCJJJEhk6zsxbGGbM3i09BMClGM9/T76bhS4Fq9hAOv8AOdnaTcJm4jyHZ+
         FzB4nkKoc8pLLfwioB08KQSQprsjTYhyTc3rkeNxwQK/Mx9VRj1E48UgRMwAsuUd02Q1
         l628ms9YDquvG7JydiHy4qIM/REsfiVX2vuc/aZPU3k9xMviNWiPrsw6S7dv1S0zJFbT
         3OlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041489; x=1780646289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        b=PPaWnZXB0K3VGnxiNC9w7SWFiMeR6BIFztop+8eTkqkHbXHlhHH+nnag0CH6ginHte
         n3xY+4Am3HSGAYVycyefoA+c6VANgtdmhPc67qqPkSGi4gkU73xnZBOeZQ+DeuzM+Foy
         P9KjQgPN8ah/Gkr0h58xM1HlR/THfteyfo9w4Kjg1IKndSY57ALNxrDb7n9sQPVEFKzZ
         O0SauuBMiBemVppr1gf8OHJIHv5NyDPtkkpwtkV53eFWgGLp4PseFhbPO9x0zmcSPICP
         gdQgzMPAtjY6C7S5XRC7FSwOy62yT4G5IWHW7qFA6NGlsnj+cMOOICsylqeVBHeWmbcT
         5/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041489; x=1780646289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0KniOszvMfa6XS1uuRuomxsbQoyEQFI7eLxL2NmUQs=;
        b=nC+yztzeIf+BWaUAJ5CLcjJvY6B73+0ANTCYKSXcXxYs0s6Ou+B0OMgyracKz1HmNp
         NJDzQrqRr3yykCfJBwnb3OaUl5CiucRavf/Y5Y3RtFzZ8WqT2Q7N/2ukxsqWutzfdRuT
         A50Tz/gC8tbb1SDY89/AIv6hqP/gFwfoDBp0GEWw2OvnEJnK7nmkDDM2mO3vyDnRMLuL
         eXH9czfvvJOkwi3L0BFpFpojEStwi5zNtCgdX9DTr//2upDDJuvv3CxWU9YfrHDPbAtq
         JgMhpWCuXghU4h0luAYIkRpcKqnQIoMIJW9f4ttESpZNC5EOpriKdiYHlwGbQ+rIe+Ud
         hgBA==
X-Forwarded-Encrypted: i=1; AFNElJ+rdjd5wexHYBteZQ3P1rCRySU6U89ou3nK/fiPDAMJNuKi4sMVaYXTmTB2e+NqAUGeN+mEIOq8/F0A@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrk+elybfvH0qKsRZjlzx2zd7iIa4n1ontRSRAW8KRECkrFqp
	iOVvWYDaJ8vThNwUsdcEk8D43GC3S0MXHimW1b1uCNDT2H/+1DrvqiI5LsDIYCZdDeAcnrU6umF
	ULet/rzfZPpgeRaYo3Bm+J9WlZdeVW5M=
X-Gm-Gg: Acq92OEmbqCGnQ1wHHzhObNf6SCxpo/jDmvFK11BKmfgB8DXeSeSsY3AA2fT9Dq7kMn
	PmuZ5iKk4tQiwjONzfjXW7DF/7tvowB7/FtW3gDzE5jPjm8r3hmNibIN3df/2hQwUejXCBfaj5p
	7d6t6cWD1jyzMNbbc+kVXcXv4EvQNTg4/IEdvnTzyQxiNxhlXnGKXubUrnzXyS8VLYmM+Ayi1Za
	+15/6Mxk+ippd4ZMXgCR0JavvhEjKq33mu7c4IV4eH36bmBqwpwcBxGF514Z8EU98BYwrAKX+P9
	jYaSEUi9zfBn48JTJ7Y=
X-Received: by 2002:a17:90b:3e82:b0:368:341a:a925 with SMTP id
 98e67ed59e1d1-36bbcfaecf2mr2292215a91.23.1780041488492; Fri, 29 May 2026
 00:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com> <b8f7581e9311d5579447304ac4f2d557b29e4f9d.1779893336.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <b8f7581e9311d5579447304ac4f2d557b29e4f9d.1779893336.git.u.kleine-koenig@baylibre.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Fri, 29 May 2026 10:57:57 +0300
X-Gm-Features: AVHnY4LQ-jWF2c7_aSBtntPbH41tJ-A1RaFPwn1TJSq1AkOwWmb4Y_coE3Xjxe0
Message-ID: <CANhJrGP7vSUUd0DSsyqgE+CyLp4mgsO0zkb0JexbER7W50nTDw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Use named initializers for
 platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ke 27.5.2026 klo 17.57 Uwe Kleine-K=C3=B6nig (The Capable Hub)
(u.kleine-koenig@baylibre.com) kirjoitti:
>
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous unit.
>
> While touching these arrays unify spacing and usage of commas.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
