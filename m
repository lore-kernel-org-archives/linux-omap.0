Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C632309EFA
	for <linux-omap@vger.kernel.org>; Fri,  6 Mar 2026 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759248; cv=none; b=pZqVPRVYhYGt/DVNsDszBWLSQM7i0IBrqKbxIcimBLUOhMORQQjKgAQkR93C+z5JmPhTxExT6ECUISgYw0TJjOwITu7swMlHoZgrQoeDKjvJV3MGyzRuYSm9IU0WhIHlv8MemZgIJ+d+8dkya+GhDICJGXMfU0y1TFDgW7FNr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759248; c=relaxed/simple;
	bh=2T1EIpwo21Mjm8tHmMvrEddLMLczOQ3KM4OkkTq4KNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mzBanPX6vLVljFHRjYBAY3Ji5AtdHWT6DcbnGlQ/cIX5bEaeSkLiGUCPPuGAwvfo01mpFZW/adoKghqWESkSNNLZEsTAGFgkA3cObfCh6NfWXiIEz4u0TXT2wf7w1ETwl4qoFGfBPOR56DwBVHFFEkAT21P1mfM9xtjo7YGVCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UWio2W4h; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UWio2W4h"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae50a33ff8so39716885ad.3
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2026 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772759247; x=1773364047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX8DXSun8vyFDP8tcIZqLzghP41cUIRKTQztSXvRddU=;
        b=UWio2W4h2oSKbY85zpadzqT89GpzVrMnIYTK5TD1d9Pt+gYEuIv+Aj+pynyCHfMeVU
         /Q0tggz9sCn7zkdfc2G+9eiNyB6P+okcLtxay547Riiw9sxDeDV4b5HK90COcpwJpYgR
         Ktc4jyJdp0q8r+kGKX5kqA8UzwJQy0dvZDlx/ACOtnGYJn+En/FueCYVei7LmchkgDTh
         KZzwPMkKEInUrSMOFHp6UUDcU+9Ls5jdl0QVBeGPwM579V+sr4UdXgTKIBtaFDOmT2yl
         SLZ9G3+zXNlnMnL+HL4o5m0yaLByxPh5tzfqw9TO9OHJ4268+oLMl95/cwaOoH04aDQV
         4nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759247; x=1773364047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wX8DXSun8vyFDP8tcIZqLzghP41cUIRKTQztSXvRddU=;
        b=eR5Rs4xAsSGvTX4GDyjZ68oQbXiYjohmhquUPGhLnM9/J35mORHM0Oj7cFefru4WUM
         nFJruSYAujbCogb4vS+jXuHly+qBo30x8FmDgVd6Zs2M+Kg5u9LWUj71axzw7jMCqIoU
         GGtGcA3J1kDT5+0o8JTGs2tMhqcyI6KmKNeWw78jRFQdKTxXDWBC7Q3QCo9DPN6yu5AQ
         Sa4vikNinxjFyNyINlFUV68/0WQiKtmszijSzE3wi/8jcogufTD81ZywhjSdECxvk2c/
         cnZlS36J0tLyyv6E7+coctBNTpx95a2YeRpB3KPQprVsHfQZ5ceNdZwqIO2wXQEgMbZP
         r0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlIpHiHGcfl7pJLhTpYq90L+XMT5GGhKjySxt3Ub9AyPmVeI5/rGtYeMcwBn+qjNj5IBZS+v5pKUp7@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbNeGUu38o2xolTuBA7k8TNxE2ETy839iiwhfOKCKDbnmNxI+
	l0jGxwC+C+kSZfQXmzZ65LoKGeOzpvM/h9k69WhiF+u4+30M83qnxnraGVuPkbOnE/0=
X-Gm-Gg: ATEYQzyjgTUu/b2ESPpJgKnXdhwU8vVRi0Kn4vFQgbAzE8i4w4VBQVVQCZ6Ozac8Fsq
	LJlYru0he1/+pk/k2LzX3BGM6SmN3RBWmADBb5+winSuPh2Qa2uD549SFsiZ7kRweNFYhZf34MY
	iIx8xmXB4fDL3EpzazH44SQU2SLKbTEzN8OS/SHiyu12Ej5Wa5zqwVXwSRVO+vcS+qCRy4xZmis
	1uIh+zX7WL/eLx0M4fdCcTUZP/Wu31CsHFErm4bXkDvBjXc5O90sBgb9uzmBKJ1jrd4Y5dxMmBb
	Y8L53TFkFjDNwNWmEHr7uk3f7okn7h5lpPyzrE59cQogpOQe1fzHvPeovT/Q7vpbgiLwU9TOOqQ
	S1BBbBL1Ul1XAXv5Mf1GCTUlG4Tf9DIOIyGrsiP16y+fqYkBMjiyJQaXKVgJ3kcLMHcLh94zv2m
	nYvIyooGe4/ERDnC3Oe6eogIUClol+yg8=
X-Received: by 2002:a17:903:1b2c:b0:2ae:46b9:c653 with SMTP id d9443c01a7336-2ae82431855mr5201065ad.33.1772759247109;
        Thu, 05 Mar 2026 17:07:27 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm247377735ad.35.2026.03.05.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:07:26 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20260226051309.556228-1-rdunlap@infradead.org>
References: <20260226051309.556228-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ARM: omap: fix all kernel-doc warnings
Message-Id: <177275924620.1445909.6503148696411079106.b4-ty@baylibre.com>
Date: Thu, 05 Mar 2026 17:07:26 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773


On Wed, 25 Feb 2026 21:13:09 -0800, Randy Dunlap wrote:
> Use the correct struct member names to avoid kernel-doc warnings:
> 
> Warning: include/linux/platform_data/voltage-omap.h:27 struct member
>  'volt_nominal' not described in 'omap_volt_data'
> Warning: include/linux/platform_data/voltage-omap.h:27 struct member
>  'vp_errgain' not described in 'omap_volt_data'
> 
> [...]

Applied, thanks!

[1/1] ARM: omap: fix all kernel-doc warnings
      commit: de70eef32e10883fe74f6df635c616785b24b867

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

