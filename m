Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173482;
	b=Gboq34doWAkh+NBRVqIPMtk5YKdACG9Lptqds/Ka1MH1Aph5+fFccfNd6No5aye3ohkD
	 zfGQKCKpA72tqpzRdLMSu6jrgYFF6AvTuVcKlCneVOxb9HwJesbRWhy/3V+fVAiDgyI9C
	 Ss+deaOAm3uM4MlLDnPtdZMPcHCAaPKsDaj0QCUjUGo/V+7hODvDvH9HI+uXBNpXetP3P
	 ucGFTcqHsxUMV7p3iYq+GZL56JzKokiPPgnvmGDao8tVw9kz3EG88ZR3lOTeNfUAOVA70
	 +oHA5LhwnmXJGYqphjZEvN9nUMgoCijScbkRLs9H/QRkuLgQpKllcQc9ooywUTWEl0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9PPD/mUgGF3odbO9HUc+ZEDM/rOsDf1Ah7YKLsgVXgQ=;
	b=qFw/XS2kMzqS+lB2wZxOQHomhOs8x1Uq/EL6/ynrh4t3+xmYSX96+GlYSwNsBAClx3cg
	 Xs/GKDe5+EhTzppWdiZ+qx9nRIpgDfGL09Rtzq2+5n7c3rp2QbgnsS8l8ZYFdVyZRtMVK
	 Cn5jqtsTKQv/qRwOQEO+2UiimRO9l7hWyiq4jHoxN5IOj/vUloZIQZagO4PjL7v75lRYw
	 b5BsLeuT94x1MXZLgJrq3643yxFZ8waLiHE8UkP4+hXlQoTe4VuLT+SsDG6X8jQ16ipzD
	 Np57HVjJR19ipEazsGYcpHIpAuYjGPLZobDypbVkavmvnEL+RW5DTNVHc/IgaeXP7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=o+dQgdtT;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9496606A31F
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 07:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9496606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=o+dQgdtT
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so4030345e9.2
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793173480; x=1793778280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PPD/mUgGF3odbO9HUc+ZEDM/rOsDf1Ah7YKLsgVXgQ=;
        b=o+dQgdtTPUArIk8G4DW9Oqsp764+f8J6aW0ayYaDCegAjgvjAOMBnfqzTJSmDzmm9n
         i+NZAC2XlxKHwZKwEPJ1B5aeJF5Pg1JAVxDHGVWJXAXwG7tAR4hxMgaOdwgppP/CRpck
         ruDoRW+vGo3C1vOq0mA/5x9Lp++jUhBtyGI18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793173480; x=1793778280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PPD/mUgGF3odbO9HUc+ZEDM/rOsDf1Ah7YKLsgVXgQ=;
        b=WGBvQ8b57YUntL48SgHimYZCs+T3I1bhLmvvyTyTu+Z9kwNlqEu/5uhNy8NPmcBrwz
         n/iKJSXXWdlhkHAVziwKv4VVt+W+akGM4Rzi5VuSG8I5psJorGmhHFTgrTvGXqzTdkCT
         lFQsBAjptPDvi9pxFb9qvNOQqOAxbePnmSfTqFG10PxP1pNQGyHkNrBmPd3y0shZOlc6
         GvS6p7OapBAo+sbjq889sT+1eU58aIV2vctrdslvP3Y/w6rxe1BfvD2Qn0JxRztvqrpK
         svPvrEJByy+025vQZrBlRfvlapK3wXXD6V2qYihT9q537tL6EqTMQm3h2pv+6hQVRz+o
         vduw==
X-Forwarded-Encrypted: i=1; AKwUvBwLC9+he5y6V/OHN+f1mWxhp0UnuNZ3OHC25jX77MtZEAglJAakE7kPK2fmQVGvc/MEZSuCj5pUihcE@vger.kernel.org
X-Gm-Message-State: AFq9FYL6gSUH1ZeeKY9u8SctwJQZznW08+pPnoxtrs++gP6bMu0qvjN2
	mwc+V78CWTFyAxLdENhluiMjX8q3pGlh5cxHTrMfpyQF/TsvfECOMLVz2bmzYpDgxMQ=
