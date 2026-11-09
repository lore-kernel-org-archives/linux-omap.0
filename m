Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268107;
	b=ap9nnn3w/6SbOdlFhJMflYYpvCU9WWKl7bd7907Q0UnuMCLGLQ9Y11J1LP88rIfHKt6E
	 IDHJ0PWVCFgoDrhHoUZ7mYe1JnAEDQ2tDGQhxHIuPf+kjLC9xlTkY+Vc0p39itQnive3D
	 3IrsTBjHIidjLCVFepwgjET7PCULLPlCL00JVHLRZWErBptaZu8Dfa4oje6izTpX5JVPF
	 QiQ3zbHhrrAxyjkputPydZuB11Lo7mC5qmS+RuLCuE+bzZSS0bhXEYHblXV3BOKUAdyQM
	 tbkaYOtFCMT+3mOP/tBloPdtaaloPtV/7I6StVgFDSmKcBUa3dST9f2F1jRTHN3wrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=/K50kU4t+eYXUelN7qRb+OFgTRKPsxADBayxqCC2Y0E=;
	b=hr4t+6+h6LN9TD+K/KXMzXKM66sDMq/Bhkt5yFLIaRLl4lMkJczzv4AwOYjsOC6oBcFl
	 stcl7rNg2TZvnbz4PpUfmbinDGDIlzaHVKJrXl0FZa46hvdudJQu7Wd+ycyDJ2QXdL3Vn
	 KEC4Ug4z5h+lQBJ63pGEdn/BRFIV5JrWqyuQGOEmDpegl4fai5G/E+UavUElWgd2q50nN
	 g2mLirM2KOj58xIBdZlFir3lpch3Lgr1XePy/LlLI8kZI4ZQPpDOwAMmhacAE4cnMzU/+
	 yDnRMaXg4OHA9T1DoeDy2z6+9jdATFzkeYB8emcRanLxc6Dd6OkF6RF/Y1FrQo5it5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jQuOzM9I;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CA60A260A
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 060CA60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jQuOzM9I
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso723603a12.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268106; x=1794872906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/K50kU4t+eYXUelN7qRb+OFgTRKPsxADBayxqCC2Y0E=;
        b=jQuOzM9IX+CDejyj9lEWy+Le4fLWrgxC7pMqccH2Wg5zeC6uE+gBhFkr2MlltqoWOd
         nwcJJbgLlw0d0SVbrPNazeM6EkV0FCn//l3MkBQb/eHF4mzoweVhEaXHe0l4Za9b25HC
         C4UY0h+aqhJr0zzb++d+49u57+0DL6Sxlpfq0BJO+0ZMipk47YrbfVjl5AkxwbDIn02T
         0mllEbzO80n4b7j2pdHzgQCG4JZExDLTXneo01xNCHa/wIOUcWHJGCCksEWzX9AFplUi
         Nt1RakJxy+9VnGhYO15sqHkEv1SYKCSGqdT/bmHYbdMKAff5l3mk/x3MSnn425Kd9gOC
         hj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268106; x=1794872906;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/K50kU4t+eYXUelN7qRb+OFgTRKPsxADBayxqCC2Y0E=;
        b=UybCsxWbtbRpqG73zmDVbtR7ZWHPHSAsfnyLqzg3UWPW8YGeCzR3QPbiblsD71ZtXq
         S+erqQVeKeyNCW/Ols1oFseoX0VqWumTAiHTKz4l8Ig1D4rOSEJO4Gf04l5UR5JGMr7W
         D8KvhvTVcxNgTkzk20K9otfp54Z+E2jWtvle+1UxKYeGjt43566JQxcQOWA9IvpCDeOe
         LVuCIySukL+Lpccho2Ir0XDyKpZPMQsQE2ExhzeZWDMZMsXiYS1WZXGsOGjuV+/b0u98
         e8dA3te14NOseAbO5AE85ixjQVCEYGyeNgDTCXPDFZ2aN25rLOGkPWyUc4s1I8ZbQ+Np
         +ZuA==
X-Forwarded-Encrypted: i=1; AL+hErHXDk+nz6e/Tfjyy5x4+z0s8IRajGPBRJEkNcoCwPyUKyfqjt4reMxeuVV690v2PnoniJfa/63lupwd@vger.kernel.org
X-Gm-Message-State: APuU4Z8iP5TbYGgfIGa+DARM22vqniH5Iqscuy4xU5Ua6flPWbjhT2uC
	2Dq6jzAVss1BxbsTzRCyfo90YubYkw1LAr8Vjv3eLC2OfJ2HI/58OMHTk/N669dsiSA=
X-Gm-Gg: AYBFou09T+QzCNMEVuFwrPIcwoxVfb47omgeGwYIANOt0uqEPw4p9KxPpS5bNj9P6Jj
	pHSPEDcxDldY4qvUHMcDzPOYrl+khstvBMk3NrgAnGXyiYJdciKZHPQhBR9esyeH9puK3mMtzuB
	Xrc3F4lD3r4vAogOTF2lGLijbWUsdIkH+l/1QPBpBXrUQvfGCO6mlLiLWYGgU4h5sBx68lLJmyG
	WWfH30/JOvGefxIJ3UNBmg7mIyKGkqkVBGWu4BcpbjkT2VN0wZw/+3BGD9yGftwM3YQeeUVWfAs
	rZP26fnIbXb4NQ+5sRIippYOR7SNCzxZ70aqDua42MInKeF9ClXD2Yh+jMYWi9oZIKgWMkXcxYi
	lgKEuHX/gIlWv2IHXlrYPjNZRnQI8fpK1FBNlHNluFws6XA2Mk1b6QiMoesE+TPced33+dEPQze
	QlooLnWSHa19PVM2DDf/sDZgcJ+qMDl93MBeY838OkG8Bl8xhszgwXyXGLpmCSxIjGSCYpjv1Cr
	XJutmuoaLyBiHCwkzi35vmxjYv/eMlOcXrRmpayRwPX9HQDihT2v+IOou0HvDkV0A5jLQi929ki
	kLvcpNFXT7OICypsHsqGVHV8AQ==
X-Received: by 2002:a05:6a21:8986:b0:3e0:e242:5ff with SMTP id adf61e73a8af0-3f18f98f975mr625196637.56.1794268106473;
        Mon, 09 Nov 2026 15:48:26 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cdd8d6940f6sm198558a12.12.2026.11.09.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:26 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Richard <thomas.richard@bootlin.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104-omap4-dtsi-v1-1-8d987f953fe7@bootlin.com>
References: <20261104-omap4-dtsi-v1-1-8d987f953fe7@bootlin.com>
Subject: Re: [PATCH] ARM: dts: ti: var-som-om44: add local-mac-address
 property
Message-Id: <179426810568.2265990.3229558705065836668.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:25 -0800
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


On Wed, 04 Nov 2026 16:23:01 +0100, Bastien Curutchet wrote:
> Commit d8f1b27c9f12 ("ARM: dts: ti: var-som-om44: Add USB Ethernet
> controller node") added the Ethernet node to allow the bootloader to
> patch the device-tree to set the MAC address.
> 
> U-Boot has an already-existing helper that does that but it needs the
> local-mac-address property to be already in the device-tree and an
> 'ethernet' alias for the Ethernet node.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: ti: var-som-om44: add local-mac-address property
      commit: 75bded0727262a73500c61b86bb6420fa9e23f3e

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

