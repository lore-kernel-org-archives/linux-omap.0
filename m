Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307657;
	b=Ejaf/OCkbtEu980vSpLoXQ8nbjIMh9vx57hbxILPBGUFZ0Iymg9wtx/zqqVqOTrXcObP
	 Gh4CLfft+5BC4Rnml2KI3I/jszs2r+uhwAdokKidDItWAISViNgxQvOnPQe/n3R+Pw7xG
	 JxM6PQvY3lnWOjX3O945SzystU++hnRUxhmUiK6Ie7EbxiPEwSxS8nmmCVDOD+6XIv9dz
	 Pj/nTciOUWRXfUo1AoI0PH4IBGdjY2KtBc9p3RNybBqqVhy3cFPuK3lg3shzNEHgZBdOv
	 INMNJnotsGO4OClLkj82P/aT/XAbD3F2bMHHv9pSku6uVTunagUIUM6OdvIwAD7XirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307657;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Pj28MUeXRO22SDg/dzGkwKmG+GB0c932+A5WTU9pqt0=;
	b=iQllb/asaCyIs7bHuyX13Wv+Bik0Bz27rO9G7Sz3ngTSlYg96SQMY+Ztll7X/V0ngZJ/
	 r1wYuBNNR5R6AvS3WD8lNkigArx3YDuiBXdYwUgyA1YKX+IgY2B41b0LRetfMOHV8ZqUR
	 0TqPgcqt7oYuQLw2kudrbK5njsjdRxfEqn0AmUfojxyb7ZgKdtklzeqgtj9aZ2stjS3LR
	 06HbSW7ZeBRULdPhxQgbVAAPn2QicCZcpTOYS+WRlCTyvfylATwroBTPPwHcFMYX9KGJe
	 w45/ioXPmjNFPcA+ErP3Gv2LPesB/36oFcP7YxWjGmppD/sl+58vKXCt8bD7zyhwRzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=prVlUScW;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21A606A325;
	Tue, 10 Nov 2026 10:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C21A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=prVlUScW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=Pj28MUeXRO22SDg/dzGkwKmG+GB0c932+A5WTU9pqt0=; t=1794307657; x=1795517257; 
	b=prVlUScW+FAvAx01WKNzZmo6/p6Zo2+7nSO8I3biHeEcnHU2bQq9r00uA6iP0rOrIuS92DpnrdR
	LU2A3YO0lgDQWYLSgB9jzWKc19OZ65lX5wyWr+tsm+2kSjXSAUzPq/tH5J0kuhVs9W7iqyB2MqtrQ
	Aeg37n92s1E8MXC75/x6pxkzQ4kjHGIiYmlf+loOX9Lku1uRxno+FAhqnV51QJpvUNPn9AWPDqLdz
	yCxBic6CtiVf3z59zm1ZZUSVrtFZRZNQlN5aSqC8bcX0vicWEI0N3RDeKKeCQ0aabm5Nw8KH6/Evu
	mmDdojo1HcLzotYG6yPOG0bnOBbeohjwc7Kw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Nov 2026 11:46:13 +0100
Subject: [PATCH 2/3] ARM: dts: ti/omap: describe omap3 i2c via ti-sysc
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
Message-Id: <20261110-i2c-sysc-v1-2-8945eb1d38f0@kemnade.info>
References: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
In-Reply-To: <20261110-i2c-sysc-v1-0-8945eb1d38f0@kemnade.info>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>
Cc: Sicelo <absicsz@gmail.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=4606; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=kihIyZLPXJlspf7A2VyeVd1vDacese1GM2HwSHEZImo=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq8vX8SM8Rl3isiirqI70fuUTBcKiqoPwKGzUoJ
 5kF6g3BJXSJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavL1/AAKCRCEYUX6QCjc
 8dvZD/wKgXfKccanPy+zAj4ClQB4Itj5LB1DQxc71meDk2KjX3kSuQpcs0+MWySRdER4cwAnf55
 VSABOtxeVEsnP6gW9RANdNCYpWigkwoAHjNmhtHrOvH02Y9hX9eYoZ8f+70GSFjbvlGK43erzmO
 kMDttKp04y4Y5GHZyvIXnnIgNfigcGow9BzZmoaLd9ufsk1MannnRARDLdFKqsPafhWh6NyKj3A
 s6GHmV7TGLn45rMh9PkKJURUT4ZIh/zHy+N3yQfpMTNNURwrGq3W5lBUvHWRhjSNc6w2hw17JEK
 Naa5VkzDjCYZQ64dcxu8Y3vUWgh+LJ9VddKdFN154XkRcGWmCuq6EqXEFzHxBvZDOkArhaTGoK+
 5bIvh48ToplJ0rMm2gGsWsipvVnv4CTGK5BOw2B+QMMwOT07T+NeHJu9cWiaezRq38wkjuE535S
 VhOZl+F20IiBYnv7j5laOC0TUTs+DAdz20ugQxjurJz0Op3D3U4nZKe8tWr7+g2CaaVdzjJb6b6
 ozWj6kwnBKvmo+Sncs4rLGGvKWper2X98edgQ6r+YTRQE62XiyYL0vY/BWsAXHyGCE0cHGScn4Y
 myu3AyVCEHvQMD7QOd6eLlUNg1SHQGXeMtde+sur/fPTXhFcaI0CVdnn6v7sHBYzaMLXDFCwm1C
 p2tGvrjUZ2ePihA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

