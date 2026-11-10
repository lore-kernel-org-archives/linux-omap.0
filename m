Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340389;
	b=ImUYELbe+YSAgIKiTZOzBSG4g6kRBp0X/jQAAmtN0fxFu6yYnTloQyAYCycBxWaSvFLI
	 FZNuDjGLp5sedTpIQFcSTKIGqbw4nz6fNzu4rIN8iPLieMOs1jp7W5XT+JwqZMGRnxuef
	 rNzTef7eJVT8UjJQIfVLDF9j/ZAmpSr76EfaATM7GHvEErWopeyvhFYAt+aJgRXGJktMh
	 H9bzw5VJ9Q0xZrBNbXsWU0NteOpCo45XwY5PDELVrgagsp2oTGv2ivccLRd2LtkywbZF+
	 Ew3B0r7d2xFk0OGKRmrO57j3KeOPwUbanLOnNQEsT/CX1R4plhBqirktU95Spqngi/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gQt7z0kPgD+299qyKsfe02moLDWp4KMca7T3a3EzzP0=;
	b=LFmYQHs2C0NClVQei4Z3Oj95ougbzhQk/8iG/EPrUdjcP1ivw9evr7zfbfq4VvD18x6y
	 Sh/GcGirq9ab7e3lAkbxnFmYf3qoi9ScTorJjJO6RBVZHO4hZUsjQCx391thJP1dy87Do
	 GvO/XLf4suS+fUTfIf8z881lh4GiTnhfUgD2Bz/hEKgrxRE0KHBx+z8bOAoTwIraUyn8w
	 +FpgPojhcB4pygFISZBaciURaYprCoiYHd3xRHZiewHSkf1wcaYq6tkrWrxL1p71QV2x3
	 GzJTji5khaGHuz2xkc+5sREpH7T4CMMMuNqq4GNrTzdsVR5t7SziduWSUprcHN6w+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J5l/iCaV";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25760A2610
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B25760A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J5l/iCaV
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bb5afa736so283134eec.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340388; x=1794945188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQt7z0kPgD+299qyKsfe02moLDWp4KMca7T3a3EzzP0=;
        b=J5l/iCaVj/L6+H5ov0FJz0p5e7rr/0JFjFNg7uedGUKahcImhk04lcJf3uhwT0M0Wx
         Vdol1OBCMzAk29mjfTm2OsVU+4DTDUFwFn+Mvrgeltauje0W9PLJGF4ekFehP4dnkzYD
         IVOj7AymgQYccUhEnl30tCvV4bNcnRJutdtvWpkt0Pngwv1UYqdyRA38OZ+cvKMs/pTn
         aAASDx8K1kuzF9HiC2SoTBBH6b0T7m3Uhmv9i/80vu+sPXSgH8Wr5ka/RUwgudqE2jQk
         nOWOT7jHUS3tYWwMpMH1ADpcH4eKjRHfKvfgInH9/eXZs9Tu9n/hV2SEXKfNlwQLB4o6
         4n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340388; x=1794945188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQt7z0kPgD+299qyKsfe02moLDWp4KMca7T3a3EzzP0=;
        b=vJ158l7QAD3QZ2YbSQ03rCv4ISfslDNqjkpoFxBRPTrE9cmQupHRc8/MbjlrqS1ejU
         bYbqIlWS8b9/uorg5tehuQKADDG752xW5BfXsmIpHlj51qWpD381E+1z1nVqYGIytMGb
         QlqqoqcHpjLEvtQydTwYiEILDJL6JWifzyH+SZRW5qkvTFmwsLNQ5mHcnV7qNvhiVBs4
         ZXNNvAW5mXWwK4VAEVKHD8KdfLF2IxTVi+bVg7NT/3h9t4wru1GFagl6tjP3pDa8vabg
         SaaxJG8ooMJmfByxlu7D+ot2HtiO0SqAPkzsMiAhI1pOezYMzveE5iu7rhh2fPy5cQtb
         jCpA==
