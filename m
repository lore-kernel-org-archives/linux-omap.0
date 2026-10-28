Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202854;
	b=5WYv1+zWZo5YOCDSzvuPRZGr10zDIvinu6hS1Ue/bb33gR3cy2erYOFi8ARmGyay1REM
	 7myGHnSU+gA7sYhEAPGdgPVY/vqlpPLpL0bMntKaqDvk1DJt0pnK444RHPcc1IZl/RmPz
	 tmXm5tfZympDNRgReN5SE5tbrHEbsAhvCH/Um5wYze86YEe1dEHQdkL7787LjxZdr2GHg
	 xAoRaCCkC4OtA744ToSFt7MOyBP2DWkjKoWAUNlV4IsTGZHWOT0KRvqOADw3dctgFr/yN
	 JroKtgEc6SVGAu7lPuhfOoiAK8ydR2sov7t6JUwRbfH6vVKUnwnug7ECggXpFpVN+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nEkCWXmywVasB5aous9cspw5GRt9O+utplNrcCJYuUU=;
	b=KRJDcAkCJ5t4/FffJ1EWbVgMpkJDdqn9ndQyC923JQZ4Djk2gLdb0EdnBpdKN1NKXQ1z
	 FgzAjnL3eU8UOWoNUn7SDVBLuh8BPR94qbCHnV8y1Hl+31MDr148vniyXm9NaIEoqis0M
	 4Alm5lZ0lNt4WOitpAdrIf/Gp17SWrn7bzAki0i7bFBb/gwbTcAPYiv4c1SXgWDcQJjGb
	 45UXxDZ0kTcZod+8M6MnUaHVGasqPTUg5dL9Vd/wL0RyP6W1uMWONx7SRyH8VBMAobfnK
	 A9AraynF0pVrR/RSjdDVCtJao8YhTBiKTep58/5XuRCfMTolnIIuuquFWmHQuGuOaGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yH2pgolx;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089E606A335
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 15:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8089E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yH2pgolx
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so11062005e9.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793202852; x=1793807652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEkCWXmywVasB5aous9cspw5GRt9O+utplNrcCJYuUU=;
        b=yH2pgolx5MStzUCBLacPP72F8Ww9UXttiyhaOuJhvSv1JaTU9j08Fj70XyCKbGJcfs
         hqFa6adYqMLTpnp+1YDPtQGUPxA5ycTtCibj+e6WmWOfU4cUBOetcL8QSbY5VXMXMdP2
         ihWRaQfsLLRfcY+d9uRWC2L3ZTPOO4EgKfp0Epc1/pK2BEY3Owl9DU5Fwmujqzrm87Md
         lDFjiUfaiLtf2aI96kmiqJvRZ0ahipy7Sl65xQjAouw1eK0ro/KqlXCM83rzrVzcbnln
         EF9Ey7COylaBBIjjLCBnnyvf6xsTxahTPz1UuimuawcVnqnGCwM+3JEWxj1qeTXJnuil
         DweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202852; x=1793807652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEkCWXmywVasB5aous9cspw5GRt9O+utplNrcCJYuUU=;
        b=vpSf69LsUDNNIqam0jqyALKjUd46+gl0Y9aGIIOoqCQ/CQU6TbESJbhnH0uPOtpXYx
         jfkw5r1oZXz0wHVveriyl5h7FtlVA9IU2Mk/URJ9Pdjq9p6i/6RIholbOGhWeFqugBDr
         A+94P4s6q0HD/amZxfRQ3TjvSrv2tHuLEMF4YZK7QyUSfJ9n4iQtT8LKJU65R6B9A8Q8
         IegzGZCU6cxn1VZ7nGfBrfd9cXfXGr/7xKeFL0rfWCOg/Kd/1GP/MpmnHKIq9jaAtPtL
         qVFl9pPcRr3NrUcgjM6q3OqGIsR6M3QsjYfrW0FCtSktyofWOBNhkObFaqj2yymjJMbR
         oEEQ==
X-Gm-Message-State: AFq9FYJVBC9bkh1LFb9OpRPW2oVW0aAe/a6giYZjAHsb86flUWYafkV0
	GESGrR7QShFqWS6Lv/n6SRXtMYrzPCbT9PXS2Mml41dELZtdwKSywRi7MxKhrpuNAVE=
