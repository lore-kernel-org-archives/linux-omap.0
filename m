Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DF222580
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199869; cv=none; b=O/zlFBR+/VofOASEmlfrgZ3WHbXV4EoNc/Z0OOB2+2Q9h6Sdw9xkQ6kasAnA+VZBnWaCVpUXPUQi3levUQen2doHBjdBLBVHWnmRJXNvB7GIRmHdxlE/kL+7ISa/l4xxlazPXsA83Xk/U6MuhAmrNhcr7EpqlncvNOQD4LIHm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199869; c=relaxed/simple;
	bh=TLkRZA3JuuPX07AMWLzAA/Lk8SLkA24CMGDMP7I7j68=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=upLqwsGm42+50GJBx671ECn2328MYiTchCbcXVBETteKo3pfr+QhR4p0Xt7Bdq4vIY7tmUfDiW67oPrUCDWKcQWJEsY6OSaVh4EPtfmMGSLrppoxvGgSmoc5bofHJ21PM7PkNTRW82v1YNUe6d8Hpw+FS48DVbYs5sHZrrdmbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZUzA1243; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZUzA1243"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6d28aa26cso26941795ad.2
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199867; x=1788804667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFcVUeZvoh/RAPEBADc2aDhb1dFXKQ/OHpInFaT5ih8=;
        b=ZUzA1243nHkT95cS6ODSQkln9ncxcrLdjKpbZW/CfLOrhQI3SBBEMddGJuFn6oWLC3
         B5HjZbZseXaPuioyBg2IDmqGXZFvZBNpO7hLudPDY+ytcQnyvCchD5rwz2F2KSmkX0Nq
         T0n2Fk09HGQGa8FoK2sxhEycao6wwyzxS//q719EtFJk47Tqr5rcunvlyJ1intZK2PAD
         1+mSFqLxxRl1mz7zASS8uGUZTVZk1/3GCyvSr9wfouD2FnabPXzLBn7pWWIPX70vy8jQ
         ec2Tga7kviG4qzev6b3gouO8KrQDCEPxgqEzGCESxao1vzMfMXa0Zcy2ApN0lTpLGzok
         MGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199867; x=1788804667;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFcVUeZvoh/RAPEBADc2aDhb1dFXKQ/OHpInFaT5ih8=;
        b=RE3582AcbLy6voz+ruQYlk/sySvkl9u6nD4/7bfkxx8u1tcZu3yJ+Ya6dMsfU4NpEz
         aNlDh71dSbhHtJ5BdkrdXcd/zfWDqdCnpZy6TDe7S+AXFnRWw0mmNRRLsfnDrfRmAih2
         0J5cO81W3+rzD6jvEl38j7deiAL34Zav+FUuISR1w8lTDdCfYtbz/n6Pp0LycdrkVdzn
         WwDPbO/WeboVm99Y7GaxhHdO4vjwnfjunnMkHhS77yPjInPsn9sdIZ+rizwS5jcqHDCq
         LeysOk2RhL52JM2qTqDzHbPhHlIerqcqxveOzNumvFN1Ogq+g/r+CG16k8Ly+ym4DtSG
         3YAg==
X-Forwarded-Encrypted: i=1; AKwUvByqgD59XRMT0xcMQP9aK4ijsJiN2jvvgGTUOf+7sKeiv63HtAEH7WbPVbmFvpMdjAbRbpioftq3ZmGX@vger.kernel.org
X-Gm-Message-State: AFuF++nyPiRFCNLMzaxWxcrDutkCg+nqMSrliJg6cfx8rtjqC053hK0C
	DyVMpizgbsLyzX+uizYPNu++Noby4TemQMNMfQx1I+jMn/+sXEkjuMLzz+qdB9VpOM8=
X-Gm-Gg: AYBFou1qdffFzILPMecCR7q9mywTJm+AumcPLfJm1cauNhntlfg7oyX8Vwy9rIoMzL7
	86wfe1yfapxAls6Ta11idSLlVrdYWyu+lomNpBpv4VJwiSI+iAr52iceqKBwj1Q5a9KqlQsLiw7
	vitjL3CtZpzgO+BFK4bbOPRIoUAVKZ1xXA2Yy9+txTi9vsQ5YWy6j3/H0uLS9PPe5E3Bsmp952p
	oF6IfqPbcyKKwR/CPfUQL5mVEH89oFHx7V7FPBj0k0UvPG6OcyW+3QrKFIt1UzY8jOQvmfCFPCc
	njcU2NlgE+KMNglHMgI2jOkIacTUv16VoNAvTwnLgx7etgNr7DlReVdRU/RmwqbRpp0yOwm41xc
	hlpZ1rKuv19W/BEYqtxY8vGBEYVKyzPlFHcthq96WiYGeZa+TpKSptFJY73YRS5Whiao9oj9Tu8
	UwWzGcmRWM4+ZSLSmkLfKgvgv4OWSGqWT7/Txv9r2UyoCWb165GwCWDctiKA==
X-Received: by 2002:a17:90b:388e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-396d0eaabfamr38282859a91.1.1788199866927;
        Mon, 31 Aug 2026 11:11:06 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d4ede7csm757637a91.13.2026.08.31.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:06 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-omap@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260706101815.341184-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260706101815.341184-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: ti: omap: Correct indentation
Message-Id: <178819986613.2869653.4587463597728573985.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:06 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Mon, 06 Jul 2026 12:18:16 +0200, Krzysztof Kozlowski wrote:
> Correct spaces or mix of tabs+spaces into proper tab-indented lines.
> No functional impact (same DTB).

Applied, thanks!

[1/1] ARM: dts: ti: omap: Correct indentation
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

