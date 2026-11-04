Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801338;
	b=Z6lGxzOvGToblLFTDeS24ajJMNKU3/NpDjzWQEyefvTrx5c61U6snnw3RjIfKVnxGafg
	 aN/zFhBEBbMfV75MLWrhdu0M09LqyRTgyT1Z0wn3HvbOd7MqL5MeU54vr2MEH21ezCyc0
	 kb+v4mKQlQ0nItYfiZZEylkeFcbDEBatvtnMxRNmw3dGEHCHMbCzEsWcgo1mOWiPiOsO1
	 5anUnexbfPs1DBHw/FbBvI1iUERBFVc2KOwhAd30jkbHlYWzsAXlUNnbeHWNMCkfjsyBW
	 jtJY4B8gTXYYmA3BwZGKWXphH5/sP1xh0z5cpzFpHL7FDHeHB+PztovaH7dMd/VPEeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ECQTKAjZ9Np9eYCJw+nsz0GV09F+1r+fPvzJLI4eMC0=;
	b=NV43XRoj7j40Y58y95xDGK/sdyfdF9qO4utjz2TlyBjoTEMxl57mdhTFQ71mGQuNFuii
	 tSw1zlyLqWOKq+jZnHpDyXHZjC8Ztk04xqLUrY4uOhoei+hlnhfaHJfCc8VQ9HShmEm2l
	 E+frXJqt4OouGGwA9/1nXjcLamueDNnejoR1XMnudR+TlzcbLPjUDO5HGuz32sddrmBoz
	 ZCGq3W4ANJxcSIjF3Jcl78aEuXTsS5DXNNcON3d4A16Dw0Hm/G2kLTG9MkgI2YziUKXmz
	 XyD0SUyngeoNE3tQ91YuDNJyq5D6U3LM2NB0bDIn9psbCUesmY8WR+0OfWgNinZFUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L3Ni/6Jd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F8606A31B;
	Wed,  4 Nov 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3Ni/6Jd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDBA1F00A1E;
	Wed,  4 Nov 2026 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801338;
	bh=ECQTKAjZ9Np9eYCJw+nsz0GV09F+1r+fPvzJLI4eMC0=;
	h=From:To:Cc:Subject:Date;
	b=L3Ni/6JdXLXkmWuWZP2wBbTTZHR/OlEjjRFmeW0CyvG2837XjCGJGlpU3pl6wCru7
	 0TdQTSg+pf2PLQ6BWMHJTZWZR5pQlQSJml4Mm4OKNgiD1fRlynLwpk4yn8Kc+s9r1b
	 sEvAVELNzytolETzkviGZuuZaT4t+vZvMvbjTYPF7U10kvTILRA0qcZKbacJvMc13z
	 5tH993qxLyTdviQi+jynYW6QMlF33FEPyEAnP4U7Twgm1jzcJyFz0RDUgrW8UfRmOi
	 5iepJcgHwBGQMxgvtpEv1s4+2mmkJ2vN3bdVD1huS+PJZkjwz60Ao6ZAWr65TEG2PC
	 pzwHVnPEg2AXQ==
From: Alexander Sverdlin <asv@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <asv@kernel.org>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH] MAINTAINERS: pinctrl-single: Add Alexander Sverdlin
Date: Wed,  4 Nov 2026 15:08:03 +0100
Message-ID: <20261104140820.65243-1-asv@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Add myself as a co-maintainer of pinctrl-single driver.

Link: https://lore.kernel.org/all/CAD++jLn8yxh3LmUzbb2vZfJFJB=_mCZ+VeQhnZktfmuMiv5uEg@mail.gmail.com/
Cc: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
Signed-off-by: Alexander Sverdlin <asv@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e42edddf8f0db..2dcf454589726 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20386,6 +20386,7 @@ F:	drivers/pinctrl/samsung/
 PIN CONTROLLER - SINGLE
 M:	Tony Lindgren <tony@atomide.com>
 M:	Haojian Zhuang <haojian.zhuang@linaro.org>
+M:	Alexander Sverdlin <asv@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-- 
2.56.0