X-Gm-Gg: AYBFou2rYqssoFENsmpt5qUwT1TeC4z835mS70qjcEE3TXPC3pthGuQLT8arfntpcDj
	1KhSEQl/12Na30kisiytHyU9/ZYJYTo2rIBZCIaw5Lh7uXR5CFQ4Ccwc6J/N6Y6l6u9cgt9KoNP
	AYj3QumdX+9BgMlgjKR8YbjU5G5ZO+YTBlgUdj5Pz/8kQ30P1eSnBVwUSlHpUV4JxASwS6joHVW
	GsFOGO/jDfepkVmHST3QVKu3jaCEzJgdPJ1Qe2ikCvjVwqCaN3mos9dosOpmpjm2MXcAmYrrIEu
	J6RvgcuyedPjsaaVgW7nIg1CZdUOhBZywN0Nl0C0VTONFL6K9v2WfmmReJ9UKzkGANY7VbyWGTd
	9l99/2oXVGJniG6Tt9HDsbQ+8fhTsuBO2XNONNCqHPYcN264hcVxI/AQ6zkmq3CVLnc1OKDPV8S
	NGQSkZAdLsPL4US0pYj63e9YTyPcC1SwspGp0s0fI+EVsjkH5oM2gHFULf44ngpoC778xjV8OWi
	MV5o3Eox6WpsXP4jh0nj//J2Hl+QQDf1zYAlhnnmvGl6cAwSdXWrKWDSMVO2sTf+7gVusY2TpSX
	c+en/cZ5wMc5fuio4aDmoL/V4vYw5aqwcgzJUssdAzedOa9+rWMzgeWoD+qtxdwNzL5PXkuAylq
	T4NOO2Z5vfMzqXBk2jOWFTFeoK9hs5UmviMWakADLf4B6/68=
X-Received: by 2002:a05:600c:37cc:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a968552939mr60471495e9.34.1793202851830;
        Wed, 28 Oct 2026 08:54:11 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm1468515e9.1.2026.10.28.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:11 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 16:53:50 +0100
Subject: [PATCH v2 2/4] clk: ti: fapll: Fix clock speed calculation
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
Message-Id: <20261028-patch-ektor5-dm8168-clk-v2-2-dc6bf0fabae4@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202849; l=1741;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=x1G4PpmGAOi/+npgUEN5TSnu9K+yHFni2t7wWOonDiM=;
 b=Yjdc0rXTYjFcwSZPaRwYiLsrgSjWu0P53QtnentU54j87UaJVPUIW1thUkot8uN64ac5aOGBa
 K9Elk7a2TEcAmN3v9I9wfdqMAu1wyc9WoZjj+icprs7NJrZ/znzc3x/
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The fractional part of the divider was being treated as 1/10000000
whereas it is in fact 1/2^24 (1/16777216). This led to incorrect clock
speeds being reported when a fractional divider was in use. Correct it.
As well as fixing the clock speed calculation when read, also update the
calculation on set in a similar manner.

Fixes: 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index ae2f6fed10f6..8ab9acd57b60 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -336,8 +336,8 @@ static unsigned long ti_fapll_synth_recalc_rate(struct clk_hw *hw,
 		v = readl_relaxed(synth->freq);
 		synth_int_div = (v >> 24) & 0xf;
 		synth_frac_div = v & 0xffffff;
-		synth_div_freq = (synth_int_div * 10000000) + synth_frac_div;
-		rate *= 10000000;
+		synth_div_freq = (synth_int_div * 16777216) + synth_frac_div;
+		rate *= 16777216;
 		do_div(rate, synth_div_freq);
 		rate *= SYNTH_PHASE_K;
 	}
@@ -378,10 +378,10 @@ static u32 ti_fapll_synth_set_frac_rate(struct fapll_synth *synth,
 	for (; post_div_m < SYNTH_MAX_DIV_M; post_div_m++) {
 		synth_int_div = DIV_ROUND_UP_ULL((u64)parent_rate *
 						 SYNTH_PHASE_K *
-						 10000000,
+						 16777216,
 						 rate * post_div_m);
-		synth_frac_div = synth_int_div % 10000000;
-		synth_int_div /= 10000000;
+		synth_frac_div = synth_int_div % 16777216;
+		synth_int_div /= 16777216;
 
 		if (synth_int_div <= SYNTH_MAX_INT_DIV)
 			break;

-- 
2.56.0

