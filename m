Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268103;
	b=S1EtS5ra8EfH6C4Otqz1vPLSImMcHjWw/3Pc/Jq1ixjgrapCgOwx9xmPRigHRDp0EoC2
	 xYowoJDboKVTLBb03UDKns5P1pZl4xmum1Trg047SzA7Gy5re1UzspSCMWg9Tqt7HcqI9
	 WTuHMB5E8IzJ4cyEpUjwg0CMXFupTwRf8/h6HjcMtnCJmdiMpESWUf1k8rQdXx0SHie4e
	 a1kGev+oKxZe06awzmYKDZFTdIwfvBLwJ5jArymMxzBSwG1z5x2CSr0HgmTQ9P+U2RjeP
	 QHPepiI0RzYIYJIQV67AcrQO6WdeQK9qasLd50ofetHhwRSHSjHEFjybrIeB+EOe9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=+skd4ReZXdp3+ybDH7k1AcOUqtthV7E8Fkq0B8eZiX8=;
	b=RGIDdi+o+jjFKXyvMl9HBXl5JuDC6/WtN73cNjrzJyC3NSRG41LsArK8i4fO0ubeEtZ/
	 Sq2kbss5fxJHeIADrqkkL4acl84a6JLbJn2NQ4zzJGfK07pDi7rRiXPq0zxg3FVGdqPvv
	 BQnXjgi8yFg3y2CLq/eFW1llAmQc2xROg01WWU5k4ZPFsClz8ruv25Pg0YgXlPZiAJJR4
	 RMRmL/JgXXkbVfO9JkkqyfKGsbPgcV6sdoJWEDtu7Sa+hCVybMMjFE7YwEQPym57Jva0F
	 gmEOkmuaZw3Z+qaUZjqhrJmOP6QiyI8sqdDn4pksdHXQNR30vyPshlDVs2Ur146PnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PyWZKKGz;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02134606A330
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02134606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PyWZKKGz
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e985106c0cso11259135ad.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268102; x=1794872902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+skd4ReZXdp3+ybDH7k1AcOUqtthV7E8Fkq0B8eZiX8=;
        b=PyWZKKGzuA82zaPBN5BfGWkb7P7ViZ+nEmaWr5iv0VQfpoB2ZZTTtIS3L5TAHM1gsF
         5i+mRxqj10Z+rCVaq8x7AhIp8P4SpwpIdx/KLZ1n9JXeQh5baf911uZbK/8NDuYzXWyc
         oVCGSyrSTCWr9C3gj3pScM2g7gRiF8nVJ/b9wiRLgnQzRtulS9lF8Rx7eXkFewAM13Qb
         IuJg+zNhGeFA1BVqdaX1Aqe2tXZS8Yj1Maztma9fLuyHPiIranj5f8rlte4tKozM/j6X
         +UL1tXrxLrc6M9dNb/h75mbi0oGENyVrMACWegcp8mQZ6H6v0lnZmZ+rofUa6SwuTxwk
         CrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268102; x=1794872902;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+skd4ReZXdp3+ybDH7k1AcOUqtthV7E8Fkq0B8eZiX8=;
        b=bTqQakyIGI+Hwmy4ORrLaMeTzehouc9dQkLbWbrP6gYGmElokaFLEfEm3flp4qOnga
         h3OPfh/J1QLQtsmcpePLRe59QZDYHsEHMDFw8HkQL8a/eVe7jHYx8lq1hn9HQ49T8qTC
         UC3ut0OR9vJSc01vh2pvPSpiNYMjEMOTCKiuONO0GWpo308kUwgqk6b4nGjJrP6psbqs
         FJ9Cf7QO2sbhpxYgtKyIkvFPJ5kLilYRrMS6UZlZceFAX6guyeYwq83heDUEEZV/vwPN
         6Rsz2KT6WkPs1TPnZyo6+JhnAWQezURpbqZ98Q58iXN/8NMyEYTN8TS1sKjdFiK6yUsv
         OYRA==
X-Gm-Message-State: APuU4Z/sOxlgWiCP/X8H55m38YqskXIRHv2dVp5k//xbWBFvx2fsT40B
	23lDoANLPZAzmtoCs3lnoWahmn9+2ouK2MnWYvqgNQ5xmtg1ZQpJ1Lb47fzM8vkcKgs=
X-Gm-Gg: AYBFou2FyyAQNNfP0Ur3Ou8qNi6CSGSb3/XvtzUbXiqHPT4rmnoR/riFgzOkaTYFlhx
	Bh1Aw6/AD2gDn4zwrhyEiipoXfJ7GyrYljj7nU+9ITnHoHtiPWSu3yNIZ0t0q2Pc+cBG6DF667M
	eDrAisLi5WescFMUGCcvhj93UNM09dA+Geg94eTwLypR3TfzJnYzFY/BKNXOuYEqBKtefCm4jWH
	SrtHCKUdiY/3D0PGAsdwe1rZmT6zO9JUUMtOFiMPyMgMse6BizB8kA9m0Pez/GgBpH9SSabddTj
	VZAl9+E8nyLPbm1PxqPnqBlNR+XIdCDtZ85VzB/ZycHCHhbd+srDF0xyj6j694Y9WWuUDpPw9Ng
	8AA5b+Y/hTQM6HOE4zpwTIIK3ckdaiSO0BSCQkOMvHfgn0ALbOvngtfQNQArmKizNgxsOH3DFbv
	Mw2m/fKhVDJjsOc6XN6Nc7TF4OOpGwaxt4miVspkhDsje3sRcfWL0sN4Ap1HlMPlKor4y6j3e36
	L5klxLCD9A7+Egy261CkS/S562444B8ASlVIk80DXkb9WtoEhkfnjVAWN24SVA4gSFCYbzDOgpR
	9leGFU191zyb1vJbfIYH4fDJ
X-Received: by 2002:a17:903:3c6d:b0:2dd:ad73:c93a with SMTP id d9443c01a7336-2edb9246e43mr6572065ad.27.1794268102310;
        Mon, 09 Nov 2026 15:48:22 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2edb6e108bfsm2626145ad.76.2026.11.09.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:21 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030-patch-ektor5-dm81xx-vd-v1-1-8ba90608c25b@linaro.org>
References: <20261030-patch-ektor5-dm81xx-vd-v1-1-8ba90608c25b@linaro.org>
Subject: Re: [PATCH] ARM: OMAP2+: ti81xx: use non-scalable voltage domains
Message-Id: <179426810111.2265990.13077488859947627237.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:21 -0800
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 30 Oct 2026 11:40:30 +0100, Ettore Chimenti wrote:
> TI81xx SoCs reuse omap3xxx_voltagedomains_init(), which registers the
> OMAP34xx/36xx voltage domains for every SoC except AM35xx. Those
> domains are marked scalable and reference OMAP3 Voltage Controller and
> Voltage Processor instances, which do not exist on DM814x/DM816x, and
> no PMIC data is registered for these SoCs either.
> 
> As a result, omap_voltage_late_init() tries to set them up on every
> boot and bails out early with:
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: ti81xx: use non-scalable voltage domains
      commit: ed20363e55aa1ea0dcf865f6776354f1628f5375

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

