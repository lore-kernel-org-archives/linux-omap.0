Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7154C8FE9
	for <linux-omap@vger.kernel.org>; Tue,  9 Jun 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043960; cv=none; b=AlH8iYH3+Y4Xk/wQh10xin0lLMn0U1wIa+CUWjxEAleuAnD6V70hFGtWFIiNAnK42+OUYqNU8+pTeXxZDjXvH06yfLNWbarQtLcSN0UxPeeWloVPIKu/YkVNN4Ma2gG+naRONDSg142hgLLN+m8/s+/noKuDKTfgC46mdL6r/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043960; c=relaxed/simple;
	bh=cH0AUFHZE9q5xpLi8GHp/gkP4tAfEF5rwuAl8hukZfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IXZykvhJ/by6FxJLxtXPHlMUBqJLa0joPSjx0tzqWzZV+dp0iYNELaxBl4/ETY0dtDODgl006K+AgvS8nFodlYo+RooV4xAHeJSMW01mh+6Yh0WZRfuZm2Sz61bWFwiTu422ppUyZf8wMi+yCTPZI7mKzX1wnxBiYFCQ2uQWgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L+CgPoDp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L+CgPoDp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so3693039a12.2
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2026 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781043958; x=1781648758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDo3xoZZjuOK7GBHTzPJXELFIQpIIEL0agVkYHucgPY=;
        b=L+CgPoDpbxxPcgCnNtH8W1gSiKgCGfF/wBkT2EOwF1rYV0vq8GcZG4VZjaUqeOhYP0
         /MVxeamD1lVIOr5PIUmt/Xm1QxEjKuu8mIi8+1zkxtDjVxwo08n+VYWfzAaJdIxuKTwt
         B6q1Oib2959lkWksKw46dNzphIsmtFxoNvIj4x3NGD9fDjPjXalJLsz/JjFEmtVYSIfa
         tfUrANw3s0Sda9YHPnGvGhe9LOmWctz79Me0/5of9rQipICu3qBY1nSJRXmNprM7kXax
         ajhugdCMSVgENHuJjl0EeWPR1742+x3Hmkb6V4fZv1KaUXLhc1P3vDfF/JeCO22PzQ3x
         i7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043958; x=1781648758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDo3xoZZjuOK7GBHTzPJXELFIQpIIEL0agVkYHucgPY=;
        b=Q7J38/y1eS61npxyC5RmUe9//r500TS2g/gsL0AgoAsbPBl4/thjuHWveDRFzt2DM6
         cQfsqrlBWyceen6ymItMsJhi8AQvsRSf053SpNZVJynUemcXsfsN4ftr798h1tNWCZIm
         tVwu1Ue+qTwb2QYKKWCwzGsw7n/Tp2uD0Tzg/dvuGHmVNbaYuBCW9mm6v0uLsXl4LJxS
         EGgs1BJdh+InQNVkGtq43VE3enLJDdp7u/+nnrXXNjfqjQwtXFVree91ufc3JSuWO7dN
         U6bH+g/G6aQiS9Q5W51BxQ1S6vo7tr+GphWGmUf9uR2UUMLuhKC9z7EJqky2EfnL9a/x
         I4/Q==
X-Gm-Message-State: AOJu0Yw9O+v50Ug0njSqpbzaoeF5BvYr6n5x4A5EYpMLGnD9B08asBZy
	pfyOM7Fk0pTGa3IzfT3CXsER58HllSEfAuQsTkF71d1NjH9GeFJFMX4nY5p+sbwruYs=
X-Gm-Gg: Acq92OEcCCyKPsHJJqCUT3yn44EI65g8CiqzjaKLnwl8paHVkBdm9F0iU/R/paVT2+o
	iLUAHqBBUP6Tdza017snQPOL7Atrvip9SPr9HWvOuCfAM8prGQkkjJ/ZRcY581uPAAvqPtoCIEd
	gU5JbQxrWFf4UUJTHUGzUxZi+OdJZ215Pp+rpOg6XNCDpI4Xbp4nAT9zFAWm6xtlaN46pKzGdbD
	r32gl6Qi3WhxPdx0OlXW1lUtXzLPr3gexJLkqnMqqHOENTBXdtwoKzD1wps01rUbjsiUGBYecYp
	SPCM0EEoUnC3mlxtWdCaAWfP9ot5dn4ZBoWwIo9zB5688tlIAqhbbDhREkrAbl+nAOjnQOvxmuS
	aVhcjXiysqbILI4QEEb3Qrq7xS765RLQKv/7Y2IcYV5YO8PXXf+9PFW3+wmm9SYbESnD17EMROj
	QkBBEGxluiZgUbQyRavK10udMF9980wmo=
X-Received: by 2002:a05:6a00:a201:b0:842:6482:aeb with SMTP id d2e1a72fcca58-842b0e4c633mr23052675b3a.12.1781043958612;
        Tue, 09 Jun 2026 15:25:58 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-84282882156sm21772573b3a.33.2026.06.09.15.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:25:58 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Yuho Choi <dbgh9129@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260504164711.2854116-1-dbgh9129@gmail.com>
References: <20260504164711.2854116-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] ARM: OMAP2+: Fix OF node reference leaks in
 omap_hwmod
Message-Id: <178104395773.234140.5232479365136373455.b4-ty@b4>
Date: Tue, 09 Jun 2026 15:25:57 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 04 May 2026 12:47:11 -0400, Yuho Choi wrote:
> The OF helpers that return device nodes acquire references that must be
> released by the caller.
> 
> _init() leaks the "ocp" bus node returned by of_find_node_by_name() on
> all paths after lookup, and also leaks the child returned by
> of_get_next_child() when parsing module flags. Route the post-lookup
> returns through a common cleanup path and release the child after use.
> 
> [...]

Applied, thanks!

[1/1] ARM: OMAP2+: Fix OF node reference leaks in omap_hwmod
      commit: f7ab9e7070b8dd77d6f8f7bd1162b7190af8694d

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

