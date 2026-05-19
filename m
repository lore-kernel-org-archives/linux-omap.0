Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA23EA959
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218021; cv=pass; b=SwuaAhzBPlsYlUiExu9Tr0qPdLCQn+xCWAHug/PG1wreh7wy5NAhxViODG/rjCxd8C6uI4EzSdlxr+L/lO/WUH6n79tEO+TG8QJsxgcbYh+FcFipzHTyhaklBcYBmqEAKoGhNdKYBOZcfB/gnRAHAx0VuE7P96oz3bCoyT/V0bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218021; c=relaxed/simple;
	bh=TvTeZUpq26IRZS8BDum62nrvWawBVSt0lU+Pynl8zxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/kSZICrFSVIwuBer/5RESg8EE7o6yORvArABFfqLdZj3MUIe6FJOSJsoh7AkLQIOJFVYTuWODu8WQQ4z0eF3yVcmAmdcL4gz7JT9q5oSlzwHLLW7jsPHvgqqr0eaI3UjjtxtDdfVVIN8bq91eb0qhG3IBO+3gaTVJt2R+Q9Pos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Olwyl7Px; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olwyl7Px"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50e63771eb0so42856791cf.3
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2026 12:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218019; cv=none;
        d=google.com; s=arc-20240605;
        b=Vyt3SAWVUJnEbPqlZGu30xU0g1B6TCu/dbL7b6SE3Dzw8DtbGqLOlt2ZNXdyH26eX/
         IHgYuPfZ91JYjlsoIyj/42fQuC5P3bqiMtCtnk3b+znFux0eg7Nl/J/cL342cu3aDpkk
         I034k9VpdMj3HuaD8Xmg3gac46fuFpbO0rvsikqC9+ATHfF5eCf0s8MJ99hALQra/SR2
         tvbM1rfGB5KG5Cc+GwGyTvAnMFg85lzMW6pwfa5MA3LKvMfWV6s83C9MDcjsh/BU1iV4
         r7fFfAtbh1E84nTIuSzwdnCvQXCMP1So94DgP6iM3U2d0VLQ3LkTQx0hJ4gMFrMk6Jo4
         D4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wwdx7K8MgGQcUZ76dZ1xm1ruXQr6bDMCCuKQcB9ixn4=;
        fh=P76zzZlJTMomAsPJp/q59SIA9pG9ZQYcubSdfN0Thg4=;
        b=iCVZrEghqi7Z9cedP4QUDq2jxHWHdlWnRq7F7Qr/SC5KEaDxdWH5ND2okut6oesU0L
         3sx0IKcYPi++JFcSsQivb6Mt/d/R1UEmffV6JyMIWYWE9BC3ftNkUqrpWRhQpJ/kPxrH
         NBtu8RBYn777sSzewWGFNCNw+gwr3W4lLfn4bfwncbPp0f0CFTHZNsUJCVJCouHT3ZxY
         zlDj0T4WP466CD3BeAgX7XDycmwU2+W6Zq7/TF4Tt18/xJbLSPk4+HvSTDdrb/GZdsYn
         /WwlaOxiclOCc7/E3u6YVdurUCxDfJvThpOx35frRDdPzdQVs+3YosjorCZJrbq5uhgN
         6hdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218019; x=1779822819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwdx7K8MgGQcUZ76dZ1xm1ruXQr6bDMCCuKQcB9ixn4=;
        b=Olwyl7PxR2qlw45XALYcq4MebmMn/K5sl8yhVlzavmbI+80/HTgP9BuYJNhDiu6dEh
         xZTgSf+BtGp7btOh5i3MTYOJXX/loCgWaYu1w0QqlN9VASsMV9Od1kp/R4f+4fRd3Jpa
         urvol4bj1lsyRRk6wTWgduk8Vuh3jW+NDXJeeCkv+Qvxp7PSLAvK6hrasOgLJO/fhsUd
         RheHz18DSBC709RU2y04CTyFbSuMM2d0V5eBIwbQvfvFsGur206flgBg33/psQQ1TaQN
         red1q+t7Bo2g0YBA/IcaeoH9KiD8K6gGTubrDJ6DChTU2te4ZQrCscttJy6gw38q0JJZ
         U/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218019; x=1779822819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wwdx7K8MgGQcUZ76dZ1xm1ruXQr6bDMCCuKQcB9ixn4=;
        b=tOcP0oTemmPaWsfnEK72Zm2IvI+CHJEhoi7hpI5mxkEtorbkXcOSsj+4BHzhde4mAo
         FBJZx/FVDUdFBQWbakDFE2Zy0hJH3mwcpnxszm3wX1iijdR6kftG5JJFzNLsmnqsjwIu
         7GUCdVBiRMTzebBPKHHmiDL3Fw7S8TgZjJcOgcu0KoyU92pLfjzWRLjGsCUQfg3217P3
         5w8p+hcpOm+3cggwc9mfmaYyb8grdWiBqFoxNNi7NM2zL0/1toYh7v/DaMOBHR/Rwue7
         p5xaTk7JpVUJZ09BxtBmq69KLBLDB0/BJR5bIWlEh8KVLohIYsz6rjWoVUFZI9SHObjm
         6Ewg==
