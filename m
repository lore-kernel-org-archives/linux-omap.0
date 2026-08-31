Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7434A78E
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199868; cv=none; b=RAVlqzHuaWYj7szij84Qxl9Vl8xRvo6SaboO7mTCCx4sFdqnc9W1POG/sbD4KInkd/xH+Wanm6BrXLRJKGzijOfj9blAanTWcB/DFlvrlIYdgPJLErcvHS6IuM1pT0MzNKduXyyIjT6vanIAzlyk/ZfYWYQyjJ5J2xHw4SEY/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199868; c=relaxed/simple;
	bh=yjOLCTPmx4PvLECBxj5Od38tAnTgXsfngjPZ98hkwec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HVXeGefjNSlfBMirtlTRZHwiMEPJSJna3eRRAqyjFIzXThLZbEG1Q9zf4GSdyACYNoRTwnTUCkPXpcuZH1zGxrxqcayEJVJIb4aAa77j9l1LhwpoVL5MktUJgVxlptQrzp8ubdhAWLy2rkwXjcUwNd35826DDjfaqWV5coI6qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MS0ASUT9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MS0ASUT9"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so59813a12.1
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199866; x=1788804666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EI2uoMQ2Bv4HGoXR37AMSbNrDmCDC9d8CsQuF9DQvSk=;
        b=MS0ASUT9+fY1Rq7jNo3uXDxumjWombEY2hSpbSmiMRXwrPoS0grGXQ9kcVThMYEsTe
         HDg+i+qSFC+Z+z5jvh34s48HqcYfx8wm29em31kbrH6Vlc6J9w5EgkCU+xGO7H/HjZPm
         DO1x74P61qjSiOpHi6qKU4Yh1StZ8lZ/V+ug/gWsBzswvmYrJrnS0ulYshvoSB5mGyN5
         Y7l/tqzkrFYOa24S3Rf9oOisb7fXcDSXPxPxZmXPH1pTbtYM9cvMI18d+IjAJIT6LY6Z
         p4vX0xTuKtAAi7JVGC10CrhL5WUuqnihzgRuG4iXsRQ0QUOiD2DZethI7wPig572YEqJ
         1MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199866; x=1788804666;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EI2uoMQ2Bv4HGoXR37AMSbNrDmCDC9d8CsQuF9DQvSk=;
        b=VyEEyGBjPgG1KCyUpjGaoFTeX7PY2gdcA2CpcBi/a95L4mtvPhk4wmsopJjceD65my
         ctCST+h+psCCR8bo9Wmu3NJ0oG+fQou6Yoj5aUP1e7Zv+bTrR2QG1j/JGK99SFcnCDwb
         6a+Ut946MqyHTcSZvOhsnpeMWt5mAAXLKJemDqzHtCPLttZyf3gYHL9BhFF3SWKK8YgF
         1RMNzh5RG+quKewmC/eLlkgnfTcZfdRvt0vg9nD+W2sevSXY89FZMV/ecSDCrEILG9CN
         fxpG6QPH1t6JAeW+FVKMlZh3o1B8Jhcz7zPVTp1qCNsSZ52K1yhgR87Mfdycd0YJYHPT
         M+jA==
X-Gm-Message-State: AFuF++lE+zj52TNdnYTh8Pb7e6ml2pMlYbj1q+vt5tDmYBtHns9SGvzZ
	flnRCV/EBosNoKKdGwoNhPCIcx2YljDWBS3nqsL9jLfZz8FxqtocLte7SPKV5kdPi4U=
X-Gm-Gg: AYBFou2/jXbKM3xON+vcQzyBSULDrUwkzyBgH8BOqIbC1NbbTlJM+f4J3P83/bg0CdZ
	VTW0HGJzZbs6ttOckZMKYL/JFrpkN5bjZpbPs6fp68IAS7BtSU2ncCFC+mUWG7YJErt++t+EW1e
	UlfhEONsCVSZi9o85i2AU5cwRzhNTXSSjujsFOBfwXpGaACJG4bpZOChuS5SqmJdc0zXnOt6mIv
	DpTT4T0eOdYXOjan9BBYKZszYTJfraa1Z/51u7V0pdVKhTlcC7g6gFvqVv73PgOWo8fCJjT1oZM
	Qn8gY/eRyNLQVPcibDpBNh0uOtjRQiE8RK8T+LdwwafZ+o4fwmxVYoVAtM52l/MQDKEzS2b7D7N
	+FI/sJ9W/qwoCTUJ8CEGMK/6mDL6nDgMxMfKmGwX3rwNpgaLoaT/KV6CO/OooT8EYw2ewd8HP77
	14OjsTxiS/X1LwnLm1WOAreGdSqSPGiW5kIFMKeIYhceH7g2p2vf0jVsWFQlw4ZlgcbnVC
X-Received: by 2002:a17:90b:564e:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-396d0ee7010mr39640222a91.6.1788199865979;
        Mon, 31 Aug 2026 11:11:05 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d802787sm821907a91.16.2026.08.31.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:05 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Yuho Choi <dbgh9129@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260615200540.770205-1-dbgh9129@gmail.com>
References: <20260615200540.770205-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] bus: ti-sysc: Fix /chosen node reference leak
Message-Id: <178819986489.2869653.4530826376882355850.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:04 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Mon, 15 Jun 2026 16:05:40 -0400, Yuho Choi wrote:
> sysc_init_stdout_path() gets the /chosen node with
> of_find_node_by_path() to read stdout-path. The function then overwrites
> the local node pointer with the stdout-path lookup result, or exits on
> error, without dropping the /chosen reference.
> 
> Keep the /chosen node in a separate variable and put it after the
> stdout-path value has been used for the lookup. The successful stdout
> node lookup remains referenced by the cached stdout_path pointer.
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: Fix /chosen node reference leak
      (no commit info)

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

