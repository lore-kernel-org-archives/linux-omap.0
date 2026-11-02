Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649216;
	b=atp3LwZLqrNXPlLPONczmYtED3HViyem/W8A5g0/X9ZHIBnewAj5Ih/wL/ea+ZKxf1XI
	 z7uPwKgKkujtGEbu8Vh2NedTKhOYWlzjD6RGHBs4Mxyd5PQFvhUWIdwA1nE5Kjm9WqRlI
	 I/A1EhLDoxMqbinmCsxyQ3KmXi08o29+QmsppuRVY5Bfep1ixdqOKXx2ztLWLPbP3Jpzr
	 zJMNyFEEzGYwiu7X688e8aUxGo7HhsWUmWb14fd6iYrnDm3rO4ReWMv+JlFwujgSfH75N
	 6Ce3l12/bjbM4awZdPNhtVVHlR8DSIt000banHv9ia6w6lUSRuCHhJ3ZZVyM8THNagA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+9P+XFabd3/lMfZildnkql+5b4VafOMg3FdmCUFYRsA=;
	b=YyvV0n2YOxN/+eWoL+6awnRFXv96kgo5Qg6PXW3/yL02ca0mcvxRYZYPRmnl8qEH7Jgs
	 V+7yPe47ay90KLw9RGLLJwHP0MUh8sbjBY7EiYzzy5jTkqhN8/501zxbfBBEBHCkBwO+j
	 lgpfmiXt0e18AnXiVW+7S/d8gHbQ5aYnnoIFRvj6lrkrx2MiEStHVMRcDYcMDAEGkqlrH
	 1JVXpiOyupDhMRQaanMWsUemw/0dDGIyjZnQviOvAsLddfxQ2RydaGz6C4hCZ76sdvjVd
	 VPNNt5JxgKKdZ8NDvOdg05T38gXT7OggAaGcdw8LWYOK0oPJHyQ/yK/+rWjJaWmq9RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FoCqqck0;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E81606D839
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E81606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FoCqqck0
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so17182125e9.3
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649214; x=1794254014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9P+XFabd3/lMfZildnkql+5b4VafOMg3FdmCUFYRsA=;
        b=FoCqqck0/dIk0nU084gpT85Js5tHZSIV1oXLpFmipeZ0Rpn5fP4jLpFezanr70Ucpu
         T/aAGutYE5cAuhSnbawxfCU1njLQRYd9Kq6+Yw4yE18Z5co/FYN9ENntj/JHwI8mBZ31
         9DUCuUWcv9y52j8Bg4bEnlcCRornP77F8Qo2AtCtEEhSr2jsb2t/jyDJ7KFjBksIz3co
         8CXAXV08RiAYZQPPkCMT+tsXP2uoj7ccnV1otmxxbyFq7+5/ZRhofZqV/zPscBUJO3iv
         W//V/Dqq5Dpx9j9UKmcAU7j/wVadte72HBx14no7EzCGtSmQ2ZSPwLKWt5ZRL/KDzET+
         XerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649214; x=1794254014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9P+XFabd3/lMfZildnkql+5b4VafOMg3FdmCUFYRsA=;
        b=ZgZr6Ohvdoc+XzW/bk/n7NOeX0wEGQYqlaVuYQLTXBwhW318xo9rD+jKInGb1aL0AO
         20LVt2I0COh4NvXMMBeVGHZQ/Pc2lEvsdrS+56cswgr0bs5q53vzhpgyciav7wRXRLRu
         D76KRIRWOi7wgWWBYVmtJPRErzgCnyQN3ZjhhGcyPP1190RImw6lMufN7RHV5sRHbuPB
         lNvtXqvoX9eD1I4d6fIvcE6C6EYGFTV13ynUvFbgjFjc5O8errAv1DcmYmtGy6us+ohr
         t/XmI/7wmCNNzNi11qdHaVK60MYz2RXCNBDaUJAEIoMocp1wuXjj+mo6YZtLDTws44Jp
         MLjw==
