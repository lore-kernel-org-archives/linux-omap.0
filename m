Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A93D349B
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925686; cv=none; b=dsuVuHxrhe8PR5FHgM0dQlAnPAsaj8bmsnysFZQgFXNy3vfrS8kaKlZD2MuMFk05J8aVKvCWvYYPI3O49PmvACkZs8njauYoSJ/HdONmH0YxehfpyaLlaVhRW+JOod7w48/X25E9xUb8xaj73cPzuLaa2Vz4lc+8ytUe07SKGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925686; c=relaxed/simple;
	bh=PLIQNmpARgORTyPtKiscw4UfX4zOOAigpCDT2JYNybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vkv3Csum2OmxouiTCcA5sz9gClgPN/HwdxKr7y/abLh/cfDkZErqaJxe1SrosJj61eUtzUuAbYJKI1eYAWNC7yxRZR02Y7iO+RnW/RgVGEu0U1BOXnSXFaRY1bL172Gkp2YpXSGPKqinaYhbqvZWzZD1Capsg2sfcfscsspDyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLF4kov8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLF4kov8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D51BC2BCB7
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925686;
	bh=PLIQNmpARgORTyPtKiscw4UfX4zOOAigpCDT2JYNybY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=PLF4kov8VHF5Sz3cCLnIzd9CB3vRVzrNjXvudGe6zNM9EioZ5xUNAjtWGfOSMaeay
	 lvq+NQihEbdMoSP9Jiq1NdWLcEhKx0vpVO9lGPcLGB4pqxvKGe/Aak/3Xq2Hbbyn3I
	 9uMMge3POiG3mLoH0PFauIh+4/wXlbhnx0S/DBSgx81OPUwDhJYiCaGEgaalECQ/Re
	 OICBDCGhdAHSQ6zYFduWEAhPkfM9k+NCePHEqCIjsaCSJ4KY1ZfZg9lSij+ytrOd63
	 9ngQGI/xbOH0TpHR2JehTFci96wF/M9JIQb0wCz3HmT4DSc2qVUwu/qiII139nm9JO
	 YaZVg7FnQY3TA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38b3ee785a5so7606071fa.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2026 06:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkRL/BLWivhKmp/M2M3Q9ALgw+f1F92ulVFyd9SvvaEOB0aQk0ywatKqLobZlQ2bkAvRrQDOw9xfH6@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6eG5ZBAIBDzZZlo17bStseJnE1ra7NX3ZVjy7KB6wS7j5aTe
	TAFMH0h4FBlDQkj9o0NrdjV9UEpYpoRktMbQAjmOymEDSUqwxfd0PwvHBo63mcofsq5/twDRmL2
	yeI5thSZVfhjRuMFmS32LmefKRadP2uY=
X-Received: by 2002:a2e:bc20:0:b0:383:789:3c3 with SMTP id 38308e7fff4ca-38be5e6e7ebmr10670061fa.2.1773925684481;
 Thu, 19 Mar 2026 06:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319105947.6237-1-wsa+renesas@sang-engineering.com> <20260319105947.6237-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260319105947.6237-5-wsa+renesas@sang-engineering.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 19 Mar 2026 21:07:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NVc0QD=_Ftwx5LSCQ8n1cEwuX1oMWZgEzowfGf7gMKA@mail.gmail.com>
X-Gm-Features: AaiRm51rluS_yVFu6WIEO2l7ox-ygOi8igmHKgG-QVsILV0f84uRCi8SrIk-dv0
Message-ID: <CAGb2v67NVc0QD=_Ftwx5LSCQ8n1cEwuX1oMWZgEzowfGf7gMKA@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] hwspinlock: add callback to fill private data of
 a hwspinlock
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Wilken Gottwalt <wilken.gottwalt@posteo.net>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 7:00=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> To hide internal core structures from providers, a callback is added to
> the ops which allows to set the 'priv' field of a hwspinlock. It is
> called when a hwspinlock device is registered and, thus, iterated over
> all locks. The register-functions are also extended to pass a data
> pointer to this callback, so it can do necessary calculations for the
> priv field of each hwspinlock. Providers are added only an empty
> placeholder and are converted separately because these changes need
> dedicated reviews.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/locking/hwspinlock.rst     |  3 ++-
>  drivers/hwspinlock/hwspinlock_core.c     | 19 +++++++++++++++----
>  drivers/hwspinlock/hwspinlock_internal.h | 19 +++++++++++--------
>  drivers/hwspinlock/omap_hwspinlock.c     |  2 +-
>  drivers/hwspinlock/qcom_hwspinlock.c     |  2 +-
>  drivers/hwspinlock/sprd_hwspinlock.c     |  2 +-
>  drivers/hwspinlock/stm32_hwspinlock.c    |  2 +-
>  drivers/hwspinlock/sun6i_hwspinlock.c    |  2 +-

Acked-by: Chen-Yu Tsai <wens@kernel.org> # for sun6i
