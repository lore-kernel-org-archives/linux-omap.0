Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0223B27DC;
	Sun,  6 Sep 2026 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666152; cv=none; b=TXPT34T/wr36/lo3o+GfpR/EnoXkohVJQ0xOW+jvK0+BCSFKVz9MHNgcJmLDPYrF33t34jLMPE7sidqGv4fqlk7R9cRu6rq4u3Cf/wEI/oPlyWtQaa4BpQj7aQLNXBOn04lOSxcy2CKY8KJoaeeDLqXF+51QqJUhmBtfUrtzYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666152; c=relaxed/simple;
	bh=7TpxTN2HN6/K6a5GuAgeFUim2vNlDVwP+E1OfTRfFs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnYG0vTAjXkWeWNwOCjUQTn9BS4QaPJYdmKTy/1pAEIz6GFklwAseQ99M/p6P/Won0bj57BoQ8CzVsxGiro2mlJkrHihKwYseEJ+vph/jIUE2Cz/TBCXHu1JoU+mikfyDhkhiSFM0fttDbVV7YarRfNY5S0nvtxd8ULPi7CEmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MiCnst3s; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MiCnst3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=WD
	yXFs5PCgHcwK8/dgOo5Gf/Vp3TvrE2a/wS8yzZ+YA=; b=MiCnst3sA2/vpumqYU
	3Zdf25p73/zK9/3zj2sJQvWThJCwE6iwjd8zpaMySg/ZuoTb8HZNctX3CDEoUuw7
	4GoLdtfC/SStj9nx02gyiugV1BuEMhbSj38FjIiKs4zdVgXHUY0xaON/Jl1/NHUB
	SyBAfo8NSj41WPhaK7NTfb1u4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfz_4JxqO+zERA--.30741S2;
	Sun, 06 Sep 2026 11:41:52 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] usb: musb: omap2430: propagate PHY setup errors
Date: Sun,  6 Sep 2026 11:41:46 +0800
Message-ID: <20260906034149.85550-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfz_4JxqO+zERA--.30741S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxZFyfWrW5Kw1ruF13CFg_yoWfJFX_Ga
	4rKr93Ja1DtF1vka9F9F9xZa9Y9F4jgryUXas8t3W5GF10qFn7Cr1vkrnxA3W8uF4DCrn3
	W3ZFvr1fJasxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRk9NDUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxgA6A2qc4QDOvgAA3Y

The OMAP2430 glue ignores generic PHY initialization and power-on
failures during initial setup, runtime resume and system resume. The
callers can therefore access glue registers or publish resumed state
without a usable PHY.

Keep the three lifecycle transitions separate so each patch has one
failure state and one introducing commit. Each power-on failure exits a
PHY that was initialized by the same transition.

The issues were found by our static-analysis tool and manually reviewed.

Pengpeng Hou (3):
  usb: musb: omap2430: Propagate PHY errors from init
  usb: musb: omap2430: Propagate PHY errors from runtime resume
  usb: musb: omap2430: Propagate PHY errors from system resume

 drivers/usb/musb/omap2430.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)

