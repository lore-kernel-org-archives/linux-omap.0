Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268105;
	b=tw7t0BRIAH/wF8IQgc2qbFjO+dpc+8kNr1dLTc94NZ7IFKVlzd7DA5TRTrGIi5oLxlNI
	 AUPl/rr141rf4l6ul77eKLeRYpDcE7fwozVTBhA/s9lfi5eAqI4wv2c+ai/sUrdnEIU8Y
	 vT34aW1Q0vc1QcH49cfQAHWg16ptItAL0I/6iWVhQi8mQOvBqzUa9KSvbJKDPjc/oPQc1
	 D8X1VoT2ZltvX6eMRc/xtPTzmVrvV548yD37LL0C5lIpMTVxSAZtemszq43xa6b7RVtXJ
	 hVrrkPNmXAuoFvbymvfEEli8YTgBbQOTIIxxcmw/KdkjS0mcArIVVmNHS/zGuMlWIPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ijwWYpzQDAx+cj1CGF6sEPYVaJ2fNy45DbFhO/CRy14=;
	b=Ryvmmw9Wu04ZLnnY754JDlL5ROAizEPUdFIC+NhEtgz6uxm5G3FaRD99BZmsEf9vZWp3
	 K6DroR9cd2q7UOLT3mpOqjqg3hQcGyvbIQqYpi1YaIt9jRDfNNsOwEwTBLVKM6M0l7RbU
	 B6zzXHvaGbanAbPkU6kL0T/Idbur9xfrR4EROSNr9Fhx0jOamhOPg1zZC5qWdQl14c7ZL
	 QWKZNkvCOBkSuSHEkanLy8aWjuVnr87q9rmvQ6AoBXoH+hTQlen8n3OLlGkJX4nSAg51A
	 0sIFPhaFSQVepxuKx6+SdGWvJ26w9bGm/GCgS6UaK4dvQMjN/D0FPXyjAI9z8F2vDoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Sfc1zqmY;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDD606A337
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EDD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Sfc1zqmY
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b904d10882so624584b3a.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268104; x=1794872904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijwWYpzQDAx+cj1CGF6sEPYVaJ2fNy45DbFhO/CRy14=;
        b=Sfc1zqmYTKpury5dmrguOwJHgijKhgPSOMtbSLBEkrFjUJoSHyGiUr49zJB6GILDxY
         hZ/PLdHu5mzLUBwfro/FlqtPwYACld97cwPlNBJUoMEJA5uUxc3ICOmsAk9tV0V01GVf
         cfl7XL0NeTP/CseHktJUI+RGifg6lTyYZHKTLABejvKsm+kVS84tPODSzpJVRjRyrtjd
         8JJ5kJrGNR1JAZG8kjkLSOCwkZlYeBvz/SyyJ2kFhXw4UDAs3MxdpPKqt4yzz/semOQY
         1NpdLTjh4YGA5T6G30F2w43gs6HoBvyC4qxVPRHyv1+QGmdqdVxMj3Ih/3IUVIeeXAwI
         rnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268104; x=1794872904;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijwWYpzQDAx+cj1CGF6sEPYVaJ2fNy45DbFhO/CRy14=;
        b=DlFCd8Q2w4bLUPWgX6Kqm1ZRpzMdVFgZOA1DDqmujQ6E23/V9G/mbwfuWYEwOKY47d
         yaPjeHTW3f9TP1Vf1qy9eQQ/i+SXKTrGSgOO9juM+hmN9dQaWwnxXz6qaqP6Qu0xuGQa
         MoiKQ2khHD49HNQ5tRkaNh89culsN6HVm3YxlG7WcYoMfLSU0HqLWdAuttXtAGSGn6Bl
         nnvKBe2ifgWMA7o6i80QwiRivVfTH3QRhwjwy9Niro/Fw/mZO0qNA2YcYCRFnp9kqdpq
         1XQpQtGVAqxzCjYwV/EAKAw1MYY2gYNTG8KrCWaQ6b83vtEnuUCl1SuGT/0PBOn9SqSV
         fqcw==
X-Forwarded-Encrypted: i=1; AL+hErGdYn/28NQyySHEDuifsWIH5x4rp+tYRvC1z7+cELH1aDPcmpusWTu3kXI6rL9axF0aOr/zCGWNjyZ4@vger.kernel.org
X-Gm-Message-State: APuU4Z+ozK9LcW2BzDfNEu6zsZY9UwC0lsc8ZAP1DZOWKhA3w506gm+Z
	krfKQij1aqgEUzR4/E1w/TYy8+3qA6AOvS3jhzx+Oibphza242qm54dmjpwMd25SS4c=
X-Gm-Gg: AYBFou24KXA708BoJkSF+RCTNIVB9z4rKNc7v48QabeQHQitBnIJUDVYpQwiAIEpX/w
	vNo69nCclwYGO35hglroRNODVGiL9pi3fG1Jc9b/1wFCfyUNLwroQESKRVg3TVwLRnb1BvOTraX
	jJ2HWzck0hEg62+R42zyxizT+sDk9iC4lMneBMzAFGxXkri7m8Utr5zP/ZljaEcqVai1FaiLC1z
	2aoy95y/rCNoBFDzqob9fPpqrGCiG2m8dtGrHSv09osDBj8UBd42RduiBEVggoZU/T5TJ6dfAjn
	bIdTTDygs7SSuqy7g4lBL2Sfh59HW+9VNwlfqA6oVV0r6wzG1XPO+Z8tjDHqDjDm6NePjKKC9iG
	8Kq83wspVSb6wX1RJ6sLQZ8YhFum+2g/D/zgRz9GSV5d3IQPm6R8ezNCjYkF4sGxVihjFpBWQ7v
	QERt0662nO2xxk4EztC66rP1SarDtc9+ecC2Oqlb+eq8WopSmB7TQbPKSvQHe8dUqn7oKnL2ffe
	kIfp3/Hg130XtgGcbn5hQqrY+x1JUOMPkDhof71JYn0eI+/r8GH05+ODmI3zg01Sb4xaY2kXcdg
	tWvZ69aAb0WxvMqjS+6lTVxx
X-Received: by 2002:a05:6a20:4326:b0:3e0:ba43:3d3d with SMTP id adf61e73a8af0-3f18c10ea0cmr750328637.9.1794268104158;
        Mon, 09 Nov 2026 15:48:24 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cdd8d67e52esm204829a12.10.2026.11.09.15.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:23 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: paul@pwsan.com, aaro.koskinen@iki.fi, rogerq@kernel.org, 
 tony@atomide.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20261031120519.655248-1-andreas@kemnade.info>
References: <20261031120519.655248-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: omap: omap_hwmod: do not WARN() on missing nodes
 for hwmods
Message-Id: <179426810249.2265990.13290382980271745471.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:22 -0800
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


On Sat, 31 Oct 2026 13:05:19 +0100, Andreas Kemnade wrote:
> If devices are converted from hwmod to ti-sysc, there might be an interim
> state with the hwmod data still present but the devicetree not referencing
> the hwmod. In such cases, the hwmod device data is still there,
> the hwmod infrastructure does ignore that device but prints out a big
> alarming WARN().
> Be more silent in that case to avoid needing putting devicetree and
> code changes into one patch but into one series, only require the
> hwmod cleanup to come after the devicetree conversion.
> 
> [...]

Applied, thanks!

[1/1] ARM: omap: omap_hwmod: do not WARN() on missing nodes for hwmods
      commit: 540f8176aaa989b08eb66e4d5c4d4ea9093c1f80

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

