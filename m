Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFE41B8D0
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202018; cv=none; b=dDQ2BTbsjbuiYoew9DfV7g8yKJKWsWkC/iIdcUsvDKfX7PhUEpvAqfH9rJWAgbsI1SPrgDG1j0csHwtlfObw94k3s9WS4rVsh30N/t79b6133QaGWqgaMrxvOIuLF/h+npaqdV6CsLU2mg7j8gCzAL3Se5BA+DNgt43z1ZnawFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202018; c=relaxed/simple;
	bh=Im70qmgrbAmqVUaeBnO30L5OqJc05vwCNKCuum/grFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2wWLS7BM2o5erudxWEFppz/vC3c/0cSDBfHYUOzOY5OszB/F97tdNXHEJJR4aIGzEAZBymWcOMVY6RjyRMqPS0bHA0vzRoPYiUV3Qa93hs3NqbDJSVGFVwgb9mKswXNmQqg/rqLhwagJGrnog2vFZKJ4QZWL+InvioiQPeuJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Z3Iz1z00; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Z3Iz1z00"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso46929565e9.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784202011; x=1784806811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c35SvQX07tBLJsWKz/d1e1Tptdw74CrKsOw1LXa+vBI=;
        b=Z3Iz1z00DTFaHzFDBIW4pBNgfQ9NoB8nk9B7xzpBOQ68YQZ1bfDa3M/oh0cR8MFEPX
         LmVfFKwfsMRIUoFfAOc3FNxZrEL2SGIrZErV70/wx3tfbNJ9tf+8oOJ/AI59l1XFu0hw
         a+0ffcptQXRtdE7W/3MaLudM7cdBrqaqj+b/fJeCb5eAjDq6aO4MVBMFd7P8EWy8rumF
         fqo//l0q1q9xjurvdAITbBNrPPDrS8AlqL7zeoXq3tOqGCXj+cmKb0JKQev1IdG4hIJ9
         Ue+FS3TF7JZ659nVHwZkheKCDJPQDbU97dDMhFd8W0BeP/Y9w670+Xk+QQ/P4POEP6Ib
         ROng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784202011; x=1784806811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c35SvQX07tBLJsWKz/d1e1Tptdw74CrKsOw1LXa+vBI=;
        b=PoMQ31UMmOZEX7bWI6/O8FSLEexgKZXZmruRhnCTZAvm0T5avW8w0Q32tM1M2jat/I
         KEVTFT/WNTPlOiCmghE35PfPuFdNHauY1Uidi5wuUg8nU7X7hFw2zyVbLIGX//mDm7UH
         rpqqCgZ60jl5K8z/h3/UyRUPvroxqhbq4tS//GRejtB+Z/tdU5mBNvxvwHPNV3eM6CCB
         KReLZjEXxziS5BfB3XHqlbatZQ8//noQaGMEHH5uI9rJFhdhOx+UZUtO59XC7QTBqPxp
         6NMx4fzuHgYAKvV/lkXbjQpcbp2FIG/BSYqkilbeZrrIahtd1XDLQEpimM61w0znKUsQ
         kjPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp63LqufkngN3thuzGEemmmgyU1iV+GAcIpKwQIbwNiSeO9ySmq7AQm60XrOXDNvpRKfZpB2C28NeSH@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDNuAh+ys/cWXrqv++lF6PPffyW1RpCYdczqSeTQ2SN9BYYGL
	4WlErp24ChaelS3/NyCKtSUdVTSDBh+niWcSSZvj+ducTFtYzg0A5DorZGNmOHfzM1o=
X-Gm-Gg: AfdE7cl6kRnEkpk3urfeWmyXDghX94/pB3YzrZo3p4cUV44AHFy+gGYFWDZqgQ4lrg/
	9vgm0WJj38RMQnKa62ZeeWxr8zddS0tvH50DYy3Y+9ZNZ1fYRjgx3WKZayzztAOOWBfdXGPv/iu
	i8tA0G3DeTUJnoDQvrWoH0PoEvry1h8G2JBnyty+YmbsqYc/OZkUrJ/4l2csNJSUmf2mS/aR2CO
	A5yutAKbiDcayHngv0AEi8YCJHXrUTw0sMEYHAR5De9zpWb8bdmUPINvVRWlOlCii80z9j2Zfxi
	7uD8dqmV4b+4LZ3ZMVYy5ItYANXRWjAY0Z7s4bzJIBvFSbueBlJKrZAWIUys3/iJcnUbfck9fWD
	IsJhhRa1kH9+v/h86dH1c0HGhJsJNw+H5OBpUQjO/HmcxdqfE4qPgvTcbRys1Rv893cubPJPeUD
	LkXz4fPmftImAtHPjKxUo0tu+GTFv2nv92NokYTN5d+lkroBSk/xXL
X-Received: by 2002:a05:600c:6285:b0:493:c42c:7e87 with SMTP id 5b1f17b1804b1-4953c2800b3mr70107945e9.33.1784202010654;
        Thu, 16 Jul 2026 04:40:10 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm23611001f8f.7.2026.07.16.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:40:10 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tony@atomide.com,
	rogerq@kernel.org,
	khilman@baylibre.com,
	andreas@kemnade.info,
	aaro.koskinen@iki.fi
Cc: Julian.FRIEDRICH@frequentis.com,
	upstream+omap@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH] ARM: dts: ti/omap: dra7: fix PCIe PHY clock divider definition
Date: Thu, 16 Jul 2026 13:39:47 +0200
Message-ID: <20260716113947.92513-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d0bdd8bb7f35 ("ARM: dts: ti/omap: dra7: fix redundant
clock divider definition") removes the clock divider definition
from optfclk_pciephy_div, reasoning that the table is redundant,
as it contains the values 1 and 2, while also setting ti,max-div
to 2 while ti,min-div is implicitly initialized to 1.

What that commit missed was the fact that the values in the table
are in reverse order, i.e. first 2, then 1.

As is clearly described in the documentation, the ordering is
signifficant, the actual values for the register setting are
derived from the index. If no table is specified, the driver
assumes that the register value is divider - 1 (see also `_get_val`
in `drivers/clk/ti/divider.c`).

What is in fact redundant is the value of ti,max-div that is
derived from the table if none is specified. To satisfy device
tree semantic linters, it is removed instead.

Fixes: d0bdd8bb7f35 ("fix redundant clock divider definition")
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
index 0de16ee262cf..615a8fb47776 100644
--- a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
@@ -1376,8 +1376,8 @@ optfclk_pciephy_div: clock-optfclk-pciephy-div-8@4a00821c {
 		clocks = <&apll_pcie_ck>;
 		#clock-cells = <0>;
 		reg = <0x021c>;
+		ti,dividers = <2>, <1>;
 		ti,bit-shift = <8>;
-		ti,max-div = <2>;
 	};
 
 	apll_pcie_clkvcoldo: clock-apll-pcie-clkvcoldo {
-- 
2.55.0