X-Forwarded-Encrypted: i=1; AFNElJ8KJMgScSsEEmLPShWaznYN27m83VhcIe/TV4jPBv8+QZH2OSE7Tdj91MQ1wGMy0714LD3Xfpj+9jC4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl14OgAjdtxJBTCV8dsCT744IF/Km60qQjzMdKURLolIMr3ctM
	fXcpZDxcCvXT4G9nBG6LAfIdIbec8P3KdoJN0s+Xn2MNowtWd1lXCfmD/duWgfNlIacv96Kfhzj
	Tdu48dP+hIOZ+WONhJcqlIWMnxn18xpU=
X-Gm-Gg: Acq92OGTTpBAmVrqyWDn5Sgb26swuGwBKGQk7Wv1nUcSy9c52jXR1qDRsX2gs0z2XHo
	fw2d9eRwpuRyRTuaSA3co53JkBOIxF/7TYtfGHWN+uteb5bAhBXGH3BrmejHMbUE2IXdw8NZPco
	LPK0hVAizTK/O62pL/suGD0Jfvq02ffZwWd6Z2b5URO6hlwaf0agHhW8WwarqIGj8uYzs76pbEB
	Ypdw2WsvQjCViH57oBFpDS5XaBkQ1HDawGjfQUjPmKCW75svMwp0He+jEw5CFhu1Pb7OergucAh
	9oqMz+MC1PvUtslFRCPPlCYSU1Kxhh3mLDsIox4prs+ec+rTLu7Mz36t56ZOV2DaubAj
X-Received: by 2002:ac8:5f8b:0:b0:50d:5f34:9a with SMTP id d75a77b69052e-5165a0d064amr269060641cf.28.1779218019454;
 Tue, 19 May 2026 12:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517023723.92731-3-enelsonmoore@gmail.com> <edc020fe-1615-4a11-b414-c6d4e8b7dd1f@sirena.org.uk>
In-Reply-To: <edc020fe-1615-4a11-b414-c6d4e8b7dd1f@sirena.org.uk>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 19 May 2026 12:13:26 -0700
X-Gm-Features: AVHnY4L4Iup_ZVRORpZbBblYTYWsYcH1V4IpW670HVxLxn8cA33PmOn3c7pnxUA
Message-ID: <CADkSEUjhaU5FOmG4OSOnCQQXGbcPG46NBe=h3ZotA57E0MKTrw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: ti: omap3pandora: update board check to use DT compatible
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 2:02=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> On Sat, May 16, 2026 at 07:37:22PM -0700, Ethan Nelson-Moore wrote:
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Hi, Mark,

I didn't intend to do that - I resent the patch because I hadn't
gotten a response regarding whether it would be fixed up manually or I
should resend it. Next time that happens, I'll check to make sure it
wasn't applied first. Sorry for the confusion.

Ethan
