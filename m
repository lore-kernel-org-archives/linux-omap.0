Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEC522F0C;
	Thu, 15 Oct 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078255; cv=none; b=qn7A3afwWyaRt8fd1zBf9PUAvkipSdTyRrGJrDOHbqZtZ7wv0M5DBPVLl0M8Dje+Oj3f32N+FP2qB80Y4vAE4FSM5qbP3arDkANGEQEEDoq7/XWRmQ+teSZBGJHagKCuFPAiLRtqSAakh85WpaIIbOK570FzWeD87Pp9IYO/nOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078255; c=relaxed/simple;
	bh=kmUlqeMV2/Ot0mbVmwfQrxAxb63qLSZqwxnDQ0wOQcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JjZ+zjPgalJi2cj8fATaOtgC6+QDsrUg2dcqJNlT7C3Lc/Gzf4qsBCcaD2OKkPmmpZa8AM0mz+7K8RttMMp4NhdP/uvv1I/emFKsmGL1tWN5p/jR+dq4huP1Z8LxclonlD1hN1ItGaTK2RzxSFfoUg/aXopmh85wDX0GAmXfz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmUEFFI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmUEFFI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBB81F000C4;
	Thu, 15 Oct 2026 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078248;
	bh=8PJTcaF/y8xSIxfiP8CpjR6gqiEkMX8vIMz6UcO+m3c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZmUEFFI6H9xgE0EnwoHZr2TpvKTIdQwAwkXGFGWZPJwueCY5bQxEYTIDS7kC0EXpS
	 GatdHF9Jt5+P5nCfxKaMXlgRrQq6teg2yjWIptVE/dSnBaKeZRtU5yiHpdQLkLqWqw
	 9Q4XyFvWIwRMi89fl9MmlQTZW/3WnWGV4jdgV4YMqBcwXKSkdrXe3Bk+f8P4euXoWV
	 gDmKZApzBIXOcf4PmNZXZ8m2+YfN0Hw9mQvkRlcuEIsLQdytqGPnFI7cq68KkVQW+5
	 D/v3PvF9T7ZA/nB1pITaRWKpc2iXwrjkNKXbk/28lfWRKHSuAVkR/rQ25PSFwVoeqy
	 Tvi4vvkStoIpQ==
From: Lee Jones <lee@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 =?utf-8?q?=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2_=D0=A0=D0=B0=D0=B4=D0=B8=D0=B9_=D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=D0=B8=D1=87?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, linux-omap@vger.kernel.org, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20261002113624.178588-1-r.zhambakiev@prosoftsystems.ru>
References: <20261002113624.178588-1-r.zhambakiev@prosoftsystems.ru>
Subject: Re: [PATCH v5 0/3] mfd: tps65217: Handle IRQ initialization errors
Message-Id: <179207824598.2059305.6769856473362990890.b4-ty@b4>
Date: Thu, 15 Oct 2026 16:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 02 Oct 2026 11:36:49 +0000, Жамбакиев Радий Рикардинович wrote:
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
> 
> The TPS65217 MFD driver does not validate the outcome of IRQ
> initialisation and failed write of the interrupt mask leaves
> the software mask out of sync with the hardware.
> 
> On top of that the irq_domain is torn down in the wrong order: the
> remove callback disposes the mappings and removes the domain before
> the MFD children are unbound.
> 
> [...]

Applied, thanks!

[1/3] mfd: tps65217: Fix NULL pointer dereference on IRQ init failure
      commit: 0473a5b0663663b75573bf284beb77459e07c461
[2/3] mfd: tps65217: Check return value when masking interrupt sources
      commit: 66ed12c1e5a986bee1dc63f9bd9c7f068138a69a
[3/3] mfd: tps65217: Use devres for IRQ domain and wake teardown
      commit: cffd44d2d89524e2dda6adc7b0dd59363be1c8e6

--
Lee Jones [李琼斯]

