Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F919067C
	for <linux-omap@vger.kernel.org>; Sun, 10 May 2026 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778392085; cv=pass; b=p8gGxUFg2DXaPMoCvw36TvgHgu3Hhp5etRrJiQ+3V3ZIkRowpcBkAVc74LHJXypLd9XYTGkzEWp0Pbc9wemKc9FIi5XIEDNPGT5+6fhZK0IJQk4RqzS2HUxiakoLnC0L9Xbt0xu4YH6mhVYgL4UOlTKRMrhnwHCbIJkOt8A2Rlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778392085; c=relaxed/simple;
	bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz+pl/Y0cifxFTiIlLgXryYtw/VY4/VCAz0FnRLca6ayyEAnPJqlTQ92wRAcAB2LZbCzQ9e1eyLErGwQCovxF1gN+0ElvNo0m8Rkf58822/0AS8r1idibQI8kLxVg6W5GEJIkVhI6/3uWvASWazvV/yQDdYWp/BS9VXV4b9JHmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDoQe6yo; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDoQe6yo"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50fb1ad3734so47021581cf.1
        for <linux-omap@vger.kernel.org>; Sat, 09 May 2026 22:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778392083; cv=none;
        d=google.com; s=arc-20240605;
        b=iT7Vs19vIDLQjoNkTI4ZXnw/b/zKKy1U3K9EJI3IsTmjaN5adARhg9itPqeznpMYi3
         dKXZTcR+osnoSGdaoeou8ZDsEiONSXatby5CUeqMKFZSY1dfhrLymYHMLDEtjV3Pzx6T
         MIplyxVqIv+k6DpGGeuolZZZrYEBbKRb3aXfrZu4ULRtEZdDAwcP8ojEzHivQkyc9GCc
         Z/TLTAOYACoVsXMwGgpTgmKOLCdiuTupTwjHZLKuBFHURjI+L6Uc6u/7mdIQmFUUaFyw
         kMDKaovlWmtn0ojXgAzR9izbbL6xa1U3kTRvzZeUt+EXtMOzibaNL1shZEy3ehPw98b0
         taLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        fh=yZEfyCDi2wPHOWXvQh4VVTuarL0GUZsxWUDC+qY2MqI=;
        b=hVWr8nJzE/ESxXw3oc3MTsKLrHFcmV2bbHDLQw80yMzpCdpFiC5a6nWwIKXh+cBZBO
         9bZJ3ZVvPODhQ6tGAC3rgcnR8wqEouJX7jVpUZ8JOkqLAaO2at8mACmtaxkDFRAQ2OVn
         18kgx9EwVB4zgY+6CtVqA6d+fv154BpJXOt7x8ewbgm5Mt7KOqJIXLa+al5SzweGzMYy
         evFUZ68VIEgkuTia96fDxpkqMoTOVag9/sy6DeTEGASwFo3F92YB0E1TQSh86uTLx6ze
         ucz/RV25ffUiNJsgxUVsANxdrgh7s3J55I0zPOydJZCY1aTIQ2/gVIn8A6mbPT6FXoIr
         29IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778392083; x=1778996883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        b=LDoQe6yoAOsdzHVGV9sGu8fVGY7908G+vrEQ5Yf2WZBuvxKiiSwqt5czXM7H+Aox3f
         wHuAJahEOy1RhAtz29XIuvBehrlSaYM/wS5nm4SiPvlbMB5W9VksQWufRP9TZQGM48HU
         5ywyoIfWkfjhHUUpfLgnVlUxlpCVTiIau31fS+j9cJDjSXzzuJBBIsm51PB9G4Wu8Q8M
         XGFfzgeros1ZR+L9U0/1rCQU92bRxBYcgzogCt4tNCGaqW8KjQV1CkeU5GFww9oiBXYj
         a/XXg+326vu7sZBUq/5M8l8yIlSUKTGUDfgefYQVWyFmZGD3MhODnq3cU4Hclg7/+XuP
         R1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778392083; x=1778996883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlyRJhvnlDjrc8/I3HZl/0CriWkgCPSLWWeusGUqgvA=;
        b=hymw6t0W9QRK7iGpJZwlSfl51lz3pEDnkAM3QaIFQ3phKSRecAxdGXIhEWqsMd0gup
         /0heYsxjuG9nZsA6RRdAWesOZPh+if4obsHMkpnE36DbtWE1biFGFKHrmB8c/n24DmQx
         iw1BF/f/lC7KnSUUHZ6fO3EBbPv/W3ZqHgCAlyUduW+VL+w969JnqP8lSZIasx7X6Mof
         pwEXwey4iov7Ro0zPytoTF3xLlyRQGenxkeQtI7qj0RHqUVwzPbcRoLsW/naWEGSuHew
         AqK/23fu1ATVxLVJ7l7LUdhMa2Yd6xzhqB556XjX29/V7Tlj1bB5z0rioW2ZUZx+KalG
         sFyw==
X-Gm-Message-State: AOJu0Ywl5rL0v+bGVstI6FPbTLcha4oGMdhYivA+NDsbhGx+jAcBHz0k
	U3dDU0n3+FHxxKdMYCcW/joIMQbQmlF1b7s+x5gYZdry2AxWdFOB5o2et8eWCBR3Fl74n43hp43
	7tMYEG4qGCkryztqrpRbi29+W9psFhJTDBTn+0FekGw==
X-Gm-Gg: Acq92OHWDTvwwE5ZATnTwzN7JFD8Mmhh1FNnYMClY59h0hp4Na5LR2QjVyBA/1xkJvE
	GYNoAjBPwON2m6vf+m9N15CS1HW86esozC+EWtMecx/fIfMBdy1OdRRSzEeDuAKx5lWcfmxJhe0
	yDHl2AOwGgUvBSed7ubpBp8jxlFmmLxHb3NPjSJFPA2VNefT+0oIDcyDl2KscD2sEoVW4xmFY4P
	/42S6zvFPodZy67uQM7vOIaXAFyfA+CiY0V+Y9lM26SiUpXMajLRXOI/ZdX0VD8T+x1qRRY5cLR
	MofHQJs2vp4quq3ojj5rB0lHmPcxcxUAp/ASnFPHSwsziEMBiImuHkU0uoBE6yRpz6x0wHOEbAW
	r71c=
X-Received: by 2002:a05:622a:14d4:b0:512:e7c0:4f00 with SMTP id
 d75a77b69052e-51475c606c1mr180590451cf.29.1778392082749; Sat, 09 May 2026
 22:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510053939.564314-1-enelsonmoore@gmail.com> <20260510053939.564314-2-enelsonmoore@gmail.com>
In-Reply-To: <20260510053939.564314-2-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 22:47:51 -0700
X-Gm-Features: AVHnY4LNd1U1p5EqiJ2Tf8WrmfbSu5kny63fqarABjH8-IZWo3auqSRVRUuDsjc
Message-ID: <CADkSEUjrvfWGQRmaC+eeBnJHDX=cX1tFZjY05+3iLzT5uBdyxQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: twl4030-power: update checks for specific boards
 to use the DT
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
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
