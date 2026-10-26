Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000820;
	b=Tw08gGmxLi/U+IlytwRz72CIFN4r410cYgcwmevdMTPQztp5CV64TeHu3flDimDhVzo+
	 d3wXnVzEt3OToXm47qmToRz2n9k2y8aQgfEiFsbS+QdISmAOAuYpxloZD5kQD1izr0E6L
	 RV/tC1xgYsWOC4iOWHWIjicXLSsSCbay9179fskMpXKAXLmb4nXlZmJ8qpFoM+ZNNL3A0
	 Eawu7hs4No8gtja32rXNn7mpYfUzpg3LAjdWMP5Y5L4y7IafYCmYaWdHlh4CdCJpgS/eG
	 zxsHyt4aG7/YMkCZac/6XQQaZqQ5NHp0GBvITJRnFsNlrNiYs2Jh3qE8opZ8DPwP8Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kgNgk7mRDAkVIJIniFCRm3A7Q5etj+qhlWnlfW/Xdo4=;
	b=t/sCboeeM+7z/nAq3FinvSVKxoxph2OzesAauGEDlo0zisWgn2L4hdvCtVdj0UHrhbyK
	 RWOf6FAvEJlAO5GJ3m86moUIqJo20LCy5gGEAU3SiV1XLxBV33B/qd94WQWd0Fxz5u5So
	 RgOYEBaZitojZi/NTw3dDzjRA3u0GugOgj8gnTS2lnazrplHZXQEjNBGwze1+pwSEpU1Y
	 P1i0VFzJI9kJc1AGvjqdYqbD+aOlK05MMZxHrYGHlyQ6ie5MYjqFNT0Xd4Mwmz1wUOoIJ
	 eMRP4N1LHv7hJmYZJ2RXCQISfwb5zWAbGonzWoCIbd+2smWV+USrhJwh6tbQUWhntXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oVCZUiyX;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C86606A320
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 07:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C86606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oVCZUiyX
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1617768f8f.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793000818; x=1793605618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgNgk7mRDAkVIJIniFCRm3A7Q5etj+qhlWnlfW/Xdo4=;
        b=oVCZUiyXw1lfiBhfxo41FJlK1qi2BtYosNra8np9mSh/DJ68mSBGzyPJWYmA4KBAH6
         vU4gQh3R5fMOth/IlDfH/frNDmT+mv0GDkd1K7glrfnahzC1aV+6oBsPSP+alGm4Q139
         9qFU+55MFyqIzRPJ8KSKohV0T6zJkzeEn+cho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000818; x=1793605618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgNgk7mRDAkVIJIniFCRm3A7Q5etj+qhlWnlfW/Xdo4=;
        b=mmWNXd7bNCvbdDPNMLCkP4bAJ8ynbuKbr8zb3lo65KItU11rNe5nw7ljNf8nEklcLX
         Ii7VUsEJuKyDWCUzA5e568SrzAFe1R9L8xCA/2VwBEMZkghOOrbJgYXX/4RNqyiipabP
         X/bYIkBQbHnUr/pKHerU+t3HPxL0FkkLIGKs7UlM6+x3HL81L+u9LdT5QylcJ19CgQVM
         CPK9dJLBqBCq0cQJMhycv1Y419wxZpRioqvMtkTJJWp6YHnm8dCc9F3WKhhyCvFZTYlS
         8GfFhYICqWWKDxX8KsGng1sVNke270C+pXh2hJ7C49fHh/eHdZ2NJ2/yvOB3/W6h60f/
         7zMw==
X-Forwarded-Encrypted: i=1; AKwUvByfsvMPS8Sz9oiIGbxu44YcEs8mm15GvXqx0mnBVK7BYpihmnA3HiJdIKe0VvepSWZklfQRWV4d2L6q@vger.kernel.org
X-Gm-Message-State: AFq9FYKhSmzk1o6igFF6JxrqeJY3Xw+rYzRNOBOTbrobSEvKUDALBt63
	oxLNLNeNATlT6elDHUz76rJBEuIFK/KvWR/fB9grjR9lWL5OPWHPgjmPEkvCvaz+PKU=
X-Gm-Gg: AYBFou1J8CWCbeQBpDYpQJvZwwU7hnWmZFFHkJP6uMC7+WQNFkO5QYc5Jj8ZOErL9/W
	N9ENwvCNJ5e1fQEKOtlohfANiphvhEV8pBNDXfBEUcsbWqMadkXywMh0/hW3kMgYWJnKdEOQmct
	gJRsNotvRocJaxlWxZ/G8PogCqhcL5Nh99uze2p1sOODwyQN5XHmq9gEvMlqMvhKjWJwF1Y0bgg
	sRRfDW7rg4FaYJMbkijTMqurbKSDkFwCQ/oXaN+u/uIFULsHMDt4n3QAgp0ykP0VMh36mjp+PCG
	pSI2T/4+IcljraiXrkwW6Rl3um2LNbNI0jK6AvxKcW3lnklCKf/gYOYJ7aVw2w6rMQcnY5QFHVX
	OB13kOSqfy6bOQ9euKKBc5yPplB15EKHqSr1t68gqhBrGzXI41ETruR5182gbuELRdWAwxzUZ97
	/PfUobfN3m1qEaYXDlrV+iGwyAxSCY1gFEACwe/ck3uZlO0lOSc1l6AI4jII3MGUz+PGcI8Nfiv
	h19v/d7OOURDSYXR13D1st+cp+hrpm2054NbDILxJL027P57HjBkEcDrBZdfAHAC6lttJagPFdv
	Nw7iS0nHMQixlW5/Glt/1G4r1I6J3tYIO+cdO9ynUuWk8OG/QNlmAvO7dWRsy9iI0vbQpOofZpo
	nfwvYZRZQdbC80Y0pOTDOreW0fNmCTUVX/x5XN+g09GCL3bCnOf8u
X-Received: by 2002:a05:6000:2003:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e3eb73c36mr12890000f8f.13.1793000817894;
        Mon, 26 Oct 2026 00:46:57 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm13731353f8f.7.2026.10.26.00.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:46:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v2 0/3] clk: ti: dpll: switch spread spectrum to the generic framework
Date: Mon, 26 Oct 2026 08:46:26 +0100
Message-ID: <20261026074654.3997494-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The am33xx/am43xx DPLL spread spectrum clocking (SSC) is configured
through vendor specific DT properties. Since 7.3 the clock framework
provides a generic API and the assigned-clock-sscs DT property for it,
so the series moves the TI DPLL to the generic configuration and drops
the vendor specific properties.

The last patch applies the configuration right away, as the clock
core skips set_rate() when the requested rate is already the current
one, e.g. when the bootloader has set it up.

Tested on a BeagleBone Black with equivalent parameters. The
dpll_disp_ck SSC registers are programmed with the same values as with
the vendor specific properties.

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

Dario Binacchi (3):
  dt-bindings: clock: ti: dpll: drop the ti,ssc-* properties
  clk: ti: dpll: use the generic spread spectrum configuration
  clk: ti: dpll: apply the spread spectrum configuration right away

 .../devicetree/bindings/clock/ti/dpll.txt     |  6 --
 drivers/clk/ti/clock.h                        |  2 +
 drivers/clk/ti/dpll.c                         |  8 +-
 drivers/clk/ti/dpll3xxx.c                     | 95 +++++++++++++++++--
 include/linux/clk/ti.h                        |  9 +-
 5 files changed, 91 insertions(+), 29 deletions(-)

---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
branch: am33xx-assigned-clock-sscs

-- 
2.43.0

