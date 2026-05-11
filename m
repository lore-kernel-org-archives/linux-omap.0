Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78242EEC1
	for <linux-omap@vger.kernel.org>; Mon, 11 May 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518316; cv=none; b=tjhvP7Q9BOVUeYFWq1XMvZrfDAxfIIjCiQCuZ0FzWbgk8urRFIdpU2+i+bPiYcrvAhWjWzG1+jDByfwUUFnIxYWni5vlR48dkKfxbIXn+28CXm1r5ubuMaK6n7NBeH1R83L+B4/A0GNfXLCmsyPHAVS1MVHLjvOOwobZiz4IsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518316; c=relaxed/simple;
	bh=sEezEQwh16ztL+41daNSGtYAfN9UHu+rNwfkaAQd+is=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K8FRzGoJmSUFsJvWo9ju93mh07wPOe1ZEploCrg0OMr++RCLCW5QIzk73I+xms4biM+yqJP5y4R7OrK2+9bW/9joBfeV0hnWskXFitEt9ph/zh06Dzk1V7OQ6o65Sg+OGgw2z7e4spnCRAfNOyRh1G4yMmqJfGXPKHBj4Q1frIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=drYPQJkU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="drYPQJkU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bc85eda6b6so9272315ad.1
        for <linux-omap@vger.kernel.org>; Mon, 11 May 2026 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778518314; x=1779123114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCCfdV5epOfYo3BsJom2sySg0/nC1lFfsXrTGiNtRwc=;
        b=drYPQJkUQJeDrV3JRSRe6LjICU0/GmoOXK0dehCo+POHmijhuYgW/nik+ou4Fm8dlJ
         nr7pHe1FmdXAwSVN6wlZei2COLMpZfzMOqvllW4ItlD5wr44dB+p/sJhsxC/uDpbdg1h
         1dNbIC7HZiFDLT/Pm9jnM648fKE1UEeX53XEhGD4dP5S8WmuqqMdE8IN2rgwf40entQT
         4/WKp6ido463k5VMBGM/WJltHIvJa2DfenTwl/1KQ0inkas++Wb2ENAtmtdTYVokuTGy
         0xJqgzhGm5DimSyJEA/pcgXxH3U22MQ/MqP2DM+FzYOsdG+cuB+aT80UcjboeTuGuziJ
         c3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518314; x=1779123114;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCCfdV5epOfYo3BsJom2sySg0/nC1lFfsXrTGiNtRwc=;
        b=p/SWzhqUVj0udfcnwMwOfRcnD/azVqGj+U3W/Ujk/PJmvTDbQR+nbxJm+kYKBjnoDl
         F6QPYmnAbZhWl9OWXcltxf+r7bqEpAA4Y0JF+ZM4JBHsb0H56NGaUKq5XAu2XBAGsBOB
         3uWYaJDvSSJ2r7z52wifdcJcs4AYtNkZ0LqwFW4kao4CD6tfBLqX/P7U3vu4bQNhyKml
         Wm8qxd8FqRqqmfsDiC3xz05mQUKto7M0kV5GiJasPijp3TR5WFDUul8H0OHR6M5HM19y
         Mi2iDaKEHwhAdBGAsfVsnoHanPyu//yo42mElwq6+QexbakCjeqcGTqMBKwM2y9wkng8
         V10A==
X-Gm-Message-State: AOJu0Yw9nkji9S9dSXXMYwg5nhpA3VcXvdX/cHYZwo0TdVt3DU1+V7rS
	p0iBJ8AUCmlWIeKc2uiaO4USE9yy0gA4T9OHRCQaqQijXOGwUxk9i5QJVVM1f55U1MQ=
X-Gm-Gg: Acq92OFVI3e+AVxvZXoZplYhvFVc9Y/KWBhDN5hiBTnaXb4rAYfp8LhXxuaLbbyaVTH
	nGlI0FNOi+coLEk4GKnnLPRYsr71qTUDm4xW05VvSF88N9mWb4ya4koI7P2eGVDWXRGv3YBGQzV
	4cDT9i7L66rCSq55S9DlQKNHpNikiPRM3j9gmrC24ReE89F3b8Cg7edECtuJLkO0LmsYVdCZOKN
	svqBi9kGMYQgo5+19fCClkBchBhzRt8XFRGsXctLo2XDKuKveYUtNA4FdjXsCswJvcYch8w0FWC
	1+0EVkN60qhblKGYPxTqwkw09U7osipK6MI7ufFXurQnrwZerg6jzMiDzEjUq2B7nv4FhAxz8p7
	2jSBd1ysDaHDOZDvW8aSleX+na3QRuAUDecMdKSxqNiuDs6PKxsC+PnzHUs6QSdRfgF/lkJm2uv
	GRajPaYPG5gGfLmdPXFha9KDaFmvBLdg==
X-Received: by 2002:a17:902:f70b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2baf0bd5421mr154830895ad.0.1778518314037;
        Mon, 11 May 2026 09:51:54 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2baf1d40a65sm109201975ad.20.2026.05.11.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:51:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-omap@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260330213528.18187-1-rosenp@gmail.com>
References: <20260330213528.18187-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] ARM: omap2: simplify allocation for omap_device
Message-Id: <177851831304.45285.1551367657338168278.b4-ty@b4>
Date: Mon, 11 May 2026 09:51:53 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 30 Mar 2026 14:35:28 -0700, Rosen Penev wrote:
> Use a flexible array member (FAM) to combine hwmods array allocation
> with the omap_device structure. This reduces the number of allocations
> from two separate calls (one for the device, one for the array) to a
> single allocation, improving efficiency and reducing memory fragmentation.
> 
> The FAM approach also enables bounds checking through __counted_by(),
> which provides runtime verification that array accesses stay within
> the allocated size. This improves security and helps catch bugs during
> development.
> 
> [...]

Applied, thanks!

[1/1] ARM: omap2: simplify allocation for omap_device
      commit: 2a7a9e20b9e8b5dc4fdef777e67d390dcb3a8ea4

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