X-Forwarded-Encrypted: i=1; AL+hErEdcDmNwRsMLa+ZadBV5nXxsZ7UsuoSFGOVYUFNgGfJUE1MXJtGp7B0Rn73DaT4X8oKhtf/ewcJkufK@vger.kernel.org
X-Gm-Message-State: APuU4Z9DY9qsZoiacv3Jxf7Q5xjHpxzNmq97WSbWpgZBPZXWdL+AhMjt
	fL2pNwKdvHKx0bnIybpxYRSsvFL0hfEZ40vi7OGHSRWPmhDPKmyWZ2Fn
X-Gm-Gg: AYBFou1Fe2o+cjBzHF2lmKFep4vriBFqbIIIseCa+j75qi60nUZyvik11XfJkVdgHPX
	Xv9z3DNwxFjMGYnv5S3AP6aduYLHozL3gbBjY+4Dmloyf1pWqVvKe6d4nUO/1sLJknAQbeYC7Js
	Cc5qymcdjiDq0Ihr4J8z+1LadHxrF8oxZsma9NM/4JCQmp4ORizpDc0ZF9rXvuHtKjNn8HIjAch
	rF1T0ZJ9qgh0cnp8+CLx19NHQgZ8UAxpnpFnPF0vjPqxdJRkJQ7bngz71OFZnRaE5a4Lmcln7QL
	PqIsRGevd+HjiQyFWVC8h45T/LDZEYhckctg6Yo/3I12ioJ+B+f/WGoN38OF5SSVMR/3yB/JvHW
	hDcpYv+Ty/bdk6qcf/7dTcQtLyTCkiGClgx73n/CFuegHSWYk8dFsquR0HHVyH35m7QG1v33JsW
	HkyXGa2Svbd0vKwEJMHAP2eUdhX3m0Qnnbc9i4MFIyB71Wn1DLB5CcuvM0KtHNyLV34TrHd/jZJ
	3fTRkMz3ITrDh0H/Gq7wiggwVr+m//S9oZwFCaVendKBRrVial/MpOZjv7T5MjCrJuqKq5HfIb+
	ri4vfUrhMaL8ihRkXKbobtuETzU8528yNhj6weW9
X-Received: by 2002:a05:7300:e9d9:10b0:36a:143d:98db with SMTP id 5a478bee46e88-376854ba2demr670711eec.1.1794340388437;
        Tue, 10 Nov 2026 11:53:08 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:53:07 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:35 +0530
Subject: [PATCH 5/7] ARM: dts: ti: omap: am335x: add board compatibles for
 nano and pdu001
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
Message-Id: <20261111-ti-omap-dts-fix-v1-5-19022d1ff4b4@gmail.com>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
In-Reply-To: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Jackson <mpfj@newflow.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Bhargav Joshi <j.bhargav.u@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=1304;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=iiiNe2YmgDYbJuXDc3R3d+03XUkBIvy8dBS58FXrgXs=;
 b=3u7NS6WDKuDRZlRdtola0QbBGcSKerNcA9rN/jByJq2Q0w1OdePF/XoqfXao4Mamf79AFSdGW
 5uP5Q5J6ezrA2Hjww7BldT8zzJ+v6WtM/bFkXGXzO0NbIN7HGejeqPy
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

am335x-nano.dts and am335x-pdu001.dts only specify the SoC compatible
"ti,am33xx", causing dtbs_check warnings. Add board specific
"newflow,am335x-nanobone" for the Newflow NanoBone and "eets,pdu001" for
the EETS PDU001.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-nano.dts   | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-nano.dts b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
index d51cdd6e1ab40..40e60e0abaa87 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Newflow AM335x NanoBone";
-	compatible = "ti,am33xx";
+	compatible = "newflow,am335x-nanobone", "ti,am33xx";
 
 	cpus {
 		cpu@0 {
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
index 9f611debc2090..c36e1b7922c9c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "EETS,PDU001";
-	compatible = "ti,am33xx";
+	compatible = "eets,pdu001", "ti,am33xx";
 
 	chosen {
 		stdout-path = "serial3:115200n8";

-- 
2.56.0

