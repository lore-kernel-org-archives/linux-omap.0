Return-Path: <SRS0=szrX=6I=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD8C5519C
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372B62098B
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iEbBFP37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDXUe6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDXUe5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2020 16:34:57 -0400
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5304::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70413C09B049;
        Fri, 24 Apr 2020 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1587760495;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NojKpJsr295KKzeE6Kfg0J7/g3gnxL5pXSLXeEqbQIE=;
        b=iEbBFP37xXYNsIXksXI9lDadPgt/zvqh6xfy9tWdqzuEVGdswhG7PPYvBSo9QvOBKk
        E4dxNTthGHtyZlSJHspjnHW/i1bIFb9ee3j5oi99ydZNK5LEwGrVedznzWsst+nVlprG
        fiYCSKfVxyx2MPVIKcmv6XsOP8as6qBDDvmDU2xh4Bhrb2SLs484IlGRTSIdYxt07eHf
        eL4BEtt+fF5yGFemQrwPmUuKnICmwPP1TT52wYRU801DaNvEOew1PZ/hvoROXs6zNWIY
        PdZ14WsW2nC43a8hdstHVErg6yu3VcJTBjZrdFHZXuz9I/M6HjD8Qf7nHY1iCJ5tbdoo
        b43w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6GK44R2FE"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
        with ESMTPSA id R0acebw3OKYOEVH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 24 Apr 2020 22:34:24 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Philipp Rossak <embed3d@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 09/12] ARM: dts: sun6i: a31: add sgx gpu child node
Date:   Fri, 24 Apr 2020 22:34:12 +0200
Message-Id: <47740d708e00632735a8c1957109ca349029c716.1587760454.git.hns@goldelico.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1587760454.git.hns@goldelico.com>
References: <cover.1587760454.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Philipp Rossak <embed3d@gmail.com>

We are adding the devicetree binding for the PVR-SGX-544-115 gpu.

This driver is currently under development in the openpvrsgx-devgroup.
Right now the full binding is not figured out, so we provide here a
placeholder. It will be completed as soon as there is a demo available.

The currently used binding that is used during development is more
complete and was already verifyed by loading the kernelmodule successful.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f3425a66fc0a..933a825bf460 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1417,5 +1417,16 @@ p2wi: i2c@1f03400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		gpu: gpu@1c400000 {
+			compatible = "allwinner,sun8i-a31-sgx544-115",
+				     "img,sgx544-115", "img,sgx544";
+			reg = <0x01c40000 0x10000>;
+			/*
+			 * This node is currently a placeholder for the gpu.
+			 * This will be completed when a full demonstration
+			 * of the openpvrsgx driver is available for this board.
+			 */
+		};
 	};
 };
-- 
2.25.1

