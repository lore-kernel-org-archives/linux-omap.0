Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87A408614
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199881; cv=none; b=It4zc7AWbel5qZTEeXYWfs61Sg7SL2yKvhyfwLxGrlvO5AMhy70lWqOwKvN8QAFkeUBVJPNaqlHwAehk6PeAvHv4j5c3QAvEU5Z13izmXwtLhlKqc4XuDnkf7wap3uE9WfPx42P8sGjgHOSjhGoiC2CUJoiClmCya2VwYjm/ZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199881; c=relaxed/simple;
	bh=zBdK1iiFDwTHqOyTQyYg4l3HxFz9CENCyVT51LTKz4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T56XZEiuM2E1urTJoywYIzrncw0NhLjRiT5muos1UNvTrE8AdQoJu/RZWoIIDWy108CbegxnmkMtpTkNyrsGndHcnYqHVGtLiyAUP73teHkJfKm+Ex8G1+pCGtgIeK5pMHGrTd+SHdi5wQq+DQO1vIfXbUsLEtlBL67jAAINTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gdHa3F4O; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gdHa3F4O"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso62704a91.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199878; x=1788804678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYKJ5VPlv39onDgpizRA6tuCgoTPGQMQ0bB2xHAAOlw=;
        b=gdHa3F4OGPta8Ku4hc7pkSHi+zcYreUvgF2rhRQVSZ47n+ptJttnJS+mb+aFmLwAxo
         18lopdAfAonfJtlyWxoxkDu946+C8uJXa5KLYJ9+nr7+xha1L8pRdYX3R67lcfIrsuvv
         YwvrYs7VeqInldCQQPUFVgFjsAwbCCQLwg8h9qlLBP9fGKXheUvMOKP62KzTQt3vR/o0
         LSO9tQAJFoJwCpSeh2d+JdohwgxHnADaUC+2TwxxJoUfkOv1ZEulGfDAQa/e6+V1ogHh
         KDPvWBaf6Xlx/QMQ7fUcxrYn5oIjynFhw7tv4Z+j3elCHnxLHxAFlJ2c+z3GcIpLXJPR
         oGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199878; x=1788804678;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYKJ5VPlv39onDgpizRA6tuCgoTPGQMQ0bB2xHAAOlw=;
        b=cs+8Li8tU11Zz7us/oJest6Z2PuybSwS8f4zeM3+UijjILQZUFj3KRtpYqT+VKVEw0
         lRUnAjSrSxpdTjVuBlhXdSjCmyzBQgrYhDBfuk+GeHHVaGEw5TOiQe5LPV6Y2NsVyaqi
         WjkN/fPYKu7HV/r7KQxgZaWR+kzjytbpfPhJ1Snq1A2Rie+JjYUzsMFPhNchzOMoSMbD
         5JA3WX1mFerP8CFMRzp4hV71yWNBeNVsV+qAu6NTx451quaFE+62g2DphASxqdVTzHiK
         NbawTVm+0bupMDcHR0egfRFYq+UA/Ii5uTYWL3ssImuN4xHN5Bil+GsKkZL5uAHkAMSO
         F4qw==
X-Forwarded-Encrypted: i=1; AKwUvBxCek+6UlLHr9Ff4KiA1TM5VExJDc+KYKnHFx8rFOUJMw2n2ALxBtDQDaDSUSPM0mt6iW09oao9i5GJ@vger.kernel.org
X-Gm-Message-State: AFuF++kTO/xtS8/8LNGnrVRoA5ZsFLxFNQfHQzFoI5C8nV9K/OCCwcZ8
	COBgvWNkzov3gHosoG7lxpUbmanHASZpkx8DIYXnxu3sM6K0yHAbmHG5EsCd5F+X1AM=
X-Gm-Gg: AYBFou1ZcAIWLCg4yvKdW3P+fBpwGlOl1nuo8zpfpT/of6SRm5UEzYR/C3fotYFx5Fe
	9EO1rnApAR2XcbIfa+SV6k8toYeoeV29fkQxTaLe58Zm1xwkCTMo+sdkl6N+N71oiuJrD0nMoeh
	8ichM7CRkvQ1bPPr0wuq/blvE6DkITMtbTmP7hGQ1TFIHuNhoFItSK606H+BjNWFaZAbOY1uxje
	2rp+sSs1MpPvLV36d1iyZyPCIbQ5NL65EmaPeRLynU6y56yuNWqmd0rnlpkT7bZWpuvL2jhUJ94
	OWbU7DxQGI309raQV/O/8/mBvJWChwFn0JHWvvAdt+31ggaUIpt6Ird2+1AeF5DLfZp1nHiEvMa
	82ehujVdzuMm61t5LC99Z8IcrVfcvSveBxztLS/nQnaxgA3O95jSeIVhyo68XBLgRs2Jd9dWgpY
	EH32rRkYsqGMJbKwrU9u+hB+ILcGi+bmYw8BKAd1Ac/QkaY9iUWU7fIsBiTw==
X-Received: by 2002:a17:90b:4a8c:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-396d0f69d10mr34762737a91.13.1788199877917;
        Mon, 31 Aug 2026 11:11:17 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990baaeec3sm863336a91.0.2026.08.31.11.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:17 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Peter Griffin <peter.griffin@linaro.org>, Roger Quadros <rogerq@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
 imx@lists.linux.dev, linux-omap@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
Subject: Re: (subset) [PATCH v3 0/7] ARM: dts: Replace clock-frequency in
 camera sensor nodes
Message-Id: <178819987707.2869653.6455595386601883422.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:17 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Mon, 10 Aug 2026 21:05:57 +0300, Laurent Pinchart wrote:
> This patch series contains the leftovers from "[PATCH v2 00/72] media:
> i2c: Reduce cargo-cult" ([1]). All driver patches have been merged, but
> DT changes for ARM platforms were postponed to the next kernel release
> and ended up being forgotten.
> 
> To refresh everybody's memory, a large number of camera sensor drivers
> directly use the "clock-frequency" property to retrieve the effective or
> desired external clock rate. This is standard behaviour on ACPI
> platforms that don't implement MIPI DisCo for Imaging, but usage of the
> property has leaked to OF-based platforms, due to a combination of
> historical reasons (using "clock-frequency" was initially considered
> right until before the introduction of "assigned-clock-rates") and plain
> cargo-cult.
> 
> [...]

Applied, thanks!

[3/7] ARM: dts: ti: omap3-n950: Replace clock-frequency in camera sensor node
      commit: e74a8fe7c2d85e314ead77064ea671b71de44b14
[4/7] ARM: dts: ti: omap3-n9: Replace clock-frequency in camera sensor node
      commit: 3da3c1f84d4f1d14d321ffbec742d4027b503827
[5/7] ARM: dts: ti: omap3-n900: Replace clock-frequency in camera sensor node
      commit: e59ab4d7eaed22ba714c57801262a09ac1c32100

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

