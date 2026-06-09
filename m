Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F44C955E
	for <linux-omap@vger.kernel.org>; Tue,  9 Jun 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043960; cv=none; b=i0XE5DMo1rEnXlGYNf+ByAwIE4cxpd93VLxUvvrfw8GwnHajOAe/3etTNCAylSpUOkGGBl3Ej13VPcR7Beg6GdBDJA+5Fha9t+7hmiYr4yKNcmFNnK+nl9VKv2Im8TUqofupUDXO6MKtmp3qxpDhJqoN/DXT/fq6bt4vaBB3XUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043960; c=relaxed/simple;
	bh=EbnvOc6q3M9bu6s+LJyPIX6jYqRrX3EP2WtbZXh/ifI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LdJCu3bqlWCBFMXd3tJEt0UrnzfWoPh5isP6+2eGGcpXNgu6E/R1AVtZdAxdCl39jQsa2b9pD0Rp+7JEG2y/f8NAdwP3D6GTs24MC4uvmzUZpxJsPsUKB1xUwBMVZrNzi8WPzJtJ2loBi/OW7o/oavFOuXoOpUTi9ZJefJh9hfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XDnlJYc7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XDnlJYc7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c858961a8efso2284062a12.2
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043959; x=1781648759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN/Jy9B/0TiaOAqcpt4MHIDHsIu8QVblj/3gdv+TtyY=;
        b=XDnlJYc7uGXib9afr4Ldv9m92GZxHH34WWD1rPRlvYu5q8LFbbDI6hXNm9CLwWwiEA
         rPrma/jjA/lahhp6S+AuaIm6H5RACGxUftcOVsZ+NuCuLaZyAwQ/Kp9AQs4aXJB6o5oS
         1ALx4Sf1tqWxzfffPelGKiJ3kpJhf6C/SbX6XlcHaTZEmkczdhqpO/Uc4DqMVL8bjqgB
         vDF/7RJdGzoshuYke9xPfVboBM4Jb2ad8oMrCMpXjwWlBYSRJO83eaekaAc1KDbrahyr
         H/LaTaDySlbkJzs+MTy5hXyJBxfEyO41VyNoHdNSiGaaoKXfM9uAjIALNHDYXAfpv+WC
         wP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043959; x=1781648759;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nN/Jy9B/0TiaOAqcpt4MHIDHsIu8QVblj/3gdv+TtyY=;
        b=DfQygDtZyQVHJL7GpMgf/s8qN57bW6DG9ghHRn3D1crMGZkOb26WuVl6NmUuhI3L5o
         /1LRBnVSSeiiB8rJPjsSmW4Ey5v/x0+lEuYkVwxQbI9xXgg5ZzbkpVmfnomZ3Zpy6jny
         eZ+STGSHX20k6LSqFiVzzQlGEIipJqJqoLUuUSSCWLbZj4v8ypLNfgf4x+Ta9Dh5zD0E
         93PMUPJ3YWZz+rJwSxRlXI8OpKP4T+5Wijmlum9xSUIebqj9Y3mSJaHlzF22WZEZ96zY
         fxTIUfsvfgkMcpkheD8cXc2osoNA7Q7l8M62cBcouo7dJVL17K/1/zSwagGtmhcD8GdL
         rymg==
X-Forwarded-Encrypted: i=1; AFNElJ8Agq7PPriwRri7YE6aUMMQS7W1ZnWF0JlLYylkDcDEqpiLv01C8YECegOCTay2i6TavO84WbhBXRGS@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGACmDfr6DBNnB0fT3LXyelWLotMXPJEBJCQSkBAjUJY9btZ+
	nqKnZuxPXrV6HIBonB6cu8GC5SJLHSj1KE0o+Zh9fWkmnFDrRHVj1d+i2alCl6jdHSE=
X-Gm-Gg: Acq92OFrBw5uoL9hJ4yLoRKT+LETOMGi9iT/TcHm4jjdOuVbctWNWwb+lCbBrJC0wjQ
	9iJINP2cUG54crpYbTE642WsLr/KJxmwbPy7v9rMtosajVxrE/auHTokm4hUxy/8s4rcZdAMTFE
	25pQ06rY0cXZ9cqb9V/Q1PGAxHUTm9sWdpIkyVNCn/6Y0RVUaYU+qqsweDKutbdYZeQRApsYaeR
	yp8h1JRjerca5xkuVFHFgTdWuG0BU3NDeEdLb3bSy2DTgfoSc7+zAU+QUCZ/YyjdShJ/WZI1NBl
	NRpRQhWgkcFErAIX99rnvdZCkZu//Ww03kaTFnm/Ooclk23dL9luOxpQP+azgrx7/Y80OwhbxlS
	GY1EM+kwVFqJHPylxn86TgtqE29IzempDJ5/YWAJWTVcS5pkCIcPR90D2We9u+eamMFIJDss0jL
	oxpGbGFP3Hmk5CTL7dbm/iQBRpLOLzlg4=
X-Received: by 2002:a05:6300:8088:b0:3a0:aee6:acc1 with SMTP id adf61e73a8af0-3b5345cd84emr6242857637.33.1781043957586;
        Tue, 09 Jun 2026 15:25:57 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c85df0bdbe4sm19516834a12.32.2026.06.09.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:57 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Mithil Bavishi <bavishimithil@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-omap@vger.kernel.org, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260604054048.18980-1-bavishimithil@gmail.com>
References: <20260604054048.18980-1-bavishimithil@gmail.com>
Subject: Re: [PATCH v3] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
Message-Id: <178104395668.234140.12825758789646628656.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:56 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 03 Jun 2026 22:40:48 -0700, Mithil Bavishi wrote:
> With CONFIG_CFI enabled, OMAP4 can trap in omap4_enter_lowpower()
> because omap_pm_ops.finish_suspend points directly to the assembly
> routine omap4_finish_suspend, which lacks the expected KCFI type
> metadata.
> 
> Annotate omap4_finish_suspend with SYM_TYPED_FUNC_START so the assembly
> routine carries the KCFI type metadata.
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: Add CFI type for omap4_finish_suspend
      commit: d58849ac304472fdc75f44c468743d75ca75c2ce

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

