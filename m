Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598E3BB48
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345111; cv=pass; b=ZApd6mSu35GZJwgpFqIuE1nkXwXxg/JgHOUW3IPnfqZvFvaVFPAtNq5krCOhqKsu1mk8gKD2ZmRlww8GI4ZX1WAlMX2hHaKlISDIw4uC9mqO53a2i3JTeQbJteouKfFF+e/EN5SL7S+Rj7v7JjY4XL3X8S5KkfiwsrJm2GcRu/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345111; c=relaxed/simple;
	bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paRlG0/GPfMdztBHi9eEUVqc+zuikBmARW7f2bPp2dfadXmdKSDjNBpxEuMD/nGK8Ea91S8t0rgo9mWl58Fc3ZhP8qn0+Jux4tdoLBvqXKJsAzxWVh+RHRuphGDTn2LF2LaDeazRYoTV7mHILKW6l+oQlCgXG+4zNFFBjKNXFfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOhQ6UM9; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOhQ6UM9"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso26900996d6.2
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 09:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778345109; cv=none;
        d=google.com; s=arc-20240605;
        b=ZIyjgowiBliilCFfsSE5T9bZR430GI5mnzVORswu9rRzbqci37Yt53pdklyP7H0lED
         pcPPVyu6H7pUt9v1+YoSz1/EC5FEL3JsiJ4sWMGUCy+5MG23rFC41ux3XXHs40bW0RHD
         QlN5kmfvgSAVcYqFHsVk2FPLNvSk4ATyLLPFO/KUt27p1faonoZNmrl83YodKMugw8Xi
         3CxflvxM38MEHiUci8D/42AE2vJ9Gl5Pmk8jpcR8JTTj2Zasdd0A85eqf0wyISg+enq0
         tFISJUVqiHulmPDJm9uStqHw0MD4f6Y8bbxkIwes9CBSSxF+IiO4/nbzpjzagpufy4sv
         qbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        fh=R+GeHW1gI7x+xdlFKUAtMfTAGrBf2Fr/xoEt2NrQNYI=;
        b=e406kvUQqJU5sN9fGfLOPji3oJ25BH2vziPrizIwlZVdVfIDzQ4X9pkAG40fQ/F7oo
         j5Vc1rPoXGtcbSoiyiIdZ/fQOj/ZJOcOzvpqaWksB4i9Jf/XeLUI84fGvK6gpumPO5JP
         zCYsUIDxMwVR4v1svFSmu+gsmV499vS4+/Zn6LrvsMCoeTSrTd/CO+VkoaANQIayg1Oi
         7+migNcwtACihwor0JufnTjXZ6WX2DvadjwE/ptR+b2l+QT9L84SQ94ZtwvL96D1nlhN
         rT8ZeJgFW6f6Fvc/9rMG1g44+9TAlNEKseRdAIQMutMYbRnLtCsjlsaMSoVv1qoiVWXl
         Jf9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778345109; x=1778949909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        b=SOhQ6UM9iW5Y1ORgNK8DhGe7xJp6pTWgCmD9IgF8e88Eo7LwNFDIjgpKXMOiEQeToN
         BaCNr6fVJ6FN8EMJ74d2YZOw8ebOb/6y9FOGlbHZTR9shiA9WtE2mTI6eqK6zoMTOYhe
         FTwxPHRXDLUI+COGw/hHFhWCP4w+DkbeQefXAs3cnip9XpQeIpofEuqiYBydTQav7vEL
         KZwWtyA8b3IPZKx/SSBe0Xoz3YAVz8Y4drMt20vc38WF0IMtzq9b/qZgpfaYnLmPKY25
         VRO4MLcFwrIDQWXFcZHhdc/ysKjLXPObNyXdzxmkwDC5rGCG65p+/UPBzgF1nsfimeL2
         +aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778345109; x=1778949909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        b=gCu5S+EGjWWWFKWjdhOr8N5mO46+a6c894Fo/ipKeaOzCAqlKJ6Lz1bAnykH7Cd+fW
         DX2nCk2q0UGXG9I0WOhJOVktlTCOwTZXLQcC6uuS2ptE6KtGiLu5Wfo0wVLRNj+PIgb9
         RK2TV4DzYgXXLnC5ECdaNDigO589VJRWsRf9X/DiAda2UBoQcmHb7wvEWAIoWttAOwsO
         l5N3EAtqfBpBW9/ngLkfLSiVD3q7CwdtHl4rvA9b0Zc+ofa1KSfS5zF6X840XksJMe9W
         KXW/63iWnYQzxISf9FoDjlNk5vLdhoG7i++Mo0XQyRQf7AL3FobcfklF8pQjtrEkRB3h
         TOsA==
X-Forwarded-Encrypted: i=1; AFNElJ8+n+zJBlR1wvZdyBUpdCDpHAFyyr9ZX6vqRXFpSiuFmNvSGy/SFx8F6yGGV1AZg4zkZ3pjmoa6oxeO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2gaxVPqYzTyvm4++jLVAdhFeNrnbHk6M5DCRQYf5nueRqJFD
	Uu3JEKH2mFeJLQOuLN2fwdzDPsn9houuGUoGrH0XUdeRLxZaSvHXUbt81C4WwAULZtVXWkBUwUx
	NszPjIrsuzQhKgcd0XOTU/6PR2Z4o6AI=
X-Gm-Gg: Acq92OH8ZMO9+CNs8iJ/NydpmvECZQSSJIGboFxzSNn533P70BxkH7X1JSG7iOr2W6x
	A6zd7dpNlTSgHL4jX9YTAZK4BcTXfRNql8vipMrxlHkhNKdSD0bphz8DHfiZu4YrFdUjtfIPyN0
	2jqFf7qhIobsMbOA6vpCViSzvbvJ05rYponCGwUsT7V0dSdIEEs+PctVeC8v3C+XzBwmaLqaRTU
	BaqdpWjLRbezG30kG47uUM1cHBNAkgctipqrHwUq5bJX7wO2utSIvZghywQladbx8dkfWocdc3n
	RFWWhL3gJF2QAu5v2q9FhUak2fFY/aQ2wh7QDjSIc3n58sEbpKSHMICgONa+BGuHn7LO
X-Received: by 2002:a05:6214:48e:b0:895:498e:e9dd with SMTP id
 6a1803df08f44-8bc42784279mr256622446d6.2.1778345109540; Sat, 09 May 2026
 09:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509014246.21649-1-enelsonmoore@gmail.com>
In-Reply-To: <20260509014246.21649-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 09:44:57 -0700
X-Gm-Features: AVHnY4KgdnUDXFOPNu9q7392VVUMqFCBpgGPyfSaViyblkIGEqmRglq6axhe8Qg
Message-ID: <CADkSEUjuzsGLnL5N43dc6sa6bH8nGBr_U=tf-nXNAkTD7N=Cug@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl4030-power: fix stale ARM machine ID checks to
 use the DT
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, Jon Hunter <jon-hunter@ti.com>, 
	Benoit Cousson <benoit.cousson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 6:43=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The twl4030-power driver contains two checks for ARM machine IDs via
> machine_is_*() macros. These checks are incorrect because the two
> platforms concerned now support only FDT booting, which does not use
> machine IDs, and therefore they will always fail.

I have been informed that this is not correct and the kernel still
considers the machine ID when booting with FDT, though there is still
value in updating the check because it allows removing the machine IDs
from mach-types. I will resend this patch with a fixed commit message
after the 24-hour deadline.
