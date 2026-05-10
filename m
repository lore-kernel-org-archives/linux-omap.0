Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA81AF0BB
	for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778392050; cv=pass; b=rtmIkZkMszCcOYzmDHiTjqjTqi3+6NzjgG784NpJkVguyI66p4Z9zvRn/IIymEhjL2JcoadKyHQ2GBcgL1OegSEVO+zP8MDSMilV6icMitwSTsHvcyqRvAUoT9l+Uyx++xG6BTca84XNwsIGJao9FCb6glithGy1XqUgFEPsRjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778392050; c=relaxed/simple;
	bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avUL/ENwVAkZu54AyK4tL7g8aIO2ObWJ4MfJLkdeifFT/5eyHP95e92mMIY7ZM3Oy/jivwsz7vOG85kmW+e3mbTgaTLfWyMhe93Y31CO60k9Wc44Zpl/Fm0b24iVnL2KG63c+U/t1NGTmd2JM1j94OYmi8rpAsvamIwRirwRX8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKGfaxGJ; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKGfaxGJ"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b4000e51fdso34320186d6.1
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 22:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778392049; cv=none;
        d=google.com; s=arc-20240605;
        b=hpsl2bRlB2mKBEr53aHlRc++iU3aZtxuVEMe1xtQtZ5DdStv0VOt/im3KAr1TIfAVu
         oxnxejrJvLEl98S5qQnahBaOcIdla0eRIm3BazTu5tVlSWxa9HzPVrdNeyS1+mc3xjyV
         0MlWtd/YT8p5Y4p4ixPybRS2btDrAY0YEMD/2MulUpx1OZDKzMXHp/VuGq+bqquoA46x
         9umkkErA3Pcwo06p6849VAW8VxFC0dOlLXAWu5KraSyZyhuTu/4dB6y0nZKxodoSXRkm
         +UVxqZXs7ejM7xJiSCfgNmF8kCxFw1pOXaR3hO/d4HUcovKT1RHaT0XituHaflyQuOid
         Ht9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        fh=FB3oIp7U9BHIF1SDxj0XkBNEeYQ5xxx9+kngcFdExdo=;
        b=gbbkEZCzMQehS7QkmElZKys3uPuacI5Aur5i1HcAQkrxeSScUtDhkMy8LWkkamxeyB
         fgUa68SqmcHwMtNqfcneJ0z+EtHfnd2HtM0OQByDK6c3Ifz0GUQ3Qt5U+KEzDkXZGUFR
         ywsac8BjeYON9qnhRZ13uW3Lat/Y6INeDwQz81HBvpcI2aOHUlSeoFTRKA3vT8z6tWgw
         jl+vjfwrSnLyHa/2C27eOal5UwrsAEKaice3SjTAijBxuxHVKN0HOqX1014Dal60beIT
         nKE/CCtnWzFu1pRn6f9Ai3NJNCpwTu0NmYFjuPmDPvC3itQG3WQrxbfbEmtOUZRiPrxb
         NEbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778392049; x=1778996849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        b=qKGfaxGJbhYs0S5lEnejaL3hohYH49KKOmbLlM2TzCeRllI1GuvOi2dSQy3wS5OAUQ
         GPBJ2znnSy9KYesJDmUTxhCiOk9r1b2NAUTtcXcv5PfUCx/8oud7RnIgappmuQL9/kSe
         2QNZM2ENExnnXj7thy1qsaOVm4KuiPiO/FNgLaVVdB4eYA0QOgqJBkexVGjADSe+YP7L
         durLKqzyJuaAPPIvG3QPvOg6nc4R6tzjVeoIA9mOzY7t1iMnyzh3opAyNWgdH5F5dXSn
         vvirg36h1V8oYs6DzxLOPAMEV9/fz0I50iC8drhWwLnRe6u9x1Ie4maq2JgcqTmLSGL8
         Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778392049; x=1778996849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        b=WSSw+TRhD+lV1wNYAOFZxOdo0nV2bJvoR9pxDRd/wlMRG8iht5gQ9Yhkytk7M7t3R1
         RgD6sBwIJSnZuP0b+7VEZD8rWp8k/Thrhb/YuDZsWzzot8HE8Nqhfnl+vz4RfRSDI64K
         AqePmHaueAte0OVuaNxoo40Hb55b2qHBS97RjDPs39aC6JXqxBgqDqdXdd278xYEL8vS
         vZRh758xpto2BTT3khi0TdG/+zvCywyywZ8LkBA5ACAqJdK6pOBNzza7YWaSQZUBecd/
         L9sjr1NVYdmKnWtGr3hqKSt93zmrSvLG7yCxDjaqkrLDUVE7DgrFD5mdWBS3HS/XQaG7
         vTJg==
X-Forwarded-Encrypted: i=1; AFNElJ82BlKV0hFntVuUUdY110135YminrYehahCZdUJpE0IGEfaa8xDvVT3g2w0YSWTMpoK/QI5a71SqUE/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Vp5ZxX6NEdDj9yryWtES36bNX8H0agRK3+bBDPQJHg5SrNo+
	plaeaf/M5LmmYPsnYgOdA69xW8QjojPIqVvo788FXs2hLMP3KPNJg8h3/g4BMq/2VLNOCYMXZbN
	7i5aWWNXf5gBb+10ZiHzRtCDrGqkC/BA=
X-Gm-Gg: Acq92OH+Q/SjC6fZYxgns5nPuuCUauVwFqVxu4188pHnbGErWLbANG/xxn9RLi0/oUq
	hF2LpzHJ/U54uiKDgUHGezt+xj7ks0DsUGLIDFixCi7ocFmfVFDB2eJy3hwPraRh4hDtsGhXpmO
	E3P8ei/Cb2R66zfbfiGDQ5BSVKKTfxlTcMxDCvkcX5VKtFVRb7Cd57532baImPWBdCsH2FGdymF
	6BtbhG+gxwAHV6htoaTEgak9hum13gyKCI1phUUUf/BiynEs3/Li5Q2AksYEeFgQuyFVqJy9MAG
	bVN/QxCULBhzwZRmXmjMupGn7zrO3iYqVUpKhMdnsA7IXiCZoVgRyAC3tkQpL/0tlYnV
X-Received: by 2002:a05:6214:4a86:b0:8ba:b3b3:971 with SMTP id
 6a1803df08f44-8c1aef0ba80mr77016986d6.32.1778392048684; Sat, 09 May 2026
 22:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510053939.564314-1-enelsonmoore@gmail.com> <20260510053939.564314-3-enelsonmoore@gmail.com>
In-Reply-To: <20260510053939.564314-3-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 22:47:17 -0700
X-Gm-Features: AVHnY4IBeUYn8NsHGeLm2DVNzKo78AU7QjDZBO_n8D3LQ2xwfQvtglASS8pqEw0
Message-ID: <CADkSEUi0U1oKsxZ9YmgG6wh8rc=RK37wUgq-bmA5XUn3aYSuAA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: ti: omap3pandora: update board check to use DT compatible
To: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 10:40=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> ---
> Changes from v1: Fix mistake in commit message and remove Fixes tags -
> machine ID checks still work with DT booting if the bootloader passes
> the ID
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---

I forgot to move my changelog below the --- generated by git
format-patch. Sorry. Could whoever merges this fix that, or should I
resend this patch tomorrow?
