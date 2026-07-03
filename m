Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB12FE0F
	for <linux-omap@vger.kernel.org>; Fri,  3 Jul 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112685; cv=none; b=MsMobGuzWLF6qN9H4khVBw6rlo77latX52KsYnnIIth1kpGDsoYeSJm9DsvffKgyHFCh6lpq1pIeWdvsxJjW6hPj+yu2gaAGtXh8tIJ/tktMFnFkGvnTxFmZO9bnmtYyZ2uBKyj2cGdZ+J3jsVDwQgkEdHpMoL+AJ1CJJe0RvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112685; c=relaxed/simple;
	bh=TEismEukrc5he8i/ANzlclwqKUU39GroifuaymWI34s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZu29LUGShZnHh9SsjuqCD51ERSCuQ/7FS1ovUjIKTnpyzWWgjAiAiYS6b413acJ4Qba45yOPTMmrMiSEep7oMGpHz3VPss4vQdwcHUtxiVcv/joC1IVMcADyuBgokGlCYxJBtTdsSGN6DSZL8X3gaMha/YBCbbVFOw3uDBjoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3/VQwin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3/VQwin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B61F00A3F
	for <linux-omap@vger.kernel.org>; Fri,  3 Jul 2026 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112684;
	bh=xWcBqU+ZcCLNHJJGa428QRtsa/t/TQLn1rK/qQI176E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j3/VQwinBjdgOnq3NrA/wXbUM61997sNxKkEvoUhq1FDD7AMG8iwqaaqy460q8MRH
	 OhIIzgq38VY2kvrHO9ZMVWS57zDo7OOp5eMfZIee5z3Fkomr4Agdeu4SDeQ0HZ1Pud
	 tJcOU7KwkG7z/zqV2pjLPRPX5rlSwCMfgaMa9Vy4pR48xRQS3EpwC4hMYGGa/sxgv5
	 +iHoqQjC3HDwjm2CItfEzcSXzyxcn8Qsbp+/XunEdMlTBXy1BwOBKt/5A6F8karTRJ
	 VShqR+7bvxu2niMXkF2r51ERzX3UIxpfxs+f5q1N2SElidFfjOBrBYaRXcsqagUJVx
	 WV7b0DVqyqb2Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aebba706b3so914413e87.0
        for <linux-omap@vger.kernel.org>; Fri, 03 Jul 2026 14:04:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RokJilt+SIF/1nU9fD1oU88JwojRtcnglnkLFW0T0Jwy3nF+cvdMEt87fvMYEjOIFPW2/Q0HlGFTSDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwUymm7/v5MUyopgp91rXOAw9AHjYEnBgctyTveErwEkWIUjo
	ElTr6tWK8i84Sxrld+RV7o267xPbyoqqMFtqIfGZobqxaRrxYC1W9YCOA59/QE00/MtDbQyitlB
	J4nKD1ojetaLl+rM92nK3PZEs6WQPfUI=
X-Received: by 2002:a05:6512:6411:b0:5ae:b981:3390 with SMTP id
 2adb3069b0e04-5aed508f6b3mr72582e87.13.1783112682973; Fri, 03 Jul 2026
 14:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-palmas-getdirection-v1-1-046c155961c4@kemnade.info>
In-Reply-To: <20260703-palmas-getdirection-v1-1-046c155961c4@kemnade.info>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 23:04:30 +0200
X-Gmail-Original-Message-ID: <CAD++jL=XhJc0TDJjG=rOT-TOH-ED4OBbVfcQdBb+R-b7i_HMUw@mail.gmail.com>
X-Gm-Features: AVVi8CcLAvXCg2XYAadz5UQ5l_9Y6OCJgP89EyBNFQjHzoJL9eg7rMuBdH1b-hU
Message-ID: <CAD++jL=XhJc0TDJjG=rOT-TOH-ED4OBbVfcQdBb+R-b7i_HMUw@mail.gmail.com>
Subject: Re: [PATCH] gpios: palmas: add get_direction op
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 7:21=E2=80=AFAM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:

> Accessing debug/gpio is quite noisy without a get_direction()
> implementation.  To calm that down add an implementation.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
