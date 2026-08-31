Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395603AC0DE
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199872; cv=none; b=NDXU7Z8GYqMXKvO3moI4R6O6CwaSdilYR3pD5neMPDq+zYZRYVMbm1wGLh0dwnSXUv45TcdxuCORhjlp+vxCmwWOOHz08uqbkaalvpLbs2yH5T4BWsedme8J8V2BTZXIEqKqpC80jSExug+T8sWCtbZAVDW5Bijthp+249vJtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199872; c=relaxed/simple;
	bh=JSKfE3C5hEzTaLOsncNZxFU8cYHA1de8CIzwYuA0+Ik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GFEfXpecboqfoOvoEEFIAHSoCuop3rOES7npH2O4dosUlAOLhM2HuSNRDzwFBdaPSEMFKm/xmC8a6YBcSPva6aWKdam1Lha/iGKqojZOOQuYrx7Q/aEoQLFmL/Mcl0PeRpdifjM3hiyHpvqXNZaCBRiohhhSsCk+KyaUZqwGI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jfVSY+Vn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jfVSY+Vn"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so137667a12.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199869; x=1788804669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9iKASRZYGsmUrW8F/UJhakBf/TxAKXi0Gw9hlqUJM4=;
        b=jfVSY+Vn7NyUew9E8Wt0ktg0nHNSUCOTtdu+pChNuA/N7/u4S0e5bPCe3HQyUoGZ80
         kqTGjnS2d3iKkw3shuBS6fGi4b42/21uimnPDlHLUrFJqm/sstXQqQn/FUdSO4+qV2QE
         DO1CWZxtTQsxwsdZjkFBplW4wG5q4lmqMfevX5LtDbSciDbWLT6m8/UfOuI1mhA2zfdt
         8TvKQh1iFK3SukMGKj9Lm2zspfUO0v0TDhHqx5iwPaUS7DYDVI50FueJqqRStDPclZMF
         4DTNrOIfTu3y6FYYo1zrK2L8RpMrVjHy0jfvcrpSmUrgOsYX4AgVBGeecgJQNeLiukNI
         YDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199869; x=1788804669;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9iKASRZYGsmUrW8F/UJhakBf/TxAKXi0Gw9hlqUJM4=;
        b=Iqm3NZjesKT0XRtC9zYLioqihPUsngaX9+wSfXs9V75/LN4GSaWtVywgDJwfq35ThH
         0Iz2VEGgMUWHprx1ohcnYhwxuDTrCA6ihqLUeeCgQ8r7XiG+pYCQSu/5IcQ/qP/EY/Pk
         1yFmikP8jYYg+VNZSQgSM+IW64bYmm38VTx1W53eB9HauitRDUK74GOMzNRsfITfhlHv
         1F6IKEzSi267zbD5gQNUkHxgL+474Afk1yoFYLCr0/NWX5vodb4R701nT0hyBEKleT7N
         n+Rd1N7eu2zi2BZDJ3FftO93wweRjbWfyK8TncgTQr2oSJEDakYJRY3QxjA7vWh+gPB6
         YC3w==
X-Forwarded-Encrypted: i=1; AKwUvBxnxWf1U2kLx2vo/fVHQzRTk0cZvcVmWeRrwWB7VW7QJT/KhlgojxYrvYpJBDRrXgZSeY31WhSmXbTL@vger.kernel.org
X-Gm-Message-State: AFuF++moR6OWp2BtKoDAvbtqgYpTY8cV7lnHfqjtmNXzAb+PJ8zKJfGr
	M/7/s1Zy+zGl8vv8Q5G/AEBmn3MuyagXdwykS4jVBrfJfjX/fzmxF6n+G1bWvcKHjTU=
X-Gm-Gg: AYBFou3tF5Zt29l6hJdpg6VwmOszz21VJgwplrS9chgEfRLXlpmx4rtBJua1rrWfAJu
	ohJX8+iY8HBwe8vFZo48dbsts1Qxtm+/XamE6/pjmr7Gsntp3YKZ4Qddfo68CmswWgUZDSQZ92A
	NsGcYKr0MBGpuQIsmZyWlWOCmmBtTQhGypSzgHKQZ5mmI0QRNriFipqNi1Bj+ByM66fuuGr6hZc
	S4VaGPOc3HMDXqEFfPRsU3L46fQM8L1m+mbPlPTQaCtkr9OKKNqVjzZhjXnjg8W4nISKyoTK6YS
	4kFl2VSMC0E77g2nUqJSLffIc3bSc4qL/Bw8EGAhBk5qE5H1n4hIU961oZfb4hBrucq7TF+M+VX
	sj7xN0Hah21XXAZ3zTBz852Gq/uZPa7+l7ILX8lxX5UC8qN2f8su3uRNwaws2hHmai0Mi5hUi1R
	+ACCwtmnZ1ZNTL7ws/1yxsyGYW/A1upVn7Bp717Jp5N1TZ3N/aRgkWiD66oA==
X-Received: by 2002:a17:90b:3808:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-3990f88aabdmr64927a91.13.1788199868925;
        Mon, 31 Aug 2026 11:11:08 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d76622csm765959a91.11.2026.08.31.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:08 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 robh@kernel.org, tony@atomide.com, rogerq@kernel.org, andreas@kemnade.info, 
 aaro.koskinen@iki.fi, 
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: Julian.FRIEDRICH@frequentis.com, upstream+omap@sigma-star.at
In-Reply-To: <20260716113947.92513-1-david.oberhollenzer@sigma-star.at>
References: <20260716113947.92513-1-david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider
 definition
Message-Id: <178819986814.2869653.16668434348928229188.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Thu, 16 Jul 2026 13:39:47 +0200, David Oberhollenzer wrote:
> Commit d0bdd8bb7f35 ("ARM: dts: ti/omap: dra7: fix redundant
> clock divider definition") removes the clock divider definition
> from optfclk_pciephy_div, reasoning that the table is redundant,
> as it contains the values 1 and 2, while also setting ti,max-div
> to 2 while ti,min-div is implicitly initialized to 1.
> 
> What that commit missed was the fact that the values in the table
> are in reverse order, i.e. first 2, then 1.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider definition
      commit: 2fabd2f406d0cf787be47b3bbeea99b30004033d

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