X-Gm-Gg: AYBFou2Q4LPUvcWbJmMdH64qN3vYIGZ5sabFc00mUkbvHUg6BHm/HjX2HM3TVDSunDa
	BHQeFguRW96Yp9EwvA8TVMTapWO8bTYVFEa1sfSdFdnF5IJrYEbinuaSEDfpyFIvpGSrZW6RKAJ
	8hI5M75BOpeIemajXzxD8lhA3WdCTNXHJmhzqOICVSIiIUwT9f8tk+DL1g1mQM9nWkzzTg0p4aE
	M7Y8yTK1AIhv5s75srBSm8qQPN1Zp5ZdR+zrhchvUQGTeu3Nzrh/KJZNkmPlHGqbNW2W1e3agP+
	7/XmggpDV3+xkELUdnRWdtNJ/9Xes3YcETu8Kc1H0PRr8KeDvuHiDwYPqI9MMJ/rjTRe7DlMEPx
	bI+rWfEJe0gnqsKaL9CMb2MAzNopwFLB5iLRRilF54yMptSOyCN9z+ZOOWFJmSXwLQgi+j9JEpz
	gyfvKdiV79aWRSLrkxhoCbsbS+BKoud18Msfo7DSNYTVKCXVGKmyRGpyvdDJm+SfhBD/BkljTWe
	D/NxnqGqAeHZEJiMFZZqzLke15cohdMUKdSNjoX9aZQpAb4VJRlXRgcaWOFAptTkkZnMdBO7WpW
	W3dyXWf/pF7gTf79JC/sSj9e+yK1CdjZMqV9FTLtNVubY5EVen3kewpCjMpXuZykYlARHNfPwB+
	OT+KSjBie6BgypDSCG1Y15LwcVTQaqzITPiDZ4HvfWV3xm5opPw8+ShGQK1iXQMGMlY+h3qeEbZ
	38HCL/CyMrHxLj0dWw75l+XcBOttcaGvi0m7XVUqIPTzu1AkQ=
X-Received: by 2002:a05:600c:608c:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a967016833mr27902555e9.23.1793173480359;
        Wed, 28 Oct 2026 00:44:40 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm25324882f8f.7.2026.10.28.00.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:44:39 -0700 (PDT)
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
Subject: [PATCH v3 0/3] clk: ti: dpll: switch spread spectrum to the generic framework
Date: Wed, 28 Oct 2026 08:44:06 +0100
Message-ID: <20261028074436.1958132-1-dario.binacchi@amarulasolutions.com>
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
so the series moves the TI DPLL to the generic configuration and
deprecates the vendor specific properties.

The last patch applies the configuration right away, as the clock
core skips set_rate() when the requested rate is already the current
one, e.g. when the bootloader has set it up.

Tested on a BeagleBone Black with equivalent parameters, set through
the deprecated properties, assigned-clock-sscs or both. The dpll_disp_ck
SSC registers are programmed with the same values as before the series.

Changes in v3:
- Deprecate the properties instead of dropping them
- Keep parsing the deprecated vendor specific properties
- Skip reprogramming only if the configuration is already applied
  to the hardware

Changes in v2:
- Check the DPLL lock state instead of its parent, as the reference
  and bypass clocks can be the same clock

Dario Binacchi (3):
  dt-bindings: clock: ti: dpll: deprecate the ti,ssc-* properties
  clk: ti: dpll: use the generic spread spectrum configuration
  clk: ti: dpll: apply the spread spectrum configuration right away

 .../devicetree/bindings/clock/ti/dpll.txt     |  9 +-
 drivers/clk/ti/clock.h                        |  2 +
 drivers/clk/ti/dpll.c                         | 20 +++-
 drivers/clk/ti/dpll3xxx.c                     | 98 +++++++++++++++++--
 include/linux/clk/ti.h                        |  9 +-
 5 files changed, 113 insertions(+), 25 deletions(-)

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
branch: am33xx-assigned-clock-sscs

-- 
2.43.0

