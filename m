Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98B2E6CD5
	for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776629472; cv=none; b=r6Q/9dTISojUZBmlibx4kD5VMyMWLWxmT0htkcnsIgml+3ehwcIPg26mISSRjS10WYgFu7VxJ8252FP3Ormx3lh/efMuTUWb7jNBgl32Qhvx2TemrNfrtOTFwfBLUUtWFkVytvQ20Nbngl9t5uJ0lUmpcf34l8B49VUVyJOACUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776629472; c=relaxed/simple;
	bh=UcBLBDVePmWio9ZZxW8xvAPtwx4gH23Dc5k3bSjMaag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdHy5Atx23+DeCpTp69nkyhSMbvjsDUuME87s/9zxuWqw//JZkWwkTn/ZRQO7Q61Z7fbsk2DEI8YE7xlMgFywC1YXXBSbxAma3UkC3mQ6OLx90UiA0OvA9RZHjtVAY2qIk/pV6UXJAhATChiWatkETFKE5T8HtxRUOuZ0YLRmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRgF9HQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRgF9HQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE206C2BCB6
	for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776629471;
	bh=UcBLBDVePmWio9ZZxW8xvAPtwx4gH23Dc5k3bSjMaag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRgF9HQgFOSXT8N07R5TjXaaBBbTppNSQTHzQwVEn/aSjRc5AClVdKaspIFrddAda
	 A9E37/ZhHBn/MEYHNuHsp3xzsBr0De3l7thc0EWePLXeAVoU01BcMO0vUXKr1YEips
	 V+UpgH0pzlbwXyZ7+9nw+yeKHrSq25SLMjKM34o/S7pTSjNVTZoBnAm1joF1xxg9n8
	 XBcdYGf49fsJIGZFufObHzJNi0KAOHdUx0BNXRHTK2odLkkhZtLW2cXv8QEErmXmpp
	 vBSzh2+U8jtmqAwF+S7m9amwXdla5JS8qcjckJy4cndhX51SwJtyZ/gfaOrYosP0pc
	 Y0iacsJHREsSg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a525aedb24so22497e87.2
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 13:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dXHjMFkKPVWbj58JZzmzLLV3mbrVYc2LdSfyF+0o947tebig5t7nZDHDKP5jRVAHOdmTz5KzqjN4J@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZcFLrdvEdqfRVUbDunWAWuEKWY48cYLh49C7uYmEkEuHN2Kd
	FxXY9DSgycK8NQbsHbB1W/TCJnoNZEzcm9ZJXhkQ8Sjv+Ar2U/F05ToOive1dzdFKkoWnsYa15B
	EF1Sc9LAa07/8WEA1Ox/JZxdqACqtN3E=
X-Received: by 2002:a05:6512:6d0:b0:5a2:b487:b945 with SMTP id
 2adb3069b0e04-5a4172c67afmr3476577e87.18.1776629470575; Sun, 19 Apr 2026
 13:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
In-Reply-To: <20260419161848.825831-1-aaro.koskinen@iki.fi>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:10:57 +0200
X-Gmail-Original-Message-ID: <CAD++jL=YJCPdnLZRCPkVLb6m+ULeywZdzDkwoLzL5J1=Uv1Uvw@mail.gmail.com>
X-Gm-Features: AQROBzDyNzhVlHDZVgQdbAN2C4fg4Fdd9GDDwXUeYl-2FQtPZbTICvEtDlQrjGY
Message-ID: <CAD++jL=YJCPdnLZRCPkVLb6m+ULeywZdzDkwoLzL5J1=Uv1Uvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Input/omap1: fix touchscreen functionality on
 Nokia 770
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 6:21=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:

> Another attempt to make 770 touchscreen work again.
>
> v2: Unrelated fbdev patch dropped (already merged)
>     GPIO setup fixed by deleting the conflicting descriptor.
>
> v1: https://lore.kernel.org/linux-input/20250102181953.1020878-1-aaro.kos=
kinen@iki.fi/
>
> Aaro Koskinen (2):
>   Input: ads7846 - restore half-duplex support
>   Input: ads7846 - fix up the pendown GPIO setup on Nokia 770

Patches look good to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
