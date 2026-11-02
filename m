Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649214;
	b=GDycyOJnaZ57JJfUvCOYvA5RwzDUWV/2Fu+d4/GB9edupHWmkkd+U8pVzUgeNTdHAIuu
	 YWcJtxMn6qYHaWbqFUHViIeWOUvX8ItEb1NPlXsrctzA5Hegn2Ih0udWXoTnqFL0RpZKa
	 b6S6MT9Dj5S+9Jbk0f/4yNAl1Ud0Gyua665WBZpbc//y2IuvUwxNv7lLxtaJAX6+cvQjX
	 Of0R3p2J0jolzrdHggt9abJ3CWfjBTJroRzIzbhRFqSIjWO19PpTXOwQWXld7PU+AWAow
	 dT/dUDCN8Mrn1znBLSgkntQ1dBk4u0+O1NFePHnQvPQBs/YrePeFVlbNGWcx7oAbVkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7f/afSnO15hayW9629dG+dsshQNBLmVWgINs1QselwE=;
	b=0QPFnj1h9Xi8EZHEzPQsIWZB9D1WyXAvw2I2tLhLRCPFljKj2d87VujMy8huLeTZHdD7
	 i5ma2RhsE/v4seR32ZBTsZ8b0eZajJuFR7r34mqJqhgImS7lVje24WwPdjkGleRDwIkG/
	 mLftm6Fap1leHTMu/rohWaUfuQA1RMBA9vgFaBk7r8Q9FtgKxhizPlf8bJIj/K5ZfcWzU
	 6c45vVDbhO2RWL5oP7BUsOta9eZ90kkhv7dcnHYNAPzExxkKhW+K/So2YDSzwFf0dlKjy
	 swTUAU0vjTTcAFYZiSNxF8iBQRYUlvJX+U6rZB9tihRg/EWOZUHYjFE4+BICQViF7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kbOaESfH;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1E606D805
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A1E606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kbOaESfH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dee593f18so3276301f8f.3
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649211; x=1794254011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7f/afSnO15hayW9629dG+dsshQNBLmVWgINs1QselwE=;
        b=kbOaESfHOMY626Igcuy0ZYezGQ2G74bCe9kqAXY9wKdCr3mIrmueBNs1OENJzuaLbP
         otFje8FX/hRf50lXxXqgnb7mLox1fb7sbaxCNnCoTrDVjzBLHj8wLactklUaQy31pJMl
         t8iePGy05xOCA6tQyO2rULtyacL2INXG1A0NSJApQEY9immEPnG0ikEDg1Prfwn9ohch
         F0fcmfwdC2Cw3BOXK4SpOx28wawaY4/aQtx5OzMHi8W3BfkYQW8dAR5ENIjzOZ3m/ERO
         69DmUbrbz1Hf+EcJMNa8H4LQScoK3WzDdk/OnRXLVMt6LlvOFRMwzAK3NnOxdVY4+zIW
         TkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649211; x=1794254011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7f/afSnO15hayW9629dG+dsshQNBLmVWgINs1QselwE=;
        b=xdMECqVHjv5e1oReN0PVAFS3kZv8L02AbEunUC6D8hfc+UC0hdHvd7t44Boi2r72Td
         TacqPBA3utErbMX2RifZy48K1/yjMxnMM4QDbZSdXYkpHh3ujjUJitWbyI/mAxBGGz82
         92hgembQeAi0dpSIJRedPrknLQSfamT6LXaqRfH1V758aMZCtq+7Suzy2pZEgNj2nc7D
         LPdBR66XTmPbBcBoEhEv+JXEPRq7ewUog+53szyM2PZCzoFJEt0FMzdG3op4yIGLfgIz
         mJfHMIy1QWpiwBx7qg6JsHM3PaQNIhVgVuAooLZaYmbOtBIIYIBPXSwroDknedlCBToi
         7gvw==
X-Gm-Message-State: APuU4Z99hSGGetFyKQyccH6H9BQa7Yj4OZSjmLcN/OxRQC6Pll4FDE8i
	KC5kkT2Y6pAC2UaYncvCLnwG8DhVqjShoPg/1soIAI0NxC486l3kcFAfHWOUR0zgzlQ=
X-Gm-Gg: AYBFou1jTBhKmBy6ZXJHtgYU7TgnXeMYEy/CdUbzGrPW9EIrtVXndxP92B4+MWbjlM8
	mOp96xZHwxk0Ay1gt2OUMdIu5TzQy664ANDAwMIRrLi3/7mTyAejNIGJEVbFvTfpO4HwbBfPs6n
	5qkHjpJbFNGqWE56F463YcRb+7Lm2++giFYj+Eb1vGRNk73I3p+5Gov26d03p0RrKEsPU0C4WIY
	B4KfvjIswlBxQ//8LuA1PujPm45lgEjE4yY7l41NfjXRnoECpQJNHH2F7NUVopvDrWqqLL3+LTS
	WkAxpkqqM6KNZVsD51qDvMorWEirr0E49xhB0v8PuKelyNp43c7fCwEFlHJa7t8QL/kurYWDOhq
	D9/LUsDJjBhR2cczUVTFJvms4+qT72zD9j6ir0ihdUWfhHwjRkZUUzg+ayUIGRs6GfTCss/MG/J
	ovHwCvhYz4EuRfmmiRAQlzH/PEVSGaARIqyfeIugBm3LBN4OwO88vdj79T0dwgF6gGXjkymUcnU
	9nrlT+poLijJjriFSgCXCzy+iQ0loXSM2m6mJcJvPcXOJvVZwNJqRZ4AFpBRFLexGuLQPxVXnzu
	cnTC+J7viYbCa8Q7RP9xtK6OQraAROe/uwkGn0JZdfEoXnVBTKrv3GEaakL1KVK2xEvkj7/kjK4
	uI6aA2pKOuahaXXX/ukddL6YM6A==
X-Received: by 2002:a05:6000:46da:b0:48e:73dd:855a with SMTP id ffacd0b85a97d-48e73dd874bmr15997035f8f.51.1793649211435;
        Mon, 02 Nov 2026 11:53:31 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:31 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:48 +0100
Subject: [PATCH v3 2/9] ARM: dts: omap: dm816x: use dedicated SoC pinctrl
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
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-2-9bd6d1d128f2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=1157;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=fKPEsKCzv++RFN5u2bDuWS6LSClWwdOaKJr//P58V+M=;
 b=I+VJBZFPeuOC6dZiMIx+ofqumWARXfAbmku+/vywjiPGFscrrRHCMe45QSz37TGQ3hlsrboa4
 2i9XJN5sOURCYIyX0iXcOUjIyRKAHdlikFVLmW3aM+mjlyewJ0/KKqT
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

In the TI Sitara DM816x SoCs, the pinctrl configuration macros are not
identical to OMAP2/3. They are actually inverted between Pullup/down
enabled and disabled (third bit in pinctrl registers). Using dedicated
DM816x pinctrl header to differentiate between the SoC families.
This changes the effective pull configuration of the dm8168-evm NAND
pins. Tested on DM8168-EVM with no functional impact.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index ee0090f7aa64..261ebca8863d 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -3,7 +3,7 @@
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm816.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/omap.h>
+#include "dm816x-pinctrl.h"
 
 / {
 	compatible = "ti,dm816";

-- 
2.56.0

