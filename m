Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000783C552F
	for <linux-omap@vger.kernel.org>; Fri,  3 Apr 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232065; cv=none; b=W0QRUylE3xNFA95VEHQke9delih38rB1QmJnhq10GbHMT2fDgsoSDbZZtNJCQ0VfyAperL82JB57h/k0XKbwss1bi8YAkYWjC9jFco3irYyT7jed1TnLzNTvrREhrp73iZV2nmsX6DEQiIG8xKMooKfw9ZjNhgStFtcP0qvBmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232065; c=relaxed/simple;
	bh=Ki0zC6Bm1xXEyI31URywRK+42h15Mdjh7I6Tmw5o5l0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7M5ROEiTAg8q5a7DuN4/j6Nx+rEQZQSByw1jAgxG8nIJEHNXM2j1pr/GbdzvIOnoRKk6sDbJONomwqWDNMg66agJgvEwDDrJ31NHRM49lOBLtdjxRPI14XHEZA3hHst3GZjt7IgkWrHDb0S8ZQl7V3EMNgyhKCGGDKCvek0jwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=h8LNMpIx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="h8LNMpIx"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a655cfab5so1773582b3a.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2026 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775232063; x=1775836863; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVAFddO7rkVjUEFxW/6GAQN4GzyoLvVdv8+D4JuOi9Y=;
        b=h8LNMpIx4e11b+ec8C4LruWDe7C3Fd/09xJHCFyGxKbfwtfBh3qcR2fw6i/QIdcscY
         2YNsf5lQozMIGvtgLWynvM4yEXWfyLIQH6ytCuS1KZuKHfHnVnfSxHjxTvBSDWvh+192
         PwGP2bkwu4lkp1nd5s1TKq0VUIqcCUVes01O9ChmheIXuge0lM4tB+pcc50gnLDVrffR
         bsnNI2XxIweIYf58537EKps6j4w4CkDEA5UP8OgYF/FnxXaflIFEOgOrDDkejsNBjmOW
         4V+77wOKEohXasLto8Gm1lV+393Nv8WQxrpPy5H28StiY/qj1zZi4l0uOApbduIOZzZi
         eKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775232063; x=1775836863;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVAFddO7rkVjUEFxW/6GAQN4GzyoLvVdv8+D4JuOi9Y=;
        b=A2zif2+XKdAhKfI0eYRx6fvGnJcwAPU/0d95kEpnGyXy4X0CzKR95ELcfyS4ekqPB/
         6jmA5nM4gFolaLiYwto1FO3c1UDFnAk4vo8X3xpqZgis0izpXcGPHBXSGoMsenDTh6d6
         s/Tqv7euStMvrfnIZ7z2q84cGq0RnTU/SMek5orJPsOL5GM2auQyrmPVhSFJxe3BJTu4
         to0l1kfaap3N6icdvgGsASp3fYH+evvGR2IEM43DDISTaeh7F1VVAwKFhmSnKJ/MDRYn
         gQMRSEZXDQeft95kFL40ahLWAvRcFV9j4JMymQjvo0Gmhx+QvN39Xvh7QML56iLCuzXh
         wfIA==
X-Gm-Message-State: AOJu0Yxkzg2CLgteUa9ZBHwVYflb3ztY7gTSZbiWLWgV/Afdqc+eSscj
	YM8j7sORUUjjQzR3wa+w3Hs7GWBjd6raobbfpP4gGPdAg7kopWu+GxxsqBdtzvG60t7ClMH+7+u
	b0AfchEs=
X-Gm-Gg: AeBDiesflGiUXoLWBmoVh++Cz8CDwNmNXR183g6hfVqGJp29PaDXJjhgkO/BjliuBBB
	tzx/UkpSXtxFDeKVYJWX7uRAUpCFKRsI62uSgVe6gFRiFa9uGnYhjTjxydSGY8Rk2k4MVpm3eQb
	Se5R5k2nIFgYpykhnfNAg7gQ2o8HX7VXP33AJYpBaUdXOFcJtjpj+AUUNah9CSPR4PEq+r2MHmv
	r6A+VSIoHPLEScI5Y+HOs1MhY7MF0l1OH5216atmY/l5eFmQK5o/CICPBdHt5Bh+FMqUp7zsY/f
	4+2aJvOlh5XukWKRCeW1IoHvLROjoCdViqp2C8OwZJuohiuaivz8HTENsKjUy2IFZrQ57HxdMRf
	l3tyVUbxwh/0WmziHOwWG/7VSrpjtG1jgTJRfhUzGUC28SL8HWduhAodmlV4qJpiFInja2+05zd
	koeISsWsYffdlBadUgHXA=
X-Received: by 2002:a05:6a00:3d49:b0:829:7553:afbe with SMTP id d2e1a72fcca58-82d0dbe6401mr3671936b3a.57.1775232063072;
        Fri, 03 Apr 2026 09:01:03 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm8256712b3a.19.2026.04.03.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:01:02 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev
Cc: Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] ARM: dts: updates for ti/omap for v7.1
In-Reply-To: <83d0c8d8-fcde-4407-bb09-c2ae0e0e142d@app.fastmail.com>
References: <7hqzoytlms.fsf@baylibre.com>
 <83d0c8d8-fcde-4407-bb09-c2ae0e0e142d@app.fastmail.com>
Date: Fri, 03 Apr 2026 09:01:02 -0700
Message-ID: <7hwlyorq2p.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Apr 1, 2026, at 23:29, Kevin Hilman wrote:
>>
>> ----------------------------------------------------------------
>> ARM: dts: updates for ti/omap for v7.1
>>
>
> Hi Kevin,
>
> I applied this one, but I noticed two problems:
>
> There is no long form changelog text, please add
> more information about what is in the branch in
> the future. I've added a short paragraph while
> applying.

Sorry about that, and thanks for fixing it up.

>> +-
>>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi     | 744 
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts           | 101 
>> +++++++++++++++++++++
>>  arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts            |  70 
>> +++++++++++++++
>>  arch/arm/boot/dts/ti/omap/omap5-l4.dtsi                          |   2 
>
> Something went wrong with the overly long lines here.

Hmm, not sure what happened there.

Thanks,

Kevin
