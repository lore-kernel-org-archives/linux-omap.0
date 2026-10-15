Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6215581FB
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083306; cv=none; b=GRTe6mI/CGXy/BxXAO9PSEzQMB9TfNRJefF7JMS44McgCRJ4/KqUv+2SE9KAj63GlEgARL8A6sB+6uZkp234/Je4eEyyZ+hVvXjL6osn2v8SDmN2TE7L7rtnf8+vwgXtGGsiZHUL9ib4GdM/go7LeGCsiU0QGDRgpo0vtOB1dFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083306; c=relaxed/simple;
	bh=nNl+aWdXmjwtXODSPDByzsezc844pEMLDbyf7xF3pRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSSUuv3/j22seNRNEk2bK3Pcz9HES44NqOfoOxLzZ3p6OScI3GQGlMrHJxm3lZHqGqe7IKvs7TEInnO0036kPplnjWQX0FLZ7rVuIUCkf5as4llrc/Zs15g1CWhuNqjhLzKIcyYXALAwy18Ccg/EUwz+ua8Rqa/1FFAMKptcBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z44DwCIr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z44DwCIr"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48870973bddso118468f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792083288; x=1792688088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWFqupga0Da3LDpzfcjDFK8WTaNzOGEEKytPnY4vu9I=;
        b=Z44DwCIreNU6eqKiHLHOOgs4IIZ0CXGhDs3rtB/9bzdm0G+xe+D3HRW+qOG79qMjEv
         qNy51csXQ5ISXG6b0F4DbO031IN4WAYNAWCiBJFYU28cVItexEh9YD35AwiSIUVmwFTf
         Q6TkUw2OwAzh9JWnprCH6PVtsRFZIwkRSYjfqSV1GEWotnw7IJNdv7uqJGXiHtsAlslS
         eEBFsv/XPfIR8UWvJ1A4Ucc6W0znAnqGg7Xcj5CT31nC3kXH1eQ0t1qJ8cFkhyfhGIPF
         beHrUurRUVg9omTMv93rb/DcFP/KZlp54Xnb+n2tnafr9DoJij4U9UKnww9651NJ4JtD
         j3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083288; x=1792688088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWFqupga0Da3LDpzfcjDFK8WTaNzOGEEKytPnY4vu9I=;
        b=Vxe6rbZtMPNMDYm4qm8z8Op/FgR/fN0bMLIFAvjdckJdFplj+ewLaXUo5ydubYdANg
         fSfRodVl6YKGO0diyL8pbCm/YxTKFHQ1AV7Zs4ydT+f7bS5djcZ/1F5LhB/YWMHDGx24
         eXDoduos/9MXalZk5x9qSYOg1uJKgnL0v3GrqY7eJrRE2JjgiytnsxHL3VZMVmKKrVq1
         5Ypot80982OagpgUcNewFQxK4LvFX4yYFpioaIO8sNGsOymVRaoUr6kHnzkj5BQqposn
         osfIlJeBYn33bq1z9jw+nWnRtXV+xN8P36GEgVFM93UzHOs+YIoOZ9RJW9i4UR8C8uPX
         wrsw==
X-Gm-Message-State: AFq9FYKiJwoJOEXwaxoKdEOwoCrZspj6R87+EQ9dtVoi+nosQXYDShEX
	Vfc5T8fjRUMPiGwDoDXpZ5ceL7DGPGKGBrRi7cvD3sAHwHqJV4U9z7kCupksl5lYipI=
X-Gm-Gg: AYBFou1cRcCOndPyrYW/PMkWQ0m6Mb8HIucLyrte4uUfxAJn2N81RAzGZ76l0pq9Ab5
	WChxAGq2KqhkWUboOnsn5ImGbOhxzzCFDhz02ty7aLCCVt7su7zF/PxZmbcVPxj5DGTKKDBqoL8
	wS+gwjpdvMi449OWs5gHW5uAaNL0TjIIeEmj1yu5y28XyKadrMs5kZNS0rJoqVh9dJjfH2Up//Q
	WOyX36g6Ia32b2k88ZBGAWulY7JCOKDq8nHZ6tD2k8MTANg+piUI7CDjTTy2E6C/XrX2dWv7Zd1
	ZQi5WsqbStzoV1WRjR2WgsEeYwLkjatRoSeZT4vVW5sPi4FWmh1qUZ44OwjYK6QJWIBnJ/O0J5e
	SypCuvTVItBjllkVaieJ8iGDHe2gEjQa4/alZYJT0cWCo/fyfvga3KAaXuZyUI7CI7z81B7ZWhj
	dwDicj8Frftvd4TFIHG2nR0BRxBBIkQ2FsflsBXEwSz+rGAji211xL5fOADLyHU1Zm9KFBzs8aF
	BqT+rMB/R6C0PN3iPEgjYKHG2c3oBvnz1dQn1oNld/SCE265w40bXP9YqUYLBILz+DXiA==
X-Received: by 2002:adf:edd1:0:b0:48d:f1ab:faf9 with SMTP id ffacd0b85a97d-48dfae1ee24mr1225054f8f.16.1792083288385;
        Thu, 15 Oct 2026 09:54:48 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm20775664f8f.12.2026.10.15.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:46 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Thu, 15 Oct 2026 18:54:32 +0200
Subject: [PATCH 3/4] clk: ti: fapll: print clock name that fails to
 register
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-patch-ektor5-dm8168-clk-v1-3-8b99c5cd5541@linaro.org>
References: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
In-Reply-To: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792083282; l=826;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=Ja3D73iaM0XrrX8Ixe84Fx5s+9skcP8lleOkVCdvv/o=;
 b=Xci4KTRtILDfRu0hmxsWfO/nunPhLFDznA3uG4T4fWqGPu7dmThhKO+TibQMZrU4q6OC+sp76
 Px5shKBBIpwAhCyVsbdCgTE7utS17Y1mwhPyqi5yN6CFe3LgHYp2L1c
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

Improve the error message when a clock fails to register by including
the clock's name and its parent's name for better debugging.

Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 008a61f45ac1..5aab90cf5438 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -520,7 +520,7 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 
 	clk = clk_register(NULL, &synth->hw);
 	if (IS_ERR(clk)) {
-		pr_err("failed to register clock\n");
+		pr_err("failed to register clock '%s' for parent '%s'\n", name, parent);
 		goto free;
 	}
 

-- 
2.56.0

