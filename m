Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719734;
	b=fiZaLQ0uKnsgn+Vm4Z2lQD1v8vyJBfrk/zUM6IONvTyZCF29sXGlIsJ4brivcPhK/j48
	 KOFIORJ06oXzBpKNydMickkvBxJxrmxORT5/mpUKVsvrF6tAzTpUSz3xrun516qXDduRJ
	 3G9Bmulx+1tXNdCqJTb+t6YJGTtnBWIlIKiL7yYaE6sMCzTV921QrdioEPQZeywy1wAFF
	 bFYDGcDh3pXmVBHU8UH8LE0+8cWybRLkYTCvfHZlX5g3+iEHI7scOcQmmPvQ4x5jifo3e
	 jQALCTwWd5bzCTlS8mEKRWIqZiRMQ6ej6w7FJB+U1sPXmgiWSTg7s3l+IcFxXLMr1Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719734;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=MaDKxSnnoTZ6c9zF/kIcDO7qewxy+q8wpP7dgbKHb1c=;
	b=vSsIUXDrKHLiiuQck4w7Xhg+3fi4uepPGBlhGpY8odG8V6D2vsv2G2fxfWb0DX2p8Ni4
	 aYuTFnqWhGfuzV9zRhsmrvE+Wemw1hYQq5vJb+2WJFJWMkadkP+Ej/bzmfZwI53kNphBp
	 z2A4LtV/vD3EaOyJ/p5RkwOUPx8cwub/7PZUxy7xXEiKq6Qbsh2Drji0K+rQ9UR/WhRfJ
	 Olb/TygLNbrXKsiAoD4JVpGxf17O1fi3+ojQU9CKuLajqeYIvXGwct2wjsbo746+vPqKq
	 nCzQp+gCE7YhgbDpJUAZcdVGFLdkBK/AyznvSUYmzTad66bTEYLOfX2K7dKPpyFJ9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA8i1aJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9B606A31E;
	Thu, 26 Nov 2026 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA8i1aJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFD81F000C4;
	Thu, 26 Nov 2026 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795719733;
	bh=MaDKxSnnoTZ6c9zF/kIcDO7qewxy+q8wpP7dgbKHb1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mA8i1aJyvLdmspwkbmbX6Tx9XBgn+AURpzpkF6naW6HgOkbw+/YKIyBLNoixEanTV
	 QprQ6kB841ppWyAu9e2IJPpS4PLHIk5k4o86nwf6SKqlz6oXgiT8fpbu6QeP8Wfarp
	 zgJV+1tsVE9zB9KZok72MP574yqTR/sHJlQ8kX1DrZRoubPHcdiRi8sBcm0L9Z5u/5
	 V2Pj7YfEz2QgaTYvNPok2DvcYK9IuAVczCpY03dLK9vEkc+Pc9EsN7PnNNp4nVoFbB
	 WwWVotI7Wlp0XH+0oGjGQRfw6QIPonujuS/m1P7HZv/8Srhclzexxj+00DmWBVPrZZ
	 Dw31b3rixd7WQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kai Svahn <kai.svahn@nokia.com>, 
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
 mfd@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, 
 syed khasim <x0khasim@ti.com>, Tony Lindgren <tony@atomide.com>
In-Reply-To: <20261119194939.2436337-1-lee@kernel.org>
References: <20261119194939.2436337-1-lee@kernel.org>
Subject: Re: [PATCH v3 0/2] mfd: twl-core: Fix dangling twl_priv on
 teardown and probe failure
Message-Id: <179571973120.19173.11479797823577819756.b4-ty@b4>
Date: Thu, 26 Nov 2026 19:02:11 +0000
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 19 Nov 2026 19:49:28 +0000, Lee Jones wrote:
> These issues were reported by Sashiko.
> 
> Patch 1 is the minimal, Stable-suitable fix from v2 (13/27), which was
> skipped when the rest of that series was applied due to a collision with
> "mfd: twl-core: Unregister the auxiliary platform device on unbind".
> 
> Patch 2 is the follow-up suggested by Andreas, converting the manual
> twl_priv reset to a devres action.
> 
> [...]

Applied, thanks!

[1/2] mfd: twl-core: Clear twl_priv pointer on teardown and probe failure
      commit: 1d73299e237f7afa88f5df8edffc135f768e793d
[2/2] mfd: twl-core: Reset twl_priv using devm_add_action_or_reset()
      commit: 2d66287fc824a778046241d589c3220c64a1a677

--
Lee Jones [李琼斯]

