Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5F2F8BF0
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344758; cv=pass; b=WjOnih/keEXD4UCub1juHxzFGEMaHfwqTSPeiFV+Egh8Ch9cwrVbtKxe6+9X0zde8g0/vkT1DBYCeAJ4XGbqoJ2MA183twV//+9Fs/6wgffaMktvUxXG/zUE429bnPIKAAAmwzULf6hGJHEOp5h2eFF6LI9VAl+v6N3+xlP6eqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344758; c=relaxed/simple;
	bh=OjvQAKtsddCwvtPj5IUL1zdvC6FgIzquAG4/cEYySIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSEUSuCyR1A/XuJpnCysWu4p9fxUhkAljRUex5/kekWngX0wlvGUoQpNdG4nilWfrOkYA3wgHEERTo/ozPy72CzGiTyzM2Uzg2+HwFSSRVrFAd5EGM7MzhXJyRRZo1zfbbAA2QLuSZvpbHtAxI32QceWloeGcFY9gxoBOys9RJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9+dmCMW; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9+dmCMW"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so21955226d6.1
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 09:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778344755; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwxvmnxDmIF8YOBcd6oZ0Pn/i8WrrVu+iUxoemsO4nxdzJ75hRS5456nq0eF/x9yB7
         8PFWwxG79IyMteIgWqRrdZueiYaOju924bfiXedKY7zbDkGMdd6lr5UmCB0WoppjuTQk
         Yt2mHse3As66XG3IQknwKAl3Ge9JPEt/GowN7sZbz9iHBwzb8Gq1PIN9ZyXTOWXt3xgF
         1IGBSXZ6IPeDwG4YVE/uYwXm7WSuFfUylMrFfHEC/mEBVh1YLb0e8YleySlSs6Oi2TAX
         any5mlb/oysdzz9dHI3TafjgvrPPtEyPBuyB7izGkiHcYbdgnXBBMK18lfeciCxFbhXZ
         fgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjvQAKtsddCwvtPj5IUL1zdvC6FgIzquAG4/cEYySIc=;
        fh=LdfGoKdYyZGNn2Ye5aSTFOw7PlFLcwHjVxZeT1BEN9Y=;
        b=c4AZYSmK6QqGx6HgJW2u3PB6P1f3jLtWqxEBkdDlOCzwsBxBpErcoRZoHM+APznDc4
         B1BTMsY4YSKC1RvnM8WEucBRJAyqo7CiWMfAskqTjpCl25C9KmXpNaYcEs1CYho32ENI
         9qc1xL1RaeY1XYMMeYwCSip8xL7AbN6UgdEUkNtBAfMSeDQQ+FKc3IgTqvUv8Bs3pOIs
         xnFwLXSohZOVBTz7A4uLnwjluxYbqN1An0+C0x+/nLzDUnAlY6iilg4wd5gER2h/HJfh
         tjqiSURzcgsMBQRwK8dvJ5ikiVDaUF5pGhHw892mKLf9WtPA378mIIGQrir74+zcat5f
         ypXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778344755; x=1778949555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjvQAKtsddCwvtPj5IUL1zdvC6FgIzquAG4/cEYySIc=;
        b=O9+dmCMWxa/R8950KMHl7MdFG6lJJc58j1zYIyOdxEIMPxTQB9PFckiEp6FcceQZiR
         1Ec/QMXo9OBxb65byqyfzUcFlNChgNBYfr7uwfjRb5Reiqo0D26R/WzPN8PqQ3j7y/yq
         SM01v2IBwd4Df0t0Wwdv1IP/IRatwwWSdSZ+1cM2f4tsF7K55FRN9I8VrwYS0ROHfnhc
         f+M9KR1gWxraPi3+PLL1Fk1YOanrBprJRF1E3kVPkQ21f1wkoHjcW26G7e4ms9B3QB4K
         0vCZpOgkJeRBQsExAko3KnSE2ye/1vE5ZjXT/L9hoVc/VKaoJ9CZ44//QddCQEHDdKlU
         GpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778344755; x=1778949555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjvQAKtsddCwvtPj5IUL1zdvC6FgIzquAG4/cEYySIc=;
        b=El3GSAIg4VcSoYl8+KUeOAoxc4hfuIqdUuleb0IdkOn+sHEABTEZlN9PFlTzlXnssi
         GyZhOTFDMH3odVqX5f8JN3NRA8MsKMClS0Hj4c1g1KRyZp0v0kmSYYoAHjbL7AuacR0h
         oyujO7BjRtbSRu9QH+QHBE942eHtwMUBJyRmQtTiU1x0qaUiWhBoeJ4m6DN27owzc4LI
         soxVra2qnX3jEtfrWBcfajaKyqV9rmtOoniaL/lXjLlYxkUdImhPKDF4nWL4akzBWYQF
         Hn8GC5NsQ0V5mvrYbfnQnc3/VsaQ3/PtgaiXLx+VQvOs0OiLIU5QNqIw+NapfOzGJ15W
         YwPg==
