Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494867;
	b=LHAGrGx0udGGhXNwsR4rAEau0Oz/VqAuG8VN71w1LXI/5uGQS8jfZvWw5AOa7ri+fcsh
	 7rn+S9soDzugv2ttLIWeuqN+S9mA4+4zx2QBHssQ8ZRqJ7zGEfIp3v9bFoOziCNmQFXTL
	 /JprOqjsc6cS+tp82ocwOLyvePzkd+bh+BS+aoZ1kujCzoKg8VdR7afE4B0zm8i7r5gUD
	 csdMZg06LwS/uElBJoO9O1rne35ffto1HFJMAP5fiulh+MnoblinveUG7EZIWppvfPi5Y
	 5IhZ7nCvo5waazRkmT9bMDd8zrMQHYAMDmuNLSjnugfOHq70TANRZhXEsMXxOzeD7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494867;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=P5N0JEP5ejcvC7nFlE0Zn8HSzONrn/YAOlThtpbyJMQ=;
	b=lQV2iHf8BsBnum/zUVAhprCmqCSeUJaYz4Me3IOB2rANvoA9tOrbY9zgSGRqUVymUcrw
	 cmfE52sUFu/rumimObKVQKawArjVLFKhAHOUSr0blv6m1Wl17DmJrlTj6PU1cIpmUq5RO
	 Sas0uMv70c+/10/MupMqF2F9RGbd9kjo+nWZBEnv+k5b2BDmSeTggzogXeeHq2C4LjFZp
	 6R6ptgfDLXmoTZnWj7/OB2q+5UfcMOFLl3k9S3mOV82oE+kLgzSZ5wQkq6aOutDLmeOFP
	 3mCtVo6nVNkEWFC/0GtWUnamBLPeDvt6ugY0pUaEId2mBEvKU/VMjP4YzkJeOz+h+rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD80606A330
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2026 04:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD80606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b4eab91bcaso21897457b3.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 20:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494866; x=1796099666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5N0JEP5ejcvC7nFlE0Zn8HSzONrn/YAOlThtpbyJMQ=;
        b=Hqre+OcHcMvNcnnHv4JHKpiGZFKJBfCFtTUEzIfgsArpbx3dfXHbxEef4xTnsAF4TL
         KmYjlvKCJ3k+6zcnCtNAwCMNdv21oCYyxUq+t175RxJ/wsUcdT9JjqUmk++UEafHTsQs
         XQMuptPXjYS2BTdXts6FrrDEvRi+sGgfyopks1aHLctJGeKa69uhPZtDMEUL4if/VhUU
         lKGvJUYjLYJrn/N80pVWEEBizDSK+7vCwSyvSWIyzrFXSVnr5UGIbcX2p65xjcjwSOAb
         WBlgOyAgyMsq2z3C3vg3UzxIQPKxy+FRcZvSJA4Pt7rHpd2gmnaCk6/VgBx1JhSgrqaq
         FsSg==
X-Forwarded-Encrypted: i=1; AL+hErE7UZsL3pOh/yWQclIQoyT+Po+S01O8RF1PIWAJ92k2ySn1gliYV/VSV2+7MBuIb4dZKGvvfnnJRcZ4@vger.kernel.org
X-Gm-Message-State: APuU4Z+akh7ccr2fSDtCsFlXxM/tt90WACUqydbmBoBBstzkmNvUC7KL
	7zU4hzyqkcQ6VJdH/2+NxHO+h0nqfRgAwX7pwFAO/+jxL6crl0a2zb9O
X-Gm-Gg: AZFdTZf6LXdBFEaaQEuJUeeXnCCBAW6J0PlwSZjrssLvdr3NaWKJaJ6XYRn3MpAONCF
	j7+5PcjvYAV7rMpUgdqPughoa6c9MIhnqnjpTALr4mtw4s9sojC1/uS7XrBOX0PXQgldAdE8ytY
	tetbw2CLAuckaiSIRIkLaGCh2/PIC/iUPhoyRJ0OQ0EDHE74zd4O4fxW8ngg4hpDCWBRi8c0oTm
	ekoWvIa0Mg7q+Hv7iUCcMs34FXBAPQxgOn+VMcr/Z2NraJe/InndHXg7OU/pAgG+Nq5558kwkqv
	4s4n5VWwBXrfSeSia0U1Hxa7E/B3vzp7zWe5WFWujIzD/sWtN9DiTAB6pFt0kTWGvsYVXAbLE86
	ID1poHR9u7o06z2cBWLPwxET3PHyBqtLqk3n21I2SlXzWbjq41VusxGnHRn3tKxbgQeUHxdU6ns
	lQ80JYss92uEA6VeXB8i0BqeO5VUT2pTBpRV3ks9Ji6qO84LOvxc6Oto3PlSucCJWs+T8R1GY7k
	/+5K5Ux/CjGahhwFc28icE3L25wb6+XGSShAvZYR/ScRiBTmR+Hbk5jZSgQQE8SPAsgz1gbIhVy
	0bo4z7xbbAvDIJ0vnKYEJIpr2jv8/lwz5+8asCsz6nN11874yOM9qTg22jNQhpE8FMUfJYgl/lk
	trRT7/sYjZMyvDTI05IaI84KCMI4rie0RDntwGCbXGusGtb81jMqxRqPjMzeYYRlQGunxuwXs0m
	bfZVDvmHDsYPHSuf8fuyWleZ1O
X-Received: by 2002:a05:690c:610d:b0:8b3:5121:3d7d with SMTP id 00721157ae682-8b520475df4mr57774267b3.30.1795494865986;
        Mon, 23 Nov 2026 20:34:25 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb0a2sm53106397b3.27.2026.11.23.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:34:25 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 23 Nov 2026 23:34:20 -0500
Subject: [PATCH v2 1/2] ASoC: ti: omap-mcbsp: Use all 8 bits of CLKGDV
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
Message-Id: <20261123-omap-mcbsp-tdm-slot-v2-1-3e3aae215952@telaak.dev>
References: <20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev>
In-Reply-To: <20261123-omap-mcbsp-tdm-slot-v2-0-3e3aae215952@telaak.dev>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0

CLKGDV is bits 7:0 of SRGR1, as its comment says and as set_clkdiv()
intends with CLKGDV(0xff), but the macro masks the value with 0x7f, so
a divider above 128 is programmed 128 lower.

Mask with 0xff. The only set_clkdiv() user, omap3pandora, divides by 8,
so nothing changes for it; this lets the set_tdm_slot() support that
follows use dividers up to 256.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 sound/soc/ti/omap-mcbsp-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
index da519ea1f303..324c5d7d431d 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -136,7 +136,7 @@ enum {
 #define XPHASE			BIT(15)
 
 /************************* McBSP SRGR1 bit definitions ************************/
-#define CLKGDV(value)		((value) & 0x7f)		/* Bits 0:7 */
+#define CLKGDV(value)		((value) & 0xff)		/* Bits 0:7 */
 #define FWID(value)		(((value) & 0xff) << 8)	/* Bits 8:15 */
 
 /************************* McBSP SRGR2 bit definitions ************************/

-- 
Git-155)

