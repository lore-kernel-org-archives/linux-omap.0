Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1C3FE350
	for <linux-omap@vger.kernel.org>; Fri,  1 May 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654737; cv=none; b=BvHSiV9/cw1RE0TeCGw4FW/xVw237i7DLBALIXmZm6hCbi0qPtLh844V8nHwT6Sghmny4TLDKwQvvIlZbCsfhFMFrP0FnZhF9AxvtS7gJFh1Oy+fjylMtssa6f3/jZU3e4TGqKhotog7yvQKcsCGw8zbIwBMCXMMwFCa/1RsJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654737; c=relaxed/simple;
	bh=SHinq8nN6TVD/2Hc5zIN8kWJIqsdr6OOjs8GrCF8fnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TonncZur2e5/HLbLIisjOxEq30DqTCUlvCbO4fKJiQAEJkuNOX31jMHBHzuYHGVUcfiCSu9uUXya17v6h3uChXokQTpDSxb6I7JWPgEWlImhxAOeoL/kRXP5JjxnmQtPKpmIYh23HF4b6l9v9C1LXBkueM3SrNUv5v5HvmgsFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SCFGxm5N; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SCFGxm5N"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1551791a91.0
        for <linux-omap@vger.kernel.org>; Fri, 01 May 2026 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777654734; x=1778259534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSgZ9p+FLa5dE+egtAU5+ue1/mNyVaBwoePR7YQHN84=;
        b=SCFGxm5NVGIIILLzNEls2kao56s33XhvDIV7V9zzF6ap2MQt5pA6GQ42zalFuyr8cQ
         HkfGuETT7d8XliABoSHmMx5/S+xJbfvyt45GZUmWNBEWT4pkDjq6uM0SVt/UGREO+8EW
         V0fNRS0UygByF4VyMXVc2658viUXIefdYbw94O8bm49oYOt/nS1Xq4mTKQAr++zIOv93
         hvZMiHb0/u8cO6ltZvtUtMlqRZZ0bhsE5u56LkBh9Ktlg3ETwEdbHWAbVk/m696VKn8K
         Vip07X5S2F7ja7N0dclDn9AMh2jSiC1ZZSpEIcKCJ9ysBXWOlA054lxPUjHiPUHnmZTe
         xC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654734; x=1778259534;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSgZ9p+FLa5dE+egtAU5+ue1/mNyVaBwoePR7YQHN84=;
        b=Q3k1ASeYN5KMzQF3JP3jfXN+HP0vMhBc2Bd/RoBPrSkYzSSPs9aSTCHbiDJGlRvL76
         PHeKEJppQ9CvK0h/j3t1MGTAnFvgCUHbW0kQ7YB8GazZ5AeBIOzQzvFsb2bbFVjsWCAl
         SR4WvfW/G2UuS8VefF+1aKASysWWPP037tOPHhRCqt/Ucm11DYn9sE8l6BuNARpSzXE1
         WMq5s/bC97qMgr8b9kdw/x9ecD+SdisWDngsqST54vpvwrBdeTMNm1wEFQCmUt3UeFxS
         EYDx+1ft3VrXOVnenRSDqN/a0YU0n2TDiVPJcuNzqBViJpJ++t2negQ12SY1HqSh2uFQ
         clrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Aebwx94fLjXbAEbwPrL4L5IyKbhY0jwfR+i1mOSxc6dXAOhaeSEIiQNV+EbSGrsOrkjZrykB3RDvJ@vger.kernel.org
X-Gm-Message-State: AOJu0YydV4V9RT2gHLMyEzvqsG5LmRakiSSgBHI+sNzlG9054QU0Aose
	FBzl5964w938+MyN0LowAZJcWjvCyWO6GMGi8oW/y6I8nQeRXFAd3EwPuv2axEhf/cY=
X-Gm-Gg: AeBDieudFYErJWRHoF5oAX+uu+jpQZSOMaHDtZ1JqY2qyCUEbMhWqlrh4DMc53wVx70
	22iLMln8xcH/JeTr1j0S0ddUdAdpHR7ocjNrBcZoSqr9MB4ANqNF+i9yHlLthIF61pBmNAcIOAu
	cDv2k5LUKpfgnQm6DYsOUy7do80rc8aOudSk9mlTNDhsqDukpOtz1pqNXyEnaFCIJyI8VQNb5AV
	ClCYFMHUK1PE2QjSVNzWNtgMzFPZQQikH/aQEQdxRjf4C97le9y4qad52RoJmCTeox/L+sGiw0C
	go7xjbCbgL3eAHAubnPhVi3dUuLDgkvbBN6ihej7oxjaij2/zXwdr3a2spxjMvLyJpWWShpiAbM
	pHD7fgW+UDxwvZC7cPyKqZk93k8mO+W2Bi5LmIpT+g2UpbRjXiAb3rkaCJqR0HG/1msrMd3ZDFN
	gRh52e4spISDLpKrOcM7U21upYoN4CKA==
X-Received: by 2002:a17:90b:4ec5:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-3650cd264c9mr52117a91.6.1777654733851;
        Fri, 01 May 2026 09:58:53 -0700 (PDT)
Received: from localhost ([97.126.187.42])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-364bdf54203sm6242551a91.7.2026.05.01.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:58:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, andreas@kemnade.info, rogerq@kernel.org, 
 tony@atomide.com, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 eballetbo@kernel.org, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260325223411.123666-1-jihed.chaibi.dev@gmail.com>
References: <20260325223411.123666-1-jihed.chaibi.dev@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-sl50: Fix audio bitclock and frame
 master endpoint
Message-Id: <177765473277.136795.1708600331167857182.b4-ty@b4>
Date: Fri, 01 May 2026 09:58:52 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 25 Mar 2026 23:34:11 +0100, Jihed Chaibi wrote:
> The cpu_endpoint in mcasp0 specifies the TLV320AIC3106 codec as the
> bitclock and frame master, but the phandles point to the codec's port
> node (codec_port) rather than its endpoint node (codec_endpoint).
> 
> audio-graph-card calls simple_util_parse_daifmt() with ep_codec set to
> the endpoint node (codec_endpoint). The function resolves the
> bitclock-master phandle and checks whether it equals ep_codec. Since
> codec_port is the parent of codec_endpoint, not the endpoint itself, the
> comparison always evaluates to false. This causes the mcasp0 CPU side to
> be silently configured as bitclock and frame master instead of the codec,
> which is the opposite of the intended configuration.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: am335x-sl50: Fix audio bitclock and frame master endpoint
      commit: 2bc564f46b00dc4f4331fc337277ff3f5fac8a4e

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

