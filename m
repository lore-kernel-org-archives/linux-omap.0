Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344238;
	b=Iw2NkBLPJDUVeF2dZ9Bp3eh40IDhkXvKrLV7W2W5nlQxTyAR/HmmB17EedK/TdhMlL0/
	 gejMRnmt+n7oM7W5eaLdQWdwGmcAlzPes4iZUprNU7rduZs0BQLWTLM1LNzbKEyRpx7SR
	 Hc0c8dq7T8u42IHcrz3Dw79vKkCiaOLwBO6JYQIiSwNLrG2CRu6qRxzqGaFFY61fhlLv6
	 gjhl8R1vBNiVyKR8rrsPiXGJiW0Y1PWGEkAG333UxrtobXM666O9pXn6W2TLA706P0ecR
	 X3PkeXDrPg4TfK1xYbsnmUlMK8VuZUzAqMeSm6OxwzyRQOGpveBSEvgF4MEpRIjkc/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344238;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TrYzlfpzSjOTkcFVrqQppineqlRGur5koHqKUH1gLUs=;
	b=A5/ikoIcOaEf/WZCe8nTBFyYLBOpkAfJKsgsvrrSAIw7Owc1zRHQBWDdZgSxCkusp8hg
	 9Zi+ggh/acrIhKxttJa/vz29hsZiyCSZAfOFyBRt+eUX7eaYCgDdS8uv8oe5uT0x3vtAf
	 U+YRhUOPwZ92Jo+vERx1EoHgP/uJWoLmypjwUXbapg06EYIFqgjYnx8IZMiQQT2HFPpS7
	 rbVGRwemvIl/KdMQNH2Vtl4vSnM+seOL2eitAA+hhSMHtIvGn3aPw/gZm7xV1A0S7fHax
	 WprxtvjmnZkeN7XZ4G687RRkUu9lst2L3E42+ECD6hGwQSHB1Md0ZOpdAPtZqOgBx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=asOeR1Ge;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496D606A325;
	Tue, 10 Nov 2026 20:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0496D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=asOeR1Ge
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=TrYzlfpzSjOTkcFVrqQppineqlRGur5koHqKUH1gLUs=; t=1794344237; x=1795553837; 
	b=asOeR1GeHWEyZyJIKEy8U4mpaVhv3EqwN6xBs41t1KvjKQm24324MYs0gaSU9RNBGbmYvmPuSbI
	xJOI5ebs7n3F41gMubuLi0Fu0ADJnQttQvN8rCmsu+ogZsbmtsfsjZsEKcXUmNE1JAx2/VeZjqYGw
	Yr2sJWhqg2T/UjK07mGrdxIbGT2T6PpIU4yAyDknh1rF8ldlOUU0TpietlZj19g2Wqttw2xpDx5yG
	gmABiOyUA7/2KiJVJYgVKQQMoXSLKLYw0MSVQnEvKlFXYsgMvUVmKx9zQSe5wFOt1aC5RGB616pj9
	E2Q9qUjTQM/zXk29yW7pRCOzdcTZ8dyRSmNQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 10 Nov 2026 21:56:04 +0100
Subject: [PATCH v2 2/3] ARM: dts: ti/omap: describe omap3 i2c via ti-sysc
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
Message-Id: <20261110-i2c-sysc-v2-2-490cda69e350@kemnade.info>
References: <20261110-i2c-sysc-v2-0-490cda69e350@kemnade.info>
In-Reply-To: <20261110-i2c-sysc-v2-0-490cda69e350@kemnade.info>
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
 h=from:subject:message-id; bh=WJ3PSTqkXdeNhSq80VIUeTpz6RXvNLLA2KUhBVQ6G3U=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBq84UFB05YHUBMrOa6Vu+RcsAp0GuyzhclH0zIE
 5Rc4Zsd+1qJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCavOFBQAKCRCEYUX6QCjc
 8f0ID/9FH1XVo1MON/mz/J4Zte5DLtgMZomXQps4fDYTb+qNtwhQP+wEmdzBmJkz2VWN1O7bhk/
 nwVOBf9cP5i4MCESc31D1Ms2s456GuqVIjcG2ScRhKmHtIGEVxhZmstr+lQlPmZw5pSgGxi1o9M
 MB3x+oCJo+r3wjipJRfcgUpQSvBBrSlGXpXPbWtexl/jJ/Z6NBZEPKEQes3gj0zT6g+CUEqrnXG
 LPQgE9US359XSmFTLa9Bwb+lTF0YxCQbeg7bmADnk+Wxcy3k2psgYCpq5h22J+cc+C8w6JelRXt
 h3cUKBhOxOMaMCZyK4qAYJYtHJCs6Coo56xUmwpAh7d8H2m+WNewfw4G+MY49LKgU3b1jYzIOn1
 KMdZZyr4z3oPK0/yhrnQQosJZJiha2zBvw8vFKn5I973XqGoe0Pw0plLWNiuHeFEgJU0Duneu+Y
 5uS/bFcB8fO4P8bL/3U32/FvFMr3xkiSMzgPT3hpvqwmb/5YQPS1NmtM6bDVmaG3CksoDoA7Zo/
 em2rZeCLXddDcFJvbCGHrge0L51gv7oqmrIb48kwx3j+Ex984tj5uFXRLb3KmruDP8nX1yj+dGp
 fIveAa/g+Lj77u6NnWgEotckeFBmMtTv2wLikFmMyahwsiVab+2pu9JGutGnyFlRaXqBhcjRSCi
 8zXQ2vYz06s3hSA==
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
index 447736d2e53ca..2ee5fd4888ce5 100644
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
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
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
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
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
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
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

