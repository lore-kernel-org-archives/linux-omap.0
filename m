Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198097;
	b=f4PG4qoM6wSmouzumbrX/wPLkZznyc/LnXc5JXv7qtHoRgUvGXPwxCm5bOCwOAHts/3W
	 glq5601X00O/016xqgIggHEY1qBS4nZhtRcIFh0/ze9b1JZjzC/KJZBi5ZrolOV1z3+E+
	 HkdwL7xKe0wGIswzMa3HVZexHRsgVKrOPCHtfOQjq4wph/HRH3JzcrEcqXYki72mkoXlf
	 9nmadZ1svCTlKJAGFeZ9KDPsSdMNgk8XFDPcbXM/oUYAeVt8MezogZtv3QRozOLqGEydi
	 YawgFovCJ6PAqk0mDGRe3glecHim+Wv4f2Mf3nYkTl/Y9OPmkw8OjAAWD4iUicx31hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198097;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=vGJwTqYdbrZtckhZYhD/RIzHIRbhV2RUl+NlHGXe2VM=;
	b=U9C6RtnRPlP6phhNTsr6yhdDCza4B2bDPTB/bv21LeecrWJBWi5UEVdEwTaJwMcIGfuE
	 DxjXlFGLl4aQewhdVsq7V0PgmKFpz/ShiLFPRA5NdA6GBNEteZ5HA3N1OXrLsQbI3KuJD
	 Dfq40hmaqTdIGrntCUYshQiZca84Z5cm5hm4UMYjpl+os/mU6c+KYjVaC6vuAx3eRluz8
	 8cLD7I3F6tgXPq6PwkMZDOGQJGc6WVmJJaF7Jhjgg38ZynhnOwfIERAK5YEipr0ix0xEn
	 mAgARD19DakQkIFdHRPW/xe67Hr5rZ1nXl3Yg4rkJZB9/LJrnN8u3CM/3roHPriygIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0+VX3Z9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C0606A31A;
	Wed, 28 Oct 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0+VX3Z9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A7E1F01828;
	Wed, 28 Oct 2026 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198097;
	bh=vGJwTqYdbrZtckhZYhD/RIzHIRbhV2RUl+NlHGXe2VM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Y0+VX3Z9uZSAHU0mZ8PYqiCsNyI5hBqywsEMhb1le3hLmJsz6YS7Hs7V3XkEYLbyx
	 kmCq3CcfiTu8Txa+pAhaaNlPF6OIJ+tW3xuPcei942b51Q4qmfKFNtpKSBOxzCSRjc
	 ELt4sxgakcqZXrtPRCqBLWkMvlukXKgw5EsvvETKyKEA5s1SBf2xal3NEk5jp7GO4u
	 qeF2j0qEy+7rOGL4IG8u/zZpRgXDzLq0lBVy2Xrr4ns0h5tf5AumzAuf1JqZ0Ueh3j
	 Ehmc4dXS9B8RoeVYMdikDkubgqoMnYRT+Jm265Aw0ivflPLE3g6hBUMmYa2hbuhLAK
	 aGZUAdoPZACcQ==
From: Lee Jones <lee@kernel.org>
To: mfd@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261017004758.1256875-1-rosenp@gmail.com>
References: <20261017004758.1256875-1-rosenp@gmail.com>
Subject: Re: (subset) [PATCH v4] mfd: twl-core: Embed the twl_client array
 in twl_private
Message-Id: <179319809509.3743962.8693833243810954971.b4-ty@b4>
Date: Wed, 28 Oct 2026 14:34:55 +0000
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

On Fri, 16 Oct 2026 17:47:58 -0700, Rosen Penev wrote:
> At most four I2C slave addresses are ever used (TWL4030 class), so
> there is no need to allocate the twl_client array separately. Embed a
> fixed array of TWL_MAX_SLAVES entries in struct twl_private and drop the
> extra devm_kcalloc() and its error handling.

Applied, thanks!

[1/1] mfd: twl-core: Embed the twl_client array in twl_private
      commit: 73f3a89d27c3da9ea28750a420fa2567c0bc1701

--
Lee Jones [李琼斯]