ti,hwmods is deprecated, and the power management there is working a bit
different than the one in the ti-sysc way. So if something is changed
with pm incfluence, it has to be tested on both. To reduce that maintenance
work, convert to ti-sysc. Also fixes an actual crash with OMAP3 and
suspend.  That was caused by a commit enabling i2c access in later phases
of suspend until the noirq phase. But that causes some state expectation
mismatch between omap_device.c code and the i2c code leading to the
following:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa060004
[...]
PC is at omap_i2c_runtime_suspend+0x1c/0xd8
[...]
Call trace:
omap_i2c_runtime_suspend from _od_suspend_noirq+0x44/0xe0
_od_suspend_noirq from dpm_run_callback+0x4c/0x1f0
dpm_run_callback from device_suspend_noirq+0x208/0x594
device_suspend_noirq from dpm_suspend_noirq+0x1c8/0x3a4
dpm_suspend_noirq from suspend_devices_and_enter+0x10c/0x840
suspend_devices_and_enter from pm_suspend+0x25c/0x3fc
pm_suspend from state_store+0x114/0x130

Fixes: 7da7fd7e66ac9 ("i2c: omap: wakeup the controller during suspend() callback")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap3.dtsi | 96 +++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3.dtsi b/arch/arm/boot/dts/ti/omap/omap3.dtsi
index 447736d2e53ca..42d80c7a0a854 100644
--- a/arch/arm/boot/dts/ti/omap/omap3.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3.dtsi
@@ -396,31 +396,91 @@ uart3: serial@49020000 {
 			clock-frequency = <48000000>;
 		};
 
-		i2c1: i2c@48070000 {
-			compatible = "ti,omap3-i2c";
-			reg = <0x48070000 0x80>;
-			interrupts = <56>;
+		i2c1_target: target-module@48070000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x48070000 0x4>,
+			      <0x48070020 0x4>,
+			      <0x48070010 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti-sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&i2c1_fck>, <&i2c1_ick>;
+			clock-names = "fck", "ick";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c1";
+			#size-cells = <1>;
+			ranges = <0 0x48070000 0x1000>;
+
+			i2c1: i2c@0 {
+				compatible = "ti,omap3-i2c";
+				reg = <0x0 0x80>;
+				interrupts = <56>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
-		i2c2: i2c@48072000 {
-			compatible = "ti,omap3-i2c";
-			reg = <0x48072000 0x80>;
-			interrupts = <57>;
+		i2c2_target: target-module@48072000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x48072000 0x4>,
+			      <0x48072020 0x4>,
+			      <0x48072010 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti-sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&i2c2_fck>, <&i2c2_ick>;
+			clock-names = "fck", "ick";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c2";
+			#size-cells = <1>;
+			ranges = <0 0x48072000 0x1000>;
+
+			i2c2: i2c@0 {
+				compatible = "ti,omap3-i2c";
+				reg = <0x0 0x80>;
+				interrupts = <57>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
-		i2c3: i2c@48060000 {
-			compatible = "ti,omap3-i2c";
-			reg = <0x48060000 0x80>;
-			interrupts = <61>;
+		i2c3_target: target-module@48060000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x48060000 0x4>,
+			      <0x48060020 0x4>,
+			      <0x48060010 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti-sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&i2c3_fck>, <&i2c3_ick>;
+			clock-names = "fck", "ick";
 			#address-cells = <1>;
-			#size-cells = <0>;
-			ti,hwmods = "i2c3";
+			#size-cells = <1>;
+			ranges = <0 0x48060000 0x1000>;
+
+			i2c3: i2c@0 {
+				compatible = "ti,omap3-i2c";
+				reg = <0x0 0x80>;
+				interrupts = <61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		mailbox: mailbox@48094000 {

-- 
2.47.3

