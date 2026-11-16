Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866626;
	b=QPAz1zAl0WMl2lTuTZJ+IyR/Lw/i0vw3uDRanFFUhdNxxXYh1N+nstEzFuXtQ/SUm2PP
	 zulj1YxFivmN4IeK1eX/MbUh2w8hU65g03WeqYRwF8YvTridmtKmpB5gZ0DpCYtlNgXIN
	 omrkW5YP1gIUo6N0WoAmULzCExNECSQQAlQD4kJFosyqhV7lLzIcRSUDiS32HsW0u8IKZ
	 w7EJdZ+VgBW5Krg+stCHrCZLvGP6shAQuKsLNUftTjTLr6RhxCITOh3nTbmjif8uNgrMT
	 8m5+HPDl+6s3LAp83rHcBlvEXzGM3CkbnlNRwVFs2n/QUPpSGIEiyiapMmIAmXmXccw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866626;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=LB+H1KfzRZwbsIbgdOQxyz35ct4YMH+KJmEsb1/UgSU=;
	b=ZXGVe3YnV8OAZUw2dya/ksFwJLLT06VIm/ZlJIhtf42YUj9cxiUaEw8czjrvujd257EF
	 Dz1okykon24tOPvaGqKFG2bVGKF13xPK7PNynyMktBek0ozSMQQO1o2WIIHhEYBAmGtdD
	 lMGwpMMdPJaN3lkBcIoY8NYbN1d4Ycmr9JRihSt8dI7zS6n+QGOb/Qvrd1V3ZAHSwEMC9
	 M+07D2CBr5JL1kPTcBoU2SS5yeSYuIxDUBcbIc5wD7nCysNR7fUynn6thTotp6IHKZzhv
	 iJTKNaGdkV0MO7usXg62GwDLV8FCUmy2TRtn2aHk1oooolNs1Qk8vb0iZu0CS/494Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE23606A339
	for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 22:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE23606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67da3d03263so1957654d50.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2026 14:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866625; x=1795471425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LB+H1KfzRZwbsIbgdOQxyz35ct4YMH+KJmEsb1/UgSU=;
        b=caQvyHINpoQyVYeYfm7fvi6UYtxmsf3dRVlnzs9DL8qdwD2BOlomPvd55xg0JRUa8A
         cdTPJwnnE1lnbRI4/JJA9/28ENhFSJSjqmiXvYS0eQ/SJ3G/se2BJMxhcSPsNmVaeIrT
         m7iUNA0f65nAIbIswxev3f+tqA/NfzVM2ANGX/xVYYv75WJFXsXabDK46lTZaOchaLVu
         ZXInVhXr4tBQamAByn6mm5ZH6B5oL+FCL/9L8fom/T56XMxa0NwOcLuYugCU272g5dVU
         RtKmic1akOFXe0HkF0HahzfQxClPK+drV11/vHaQv7Az+R1bHDIpZ4c/DCXR/NldKJFD
         J9cQ==
X-Forwarded-Encrypted: i=1; AL+hErGYK/z+nncSvD8bkSc3pK6YcNFKwZyQK5HlGSkaigWBaFG7jDUe+dvvZCG1VmusF6jgHjFmVUtdHdUp@vger.kernel.org
X-Gm-Message-State: APuU4Z+PiPhAifWneO5HUTV+JmNxkR8HrZ+BD8zNztGjYqx8AgAp80FS
	GCVDHxdNRtmaL7fDN6cw35Ns50Y/xz+X6LcULutCaNs8YjowPwct8HiVJEiRrDz3Jcg=
X-Gm-Gg: AZFdTZflHebgw45RsR/qE60JIIedAoctNULdRDEy/2xtMx6M9mo1IQIkmItPkJK3wsY
	KFQ8cdj3GbXHWIDdIbg3dwBN27c6YbN2o2ijY6xWd3tFyGpELdjYK4HsJwjvMRAg6GA5kBubMoj
	9czUlMyP7QfpE6CEj4PY3YClBWEslEcsIEgWl9QqNM/4kGalLAgxLHyxhYlOZIaBL9SbN3DmWky
	BHzL2o6U6B9Bqoc26+aWhdSrVsv3g6FYBuzJI51Hta8L+uw3t4FwgN9YlFkyiTXjkDIUtYd2W44
	TgnYMknORX3HJ5BnruZs7/vQb7C+0MUNZRf2i1wIhJgWoutFAaLVD9FOESD1tiWo75+lR4uKsax
	S0PTwyQABQgZ3o1SDmipv0ONZCBpqETw+ZjpAl5Hsp9RM3rpAOiU4CdOwwjreGRQnbVLyfoUMiO
	9+nPtnTA/XinMPSHExDcRG3yRwLZJsxPOWt0T6fQ/gFVrioDxg32fFAfw8rNlYph+S97c5X9okM
	3AI6bAwMFxJyEPx6PRTmRJnMB4iluFPYV9UNG3lCYJ73egH4meKm7mHXL7Dk4ZyoOzMDTSOnz7v
	KeBePmzAzd9VuM83fER909wio1zolR/iRbIcmjmEJq31GmkIX+Ue7biAw8KaI1QD7/lVqCzvyfG
	2HSkMp9X9qUUjSeCGYEqYRSy9eNHF3gz1
X-Received: by 2002:a05:690e:12c1:b0:67d:b0df:9095 with SMTP id 956f58d0204a3-67db0df9d3cmr2820810d50.126.1794866624543;
        Mon, 16 Nov 2026 14:03:44 -0800 (PST)
Received: from josephs-mac-mini.local ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm11133078d50.21.2026.11.16.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:03:44 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:03:21 -0500
Subject: [PATCH 1/2] ASoC: ti: omap-mcbsp: Use all 8 bits of CLKGDV
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
Message-Id: <20261116-omap-mcbsp-tdm-slot-v1-1-6c9f7aa45a29@telaak.dev>
References: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
In-Reply-To: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0

CLKGDV is bits 7:0 of SRGR1, as its comment says and as set_clkdiv()
intends with CLKGDV(0xff), but the macro masks the value with 0x7f, so
a divider above 128 is written modulo 128.

Mask with 0xff. The only set_clkdiv() user, omap3pandora, divides by 8,
so nothing changes for it; this lets the set_tdm_slot() support that
follows use dividers up to 256.

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

