Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158654;
	b=m+UBDCqwCor6Hh2WCv92qHp2O/ZAzlnVAHRrZdcyruxzG7O1RtApAEjLEas/TFqi71Ci
	 9zAN3X1U3V8FI7jzrbnZBIn9r5BPWdlUL6mwuFfsQmg3gKEzkC0u4lCBfwzZC/f+4WZxJ
	 ggcnlZOuP7Pa+iIfr7XZgtU07pJ08U4w2oBHssp9WKGG1aVBfYoWcSYN481Pxl3doVIQh
	 WtFXuwf1twVNSbqSYU1VhkffyarwTqdfk7eAZ4b2wFl+IjOk7AYR/ywBaSrEqp0uYRsAB
	 bjADzYcZ/Ijtbe8QchNIzEpwi21av8AM11qonYjWx4+Mh5SbOPtZMckubuScWZzXbVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158654;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:In-Reply-To:References:
	 Date:X-OQ-MSGID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=HbNpAbrZVEZQTlmCEV2LYqZfmhBEuxDyUHjVFrUu/Dw=;
	b=ZfALoIpSRVAuyuHIiRprGByb19LKEC1FmNWD0hkyRNmOTDyRfzeU6ROp/4CFL1OFP9ya
	 YNkAkUX6/Daal8jBGsK7FFaxyP3tOr/YIu9U9pJE60zh6UwtQHHUVxI1q7C4gz6i0svRk
	 djGoAZfZQ1BzUbPMKy+SsavupYyVHi8lTHggA2hUyPdZcjmu+qBZRe214yZANuwvJ5sAM
	 dPyoftbTidJNM/Gw/GNhUOXgSn9C3L7kL4yqhFCkUUGaQpIhsNei87owbNmDRvKLl4d50
	 BFVF+K9qCkh3HFYbJuclKsOUzAvHSsN4ZIfA3s5SIa+7/+B5Ix8/6T7GrYoeh6LYTvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=MR9U6oZx;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADD606A33E;
	Sun,  8 Nov 2026 17:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEADD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=MR9U6oZx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794158645; bh=HbNpAbrZVEZQTlmCEV2LYqZfmhBEuxDyUHjVFrUu/Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MR9U6oZx6DgD50LJX+pBj+h2vxoP4KD6JyvS48TlLtKqYMyEQnieoTzhy6Dfpf6RY
	 oe+OIqLytOOmkqO8KmVuqMzYce58iHCn6A8jh0emO3skA+Y5tNFYz9+U3HcGO/IOFV
	 ZYIqRGWgbKBLT2vG37EN3paHTCQmocNk6SgBIXOQ=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5F906C5D; Mon, 09 Nov 2026 01:23:57 +0800
X-QQ-mid: xmsmtpt1794158641tzukiaruw
Message-ID: <tencent_A1BF4495D1F5E54524907BBA2A4ED480FC08@qq.com>
X-QQ-XMAILINFO: NQJsl5QovJ//diN/Mrg6brYvtP6sEdsD1yFOwDkqqSRL/drc/dnK8D7SLPoCcc
	 2/QWI5q1buzhzfLlCn9m90dyi5SBT5N7Ws1U8tCwG8XKZJ1amKZprNexE1TTvvyl1jR0cflLc6nf
	 7gj4432lrkVFkjTXfSdxvoC5yrYuHXW0JvUWs813mUoBodgk6a33cvmNeGJrHS/EwE347tTKlXSi
	 27fXEQ2tCwCLSq9mEO/H2LQmxCwBGJ0RSd8mqOadHc5neu6VeIFm0MLqVCUkyPvbQxWK5J7WuEnM
	 nvBQvWCyQNj2vgxuyIvhjz7dev6Muwj+aa8ZMJaAJ9uI2QyaDvEe8dKxk7xJjroDphqK3io/Nr+r
	 k0jD8bN7Qv3yVOgmQt6zBgDmCFevr77tiSYTzimWTaxI8wnFoG06dr7nKHhy7iNTLOhVkQvudDz/
	 hLUwbbavm6BRzdYUaDMhb6KVZzV5EQGaW1WxuqyCy5p7ZswPvHjH7Scv40qL2xThO3ND7aQmd+N+
	 J6ais06FoCePQOpbQ92v9LpwHstJAnOh6MbWzH2aA/Kepp7X3oSjSXC7V/3YlkqJlWY3MvIQbbWU
	 NgYjLi3fDfr0UUUpZHeDmYbi/mmVVp5XbLqhKrqvrIrS9M8SKj7sA74aPzdV2R5ximA+M0tPjl6n
	 jHCozvAAEoijsWwdVzfk5QaxK8sPier0nczUGA49UEaDiAPh59qTxeiA9ct1+gz5jU7TXiUQOnDi
	 hIZwGIQ9NTu7FlyIUZQAVerLWAQOo/ZERADw+rkw6o1/iH+CnuuyVaQTvCsjPVVVosuLHo9uaPI2
	 0vUCtdcfbSmQDu7JT5UIa6aR9AqDu2xtGtheKnMcnOxLX5SKHQ2EERc0A8tGP6nnaGEcAYLCOJr5
	 /QUQIO6tzBiFQy9rDYKCeWZSO8qg4tjdYA2c68S7y1WpxEf1vxtGk3mEGtxPsyJAOOktiUErJaSZ
	 Zk3CFeuvEnhqDk49wYG/E3ihW9F51idglGPvdXO4mPqzR0eCvdtpJX+uUBeHM040mFsIfmREotxe
	 QLEU+9jVhzGtckxvE+n2qmjFdgL5CQcsVN78RlRMcl2AxDVGntNENdLvqVW8k=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: Andreas Kemnade <andreas@kemnade.info>, Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle clk_prepare failure in probe
In-Reply-To: <20260820154323.0a7c7929@kemnade.info>
References: <tencent_B4F504456790E8BA3C4EAB80F4BFB6954E08@qq.com> <20260820154323.0a7c7929@kemnade.info>
Date: Sun, 08 Nov 2026 21:22:12 +0400
X-OQ-MSGID: <179415853265.5.12140574398809517213@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Andreas, Markus,

Thanks for looking into this. I don't have evidence that the debounce clock
in an existing configuration has a prepare operation that can fail, so my
original description should not imply an observed failure.

I'll check the clock providers and the devm_clk_get_prepared() option before
deciding whether an update is warranted, including whether a stable tag
would be appropriate.

Thanks,
Jiawen

