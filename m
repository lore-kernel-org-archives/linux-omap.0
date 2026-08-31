Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF43A961A
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199870; cv=none; b=NhI9ajNMV0GC+BoKQMZq7RKo6TherN+F11ZxMT2IfFWZAMIHmWVDNbkRgEv2JYGw6eIBg0RWjYdHbUpvXWd2iTpo9vI1zTCYi9Y5k7L84x5u8C/aaEp97t3nXKQU9VAycY0Yw/a1KJOwmzpoKJ0MRMyQCRDA/UnlLPYkNSQNgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199870; c=relaxed/simple;
	bh=k1x2zhUdHoK4lS47he5bo1ze0plPQeGnWZQquVLpEvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m/j45n2nQwQc2/v7qsMn1kwabc5pC6YaSkRHIU+my5/5sdixroV3vKjChdSh2FOi9JY0Puk0SUI9PO15TMxy6fe87XGQ02PPLf6aNbwl9V7QFjzqSvCmdfg1RvfcCPq7mDplXUcLaeCc/KjKxpC4fwoss76xxpAuNPa+m6GJWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L1OEJeZU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L1OEJeZU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d8fd3b729dso18189555ad.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199868; x=1788804668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acq/A4AGzwAJdHPnrCOzGeerCbgW5JVrTLnSuWrfwpU=;
        b=L1OEJeZUS9eU6IT89bWlBfbe+pVmgUSXDTzubDZB3g16kSefmC/LQHkDhgBlulZpkt
         qpW8fdp79DorsUlTdSaGotXrGVRrf2VoSFovaW7h6dJWGnEkvFTq5GcQGM0h0JsCeZSe
         HdV1iGNZnUfLmwwkBM+r5OBtLGnKA7oY/Els6nuUf8O8/7c/taOBVc0LU4FGnD8SV1SJ
         jUAj3/+yR67csNVea1mBbDwysgPcBRLOreRDZEi4p6QvXdwhDF6KqKjZLiw+TtqqDomY
         FNVOuiMJMIuHIiJu5Ls6cVL9wenJJeOnNfCPp9FIv8jOCGzJ+CH7gebvudqGsnt8TtwJ
         JQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199868; x=1788804668;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acq/A4AGzwAJdHPnrCOzGeerCbgW5JVrTLnSuWrfwpU=;
        b=jtLYeCEQ6yHVFSJvFDudMYzrNSRL/SLtdLt+tFy0aLGG+pX3zHr7ixC6g/ETsyl27b
         sgSub9LJhFRz5G8oCiRSRJojOT6KxZKhOJ96Yss6AGqTKMdrfDg30yrKpNsvc7Id8SCn
         FvsD3cUor8NoSAeq2zkWcHv/5gqyh0sJViPulw5uMOF5s7lVrtzm52x0gmvjLnVcWq13
         UX9sg6E5l97xOB1C44p5B3gA7VqJsH+oR5OJLHBUuVCEgs5LvANed5vXFpoRHor+TU5U
         yn+06VLvADWgsomOVIKya3SpOEYZyqE0osMm1QAG31ZvJHRr3An0jAj/LUbN4l5gjvDs
         slJg==
X-Gm-Message-State: AFuF++kVn406UEFfY2LksD/+XtI0QDIdxDKDcE2XYS3sE1q9mbqkKuDv
	pz9trWbKAE9b9B3rbNROidQVN3JCGlYbZL77Wgl4kKSCseJXsnTQRcNzXKV5L/W58so=
X-Gm-Gg: AYBFou3FCkPqIXASfKXgUJ2QcRURcK9Kh0z0uxiwcTP/4xgQLBPyf8Y+z/TYVOPlgwD
	4A8R3d6RZ0bpbBctAX9T2Q6Qzbzj/h8CzxC6VnoAToBUVyyotbD+Vc85VFAmeKMuKweCFRdrwU1
	6nbzsX3Y8j5fvYTjrl+/Wy6MhTMtvyCyzhGZOu1ScmHW47LTo8wWToJSY+RyoGuGnoBdoiT6CAK
	sJ7K3Vaf4M75RyhGqczSLU7kQrSNUKnztmFJ9nG95zQJaCmhfh7+P9LfEXvLqK7MMhd1OfNPzfw
	cTNvQ00fkmcMYM89NA4vRbFCQLLpgfOBoZU6tKJSoHXzeVHb+rJwz2gql4Ozf5dGU/g7RjVa9l4
	o9RYnlPER+cjtF3xrYeKKEhHEP2NjAhBWM20pItieglp4LywGXF9XUi5GPlHXrF2dBu6FAjH6xy
	Xwk4w4iJxPGipoqXwqkYNS2jQRQYtmzQ8aIhrTv+ytx0WFeyOUvXhniLOkUA==
X-Received: by 2002:a17:903:2286:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2d94a713d2amr28505335ad.2.1788199867991;
        Mon, 31 Aug 2026 11:11:07 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d90e6e10cdsm24043265ad.14.2026.08.31.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:07 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Sen Wang <sen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260708221032.1600089-1-sen@ti.com>
References: <20260708221032.1600089-1-sen@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable SND_ALOOP
Message-Id: <178819986708.2869653.1615558663659219045.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:07 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Wed, 08 Jul 2026 17:10:31 -0500, Sen Wang wrote:
> Enable the generic PCM loopback driver on AM335x, AM437x, and AM57x
> platforms, matching arm64 defconfig (commit 7235cdd9cc52 ("arm64:
> defconfig: Enable SND_ALOOP")).
> 
> snd-aloop lets a test setup loop audio between capture and playback
> without external hardware, which is useful for automated audio path
> validation on these boards.
> 
> [...]

Applied, thanks!

[1/1] ARM: omap2plus_defconfig: Enable SND_ALOOP
      commit: 9d6dc4125c110e19026ae0bfaa891fd357163d41

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

