Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774066;
	b=izGDMF1ty94d5IzgMmazXPic8CYwjMKZXKfaA8gKwsUdiG4BopsX2PZVOtWQzjAfeb/j
	 QfncWE0kVRJqvWMk7i7AFPVo7V+m0PNg6xSC+Ov6HGr6Nem3SDXxCPVOs4hAlRelfjanG
	 G6txURUxNzBdTbi3HfaisvLQ/6Y27XO4KGW2sKjQmX2a/LuODTZ1U9YAuGp4ATzc8cOsc
	 Q+coZbTLQkerwhApDrmT56d/SvNFpmlYclbNdCjmuRH5OmluOdDtSpqfCOHK0gDt2fRie
	 9g1ewDUrTXNjxv8SuS/S/mU8sl9DUQqZBkvM/rI3TUB/zb3mIg1u1lOrFjQ6p9f30EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
	b=0rbII3cZNE5iZUpKOFRNzxYvPJBtscymnAO4IjOwEAZXcxoIix0b1NRQpIwMaJANfsN8
	 m6Fqhjw5vcIrIwyKo0w+iEM8Qw9zca+yTb57SRF4eOScBGBThZAdWO8PCW2xtc2MkEZKf
	 mcGDwn6YMb7nICbFsxqdmyHRXBZvqE6TTu6LZqRDPjCLEd6dhnykMV014eyXHtj80QScp
	 //UrRL/kyo+rDpm24SZpVvV29FRp7DPyQNg9cS8qM0A6cAcWwKOS6bOpA+N5KDrNk+zc0
	 HD0DMZp42Ogb9GJXazwXz+i7TjqhrgNnq1CnTVufl5cz12s/QYPjtZy/Bs4QP44hWQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU2ZaTq0;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE66606A324
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE66606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BU2ZaTq0
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so80707915e9.3
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2026 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774064; x=1796378864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
        b=BU2ZaTq0d6nf1kovPAqoaEy2B2Z5juQ86UZVsyi7FuGSzKihaXuQNzdd9WoQLSo0aM
         P/cXUEp9Cq6z31xzVzvNqN4PsDGGRlJA9l0YVzY8kORBXq0HCy9XTMBUlgYoBKEB/+kH
         IL0Ddpwbyvi/NKWtVoybkKI/qsVd/SO//vMsn0OIWuTdk/ogGN/eMjoxufZ9tTUMRgJu
         aIr9AGk4gLT81BSknWgNFrXZ0ecEPnsWBwvpyBWSn/8bQUJ0Ge98uGy+cLaAMIeiDyeL
         5IbxBwpY4v/lcrhdUGRT/qtIIUmL0RpW4dv6yYQ7ZN/jacHFp8DvBkpzBY6C/gSIlzjS
         qaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774064; x=1796378864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TsM750EvEyHCTYANfGa2Nzz7ULmsTnF7jQbx8T+XDI=;
        b=svfBbGxQzRrBg7P7APBhxJlQ0+Wh6ap0X//MCTFOuNwdv4YhzegVFcLmeqogVJ5zyn
         FUDYdfBvNpkAOvay9N+0QFpD2v1yXuj/oHXbV1lpiHMUb5sDKu2OOQ+HgQN2cLILcVgj
         bx1qi5m0WRt9uI9tWd3IDf7Mv3NiMCnHNRGQpByiYYflNu0OuKzUXrqQ7FyHJN+Ywpbn
         WOWo2h7eA7cvlKFPWit0u7L4o40mzbAS3oyt/klqAWt0gUIPuAWM7en3T7CBteqjkvuC
         OW3kwmeJilUyR/5MxZ/ZJGOuFHCUpzKlCbUS8mX0Ale3t62OaGwxNnhGHM7zJNFtVUlk
         5dbg==
X-Forwarded-Encrypted: i=1; AL+hErGi8gcurLgDMaUg0sSKTGGkWeRy5SlIDYtcuP2BpzUK5EiCwRJQMSo0+GWqgr7A0qmTP3Fjg0WwvVms@vger.kernel.org
X-Gm-Message-State: APuU4Z+ozIaUY6jKSL1ErzZaWi3SO41Bnq9sBH/yEohY4DJnTP3wRAL5
	Yai2GmT21G65yJqFlDG1F1ty0uupHkynRkhHF0CoCvP/4oJm6chUIGBbsQh85w==
X-Gm-Gg: AZFdTZdgg6PjYPg9ScTBLPaQAZm5gOQ7bUo9YcPe27BAx3+ZoMipo8BVXYliy9QBxgh
	nOJ7ALceAnkmsT4nq7a6V1CrzJe/wesMPp3+0SeXqy5u2T8xLwW9CWqflYAesTjIvUQk17dpCYT
	2z0pMJt5VcS369D7LmhHNAmwbcstDDMwQ8jV9GzuNE0wQtdAeQ/57ABvW+xuDChuSm2sytZ+27T
	P2LSz/bak9bcRSQh+r9dJaZt7XFImtfscCJe70WGMDS52hZX0+mnDmLh0n2iOtRMOQzFm0pJrUe
	YTUUa0Ixn36XpkVvMIc8CKrNOE9MQiEr04zQIC/QBcUPq93pqIu0FhrrR0v8+l0obVEbAncylB1
	G8kXQfsDltnsSJIiv3VhdBe+t5ewntROlLyZiGtzSZHTM7dlq4jsFQ5n0SckrX/ejHsBkSBsubT
	eHQDdMjrRQ+JhyarVySUBJEy+iUEzj/bRttmDdAIIQomcdTFfKY03VjiTsm+7jP5jbFpIwAoD4N
	V4c3+SLhbaMw45PMz8Q2cLursssU/VuFAcMX4Qb8ZIqqOdYFqqAa6MYV0Apu1DIRJ76HU8VdP2Q
	UufCL21w3uC5aKLQy8pDw+5efPsj5wwSlYwJjzikZ5s0bEU=
X-Received: by 2002:a05:600c:4514:b0:4bb:6823:3d3c with SMTP id 5b1f17b1804b1-4bb888169d0mr516683475e9.20.1795774064226;
        Fri, 27 Nov 2026 02:07:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm196561955e9.3.2026.11.27.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:07:43 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Aksh Garg <a-garg7@ti.com>,
	linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] PCI: j721e: Properly check the error of a syscon lookup
Date: Fri, 27 Nov 2026 10:19:13 +0000
Message-ID: <20261127101915.1348807-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The syscon_regmap_lookup_by_phandle_optional() function returns NULL
only when the property is missing (-ENODEV). On other errors it returns
an error pointer. The j721e_pcie_ctrl_init() function checks only for
NULL and passes an error pointer to j721e_enable_acspcie_refclk(),
which uses it as a regmap. Propagate the error instead.

Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---

(Accidentally bumped into this while working on BPF stuff.)

 drivers/pci/controller/cadence/pci-j721e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 822602836b12..fdae51e368e0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -334,6 +334,8 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 						"ti,syscon-acspcie-proxy-ctrl");
 	if (!syscon)
 		return 0;
+	if (IS_ERR(syscon))
+		return PTR_ERR(syscon);
 
 	return j721e_enable_acspcie_refclk(pcie, syscon);
 }