X-Gm-Message-State: AFq9FYJOALxnS1SER+EPQqDxXP9VNJdUgdcemGjnf2C69PboeszXqpHW
	3nNJO/199uXkemPxzCPjGLw+rB/UNfflnIm6cZw8cP7KtFRcaW0SbI1fyRk+GEfaZHo=
X-Gm-Gg: AYBFou3nAINfJnVrb5/gaemTniqDjUtiZcDKY01QAE3Shi5WIvsKE2MWwcT71yo6SKf
	wJ4jtjNosP1Ga3IIR/6eRPpY+fK8ltZEra9g9VCYgkSZMcoBb00sP7ta9N5nI1iWbe5Qvc4rSRw
	+WarDheLxnVzOETa7ECtm/S9XOBBJDrnAcu31HxILEQkR+3L3UU7d9Nh8Hn27LYyKDjK6/m9uWS
	Fi6fTxjavAOEgmjGmLCXKyFmyyzYyMgmsX+7YjSu7k8iCJEn43N408K84rIxdgKAkcaWY6A4Ayx
	YmkQKc69QMNuZ+LdNedgHej2gaydfptb1PewWgt2Du3buu3TVmiZMm+Xo0HLMo0rX+z45UFEqw5
	8mRP1xnS75CbXuTj9qh0iC/2waCorqwB26JMAJ8WYOXy32JqOLiT7BsqDgM6YNu3of7ie886hXl
	Fs8b3JddGbMsMJjESskKP7Qj93DcOKhGORh3BceK5nRjXr1AXrY2idvJrT95u4C7wmFA+DzLxI+
	sg1sUa+IG3ncXYOi5TfU1bq6RMzXty5zM7n9kUqSGl3qr3MWIbMSJsORJe8D6VB377xxixu0arv
	6z2QOqHl6qTAHahuBkrKSI1mhaWHYsEx59GKJXuhHlgueiYpUkx8+zaCeIjhbCglJg4FyWLCU+J
	jBAmcM996UKghfl2566ejzfhB4uE=
X-Received: by 2002:a05:600c:1f96:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4ac185bd363mr252112485e9.35.1793649214314;
        Mon, 02 Nov 2026 11:53:34 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:33 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:50 +0100
Subject: [PATCH v3 4/9] ARM: dts: omap: dm816x: refactor and align MMC node
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-4-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1985;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=5OVt9RjfkAFqWjQ3y/ErVKQtmPA4J8c1AJHBN4H3pf4=;
 b=AtG3GnlBQFbMH1PqTI381XfB9i4KjV0cI4wKuxJY5/nlIHUOkkQSmKRvpDLY3ROqT8xei72e3
 IwrjiwzwAOnC35m2raB40VjsNgf1dswgTA6Jx6kpswL9jPVXjmTUIhd
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Update the MMC node in the TI Sitara DM816x device tree to align with
the structure used in other similar SoCs. The changes include
refactoring the node to better describe the target module and its
sub-nodes. Also removing deprecated MMC `ti,hwmods` property in favour of
ti-sysc implementation.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index fc124f9ecfa1..1e8d225dfb2c 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -423,13 +423,33 @@ &edma 20 0 &edma 21 0
 				    "tx2", "rx2", "tx3", "rx3";
 		};
 
-		mmc1: mmc@48060000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x48060000 0x11000>;
-			ti,hwmods = "mmc1";
-			interrupts = <64>;
-			dmas = <&edma 24 0 &edma 25 0>;
-			dma-names = "tx", "rx";
+		mmc1_target: target-module@48060000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x48060000 0x4>,
+			      <0x48060110 0x4>,
+			      <0x48060114 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&alwon_clkctrl DM816_MMC1_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x48060000 0x11000>;
+
+			mmc1: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				reg = <0x0 0x11000>;
+				interrupts = <64>;
+				dmas = <&edma 24 0 &edma 25 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		timer1_target: target-module@4802e000 {

-- 
2.56.0

