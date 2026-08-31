Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC2420488
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199886; cv=none; b=oYB0M4fRZ29CTTGurcwsgbPU+YwCfph+t+808A5FCh+imTZyn982gO7sgBsWgBwLh3M1hNLhXkhdLNsJIPeH2nLnxWu1R0vS7y6QotxcaoZxRbiBTyXabDobUr6E57MpeqQSpESSNobeq/HU0CG2j/AfpQYn5k0Uwd/BbuUWLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199886; c=relaxed/simple;
	bh=//yqev/fe+TJRoxB9jobDnK5NwPcao96GrYOBYekoR8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rqkTS7zZVhO1gRbigrH5ly9cerUxDNexsdwuVJHy7imxEZ2/EatIiMGdOG/bbvSkQ3tetn6sbctD9WuNJe6yRjx7F4y0PZYStS/Qmo9WYlIVK0lp0Q+13lv4miqNNZgIkPA8Gy82BTQZZ0cjYIvg6JOAKeXgBuo1KTm8hNUiRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nvV9o3Rp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nvV9o3Rp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso448319a12.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199883; x=1788804683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OemJiih1sslqSbQP4J3cbLzB8Lyd73Gg/1M0pWEdtY=;
        b=nvV9o3Rp9TMITZ2+7P5/845axrYh7W5Yz3UxlNX+0lcxuHdrU/xZllck1FpjLHCwvH
         r/68F45q/Fh1Ya4BbApn9TYQ3E/d4RqGvtTQmV4eU92orZGhtPyU/rDg9c9yE3UtLg/C
         BlhT5BH9UaCWTQ2gb2FzCJo1sPwxBx/K8QpS7LspDjtiwMP/1JC5BQaaEhD3Pl3gzu3N
         xn1SHD578jK7BodfJDBteLY7onvvZIe6zL+sRCI8rLiZqDVLgW97F1ylOr1anAmtE5f5
         aouknvh9ZUHux2Uk9FaAcvC1TsAIJXwRgrZReuBEVOsCQGrzwsCD+iSuVClxESqeXOHs
         7BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199883; x=1788804683;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OemJiih1sslqSbQP4J3cbLzB8Lyd73Gg/1M0pWEdtY=;
        b=R79UyQlWPZoEgRsWpB2hhc8+gTVzOcS5lwC/lWXeOjrRkNpTIrgJ+ihr7Om6Z30qLe
         2s62hwlrhKf1w/KgD8llw4K/NVakoA1ijtQ6EHvMb9v57mCMmLM3yW+k49WYN8cJDJ3b
         Z+DIWyUy719pfeuWr5XHi5DczLtATs4cgXB/KEVoim+2jnKiV9HDddEmCSB6+mfnLBjC
         B9WYhPQhGypoZK7C5hfLTyg/jTyNLutzFwtJ4VZ0RGgVIhLkJGhltkF9W/yUW+TxAz7R
         dnZiZ9etMRg6rg+1FZ0bA0K/cJ/Ly4SM7ah4vp87el4z7LWwA48ggF2+wvc8xzA6bKJJ
         f0ow==
X-Forwarded-Encrypted: i=1; AKwUvBxehakUFIFGc3OFvAdVRjkf9TWKY6nbgftGn04HNYNIL9YW4lZtC11wklWv1fS4QA0erPdR+PAmw+GR@vger.kernel.org
X-Gm-Message-State: AFuF++lOoHI/Ym2f906bwvZr+5UrSx+9nsJGqBuppJxDzXswBHN01XU5
	PQojovR+EdnMoDOJQWYyPgmREUiImkSSJZgiyWqOyCEIq1g7Wr4PTkvX0CXiB0W+VJE=
X-Gm-Gg: AYBFou3QSlrR3YY+GU9/0Dn/TQFShqlEPS23WBA1RCY72VpVlmhUoivCHaM6TIe2yxO
	qNv9gI1Lj8zsoLY+DDT8QNVoX4VFrVNJDkNmRI41uu6IQrG1AIf5+E45Hj/c1FAFjlrB/eZ7f9W
	a/X7tn5sD6HC2SVxh6oRmMJrZgk/0rn0R5dWhpAg2g0dpT3mbQPGbRB8aLN7YsNNcVe/xow6oP8
	ihSWYwYoaNLkBRDP6SEndNLFJf+w+wye8PNJ4X+4YULwTSKoGGURMuR53SKtDKBekSeyJOwCMu5
	HL4Qm3Ff7WHN7bMKTOzGf7hgS0fp3SwosC1BYFrf/W5RmR0ZFQ3xy2a5kJGcqThcHC66o3X0vhi
	PrIuWkZ0LZE+6fLBCsBpanZlloOaxRMYHQL+toccqhLx2tROTyIHmtntkMPEzsA73CZG3K1l/0P
	pupfv1NhAVaBAc+ltrR3qxBHfbDunxQB4Ku6lQ20tOGLHV+/z1DKkijj9gfA==
X-Received: by 2002:a17:90b:4a02:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-39907ab0960mr2402339a91.2.1788199883302;
        Mon, 31 Aug 2026 11:11:23 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-398a2f5187fsm5504006a91.1.2026.08.31.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:22 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260829194003.107677-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260829194003.107677-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: Replace spaces indentation with
 tabs
Message-Id: <178819988246.2869653.4070159664676583942.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sat, 29 Aug 2026 21:40:04 +0200, Krzysztof Kozlowski wrote:
> Replace excessive spaces for aligning indentation into tabs.  This will
> be reported by dt-style-check ("[mixed-indent-chars] too many space
> characters in indent (more than 7)").

Applied, thanks!

[1/1] ARM: dts: ti: omap: Replace spaces indentation with tabs
      commit: 973ca75604c81c985224624f685f0365e1ba78bb

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

