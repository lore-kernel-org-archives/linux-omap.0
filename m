Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F38332F
	for <linux-omap@vger.kernel.org>; Sun, 13 Sep 2026 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272205; cv=none; b=dYaIneTOoEavnr/XR/vBY5wQnmqq7sOYgv9Y6GtQNq+cW6jIBxDyWAPdr5xOVzTqM2lywZJz2ilUBN0EX+PgdYLpr2z5K4xlG02W0OiImTlH3HiX0EPmkY5vXdJHjjAtydTqW1NZEcP/r6mgc1ZLTaU+ehlNFVw6tXiJ5L9S9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272205; c=relaxed/simple;
	bh=4eRp9ovMmpBudHPEfFmH+GHalK0lB41ROHYez3TAZNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3ENqNJ4xEJFHeE5reGpFMvqNDuPUv18uR8uqAs7WaedrThCMdtgFXNTJoC/4sgfDLe4eB8zQCNaB45wdMgviQ7W75KzL4+DxU1Tx3bF5RyrL8efR2p2Sa9ODvPbkg/gcFC887t5DItT6PYlEhMpQ3mtTjgTKIM0XTyUTi40QKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMhXzdm6; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMhXzdm6"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530fa0716f6so2858341cf.3
        for <linux-omap@vger.kernel.org>; Sat, 12 Sep 2026 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272202; x=1789877002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0RPsG5ANJXum6qiiDCl2HWvCcb2vrljQ6NDoFmQS7k=;
        b=TMhXzdm6RzpAgkxS+iTTvqN3G5kSltF00lFB5Kbi/uQR198rm9I0AR3iXHxhppdPDs
         McHXclarAr14t49ntxVMGEkvpWBKPwtsC2u3zDE6gezdWZq8ja5FJ1X3OOaSBAtzlum+
         HxutLO2DEmZM+6ZRcPK2oS1oKo1tNQ32jgK2ZJuURQEDWvqFsJafhUGVFJQ8UNKW6XKm
         9AHa1lKrQmRjoB+gnH3go/BvzbPnyW5M4YKOrZyFkbKenk2/oIXRTI7PxdT6jezfayZu
         Ip1RsZQ+Pm4wrfCJMJryenGrNSoAAPz7HBkKbp3mzNBHyV72NUBSpjNOLd095WHAASla
         vjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272202; x=1789877002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0RPsG5ANJXum6qiiDCl2HWvCcb2vrljQ6NDoFmQS7k=;
        b=O1W7zfLDJejEFUone2aMLixEXAH258J3Gq4JNpjMgpng0IL8xMrS90hYI9n2S78uYQ
         ZJsOJFyXlo8K7mVsgzkTa3Efm8EriqtLbggN1l4VsgvpM11RT7ezSZ6q9J5jPGLgwFGr
         4QzQ7gN9yC2zAHf8nZKvN0ThonHw4XcueDEtUqF47nqiDxBAB81X8CkPUYpCByUdwIXJ
         Rr9zPU+BeJolNVVzBgHHb307f4eGFmfIOo1AH85XMtjLIqvQRRMfsrJ88jr3vS3/sWiG
         Bh2iflmiaRBNDajd+49M2oZCNlsJVMhvEVZjN9H6w3UYxT9un77v0/sWBKA2Xp3tiODB
         NgBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+hYMtfOKVaRH/AwlWrbTr4Mrs8PsNyCwPxOXRxGs/scURnzh2HMrMoFpmoYym4X555r3o0nW/UGPh@vger.kernel.org
X-Gm-Message-State: AFuF++na3biFgXR1p4FbIh8prkPpyidtsDQcPtQLRTIZhwHRVWPonQ2+
	FTKH2MLt/xo/nTjdNrC4MO10SS2sKQKZ3B1mlvpgHzmdkJ1q/jOcwSI=
X-Gm-Gg: AYBFou08BAR8o7rQL1seMUFS5Hjy4qQjG7csKbBspSj77Z85QgS9D/c9Qlcf0oyPsq7
	zg3h6rEpdU6bmvQWjFsZkixKvcO4uCkoTE8WTzJrJy6CMUCd1AftVVj9A/bzgLicYvHTH+OMOd7
	4FZEC2a06KVLHLNmqou+C0VK9FMAVkk5h0lpOklPgfbw731qFwVrGBy/HyZ2YRkdZHhp4M1ETm+
	GvXMyVGkuE/TGTJGIj6HW9RRkHRdfiUk3hiVKZVdteA/0ZBF2tjw9py+cN4DqkVwMcahO1X9bj+
	l7aytXzeFoh1k3gI2AzDZuNEyMigGVrC4vpWTqxXmUF7O6lCGdf0fVorO2+BU1GaLsjy/iYapxx
	ySV1f+8Vz/JK/4SBhzqZ6DL5IzHFLuF0y1mfiJRe2yXgvzVOLs9wHbOvIOY3hGsHRQbvOUbn07k
	FgJkU8Uxb+9nBTVXQae2FKi3fXtIwh2lDrAuHEZQBdGV9FKmKoVrdN2QQwkp4k/QjJpt4uhWsQD
	axH44nhilVftcPZ9ILN5Db2FZ3j1s/vGw2TUXq077iFe80mvxoIqTbYLjNQw594d2XcQGHhJRg6
	FhI3Qzz8ZWKo7/IOwxUNFJmLyqj7qunWnA==
X-Received: by 2002:a05:622a:507:b0:527:631:8d6 with SMTP id d75a77b69052e-530c859b38fmr160895371cf.25.1789272202056;
        Sat, 12 Sep 2026 21:03:22 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca460a32sm62329021cf.9.2026.09.12.21.03.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:03:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] pinctrl: single: free the IRQ on domain creation failure
Date: Sun, 13 Sep 2026 00:03:12 -0400
Message-ID: <20260913040312.21966-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcs_irq_init_chained_handler() requests a shared IRQ on affected SoCs, but
its domain creation failure path only removes a chained handler. That does
not release the action installed by request_irq(). The probe can continue
without interrupt support while leaving the shared IRQ action registered.

Use pcs_irq_free() to undo the appropriate type of handler registration.
At this point pcs->domain is NULL, so the helper only releases the parent
IRQ handler. Then mark the IRQ invalid, as the other initialization error
paths already do, to prevent another release from a later probe unwind or
remove.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3e6cee1786a1 ("pinctrl: single: Add support for wake-up interrupts")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4d5f85b7e..e0eb7240a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1628,7 +1628,8 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 					       &pcs_irqdomain_ops,
 					       pcs_soc);
 	if (!pcs->domain) {
-		irq_set_chained_handler(pcs_soc->irq, NULL);
+		pcs_irq_free(pcs);
+		pcs_soc->irq = -1;
 		return -EINVAL;
 	}
 