X-Forwarded-Encrypted: i=1; AFNElJ+ROPCMYb25+z7GBhY4Gxm/96gd+EK5Yc9ea+SNFlbMc6bMk6NAzqhjoh7NzBd957z17TUjLA+ZZT7M@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZa7ev5OrSh5xDns1ifLGHadgT4z8s3xUEW9XhFj3Y9BjvrUg
	fueWd9LR2uy9qrkch63coD1KrKilfW6Aw7tbL9im5OkrEOE8+2bTssnikXLbtCtZYCilPvr612d
	BTSV10CA3hAox2/adB+loayw8beCjtF4=
X-Gm-Gg: Acq92OHUYuKwZBE86rcgzxBGMO761zIH/k4ZRngQXr3S2YnOmaSi6/XDUOihyWN4Pql
	8tHWeKJr+l4SbiOiECvNpCjRLK6tOUGm6adiGN2+ePXdw7dK+axun/TscDt2y1jmPeiHY0JtSr9
	JVGtb+keymSqe5/i7EovmzXqZ4kGhnKs+xlBdgoF/M5+ZLIgaffao1w1Qtcfmw+7e/9LjdAaxfQ
	kTr7Hvxg4WndeeHC71WxyPE/JwXAmHGG9vrc2v497plAs2BmqDcaqRQemfD7LHThR1tCd/JzD7m
	jL0unOETuQg97dxOaPf9huwM1JakOx+lmhC96X5HNfWiO/TH3IZW7s55DrS+Fh6pnKQusLONAIN
	GwVF2XKgoL31Biw==
X-Received: by 2002:a05:6214:310c:b0:8bd:de6d:c344 with SMTP id
 6a1803df08f44-8bdde6dc669mr190711176d6.20.1778344755322; Sat, 09 May 2026
 09:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509012247.14990-1-enelsonmoore@gmail.com> <21e1eeaf-5c8c-488e-89a5-123fc2cc7b1d@bitmer.com>
In-Reply-To: <21e1eeaf-5c8c-488e-89a5-123fc2cc7b1d@bitmer.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 09:39:03 -0700
X-Gm-Features: AVHnY4KwbterUhlugcW_6pZ2ileRIcVWTQ4UTQB6XTT_Ceh7o1QHPSSaCQg7jZ0
Message-ID: <CADkSEUiMKAQkRKek1fRpb=RtC99AzZm25emGbC75RzQYDct-1g@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: ti: rx51: remove stale reference to machine_is_nokia_rx51()
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jarkko,

On Sat, May 9, 2026 at 6:07=E2=80=AFAM Jarkko Nikula <jarkko.nikula@bitmer.=
com> wrote:
> Not fully true since machine_is_nokia_rx51() still returns true on RX51
> (N900) and driver loads successfully both before and after your patch.

Thank you for testing the patch and pointing this out. I didn't know
the kernel still considered the machine ID passed by the bootloader
when booting with FDT.

> But true you may remove this test so please update the commit log and
> you may add my tested by tag:
>
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Okay. I'll resend the patch with your tag and a fixed commit message
after the 24-hour deadline.

Ethan
