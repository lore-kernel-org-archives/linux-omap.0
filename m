Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7753A6B86;
	Fri, 17 Apr 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431763; cv=none; b=aFh5T7j+W7IiCzOHZ3ESI/hCWIfYEm8k301BY9Ocs6mKbust1GlN9W+EtrLiMnUyIVQj0FTpops5/6z+DQZNEzxdukBMYfW+JCHhCLUb3TxRDTErI1GGGacy/d6kjGDMZ+jkaxsTtKoAl60jG78q2Kw3GZrM67AZDWeahMyiHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431763; c=relaxed/simple;
	bh=ZwXQ0B97mAqYw+Pj4q1qkn3w0VEkp8PC3RW3zFe6OsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeMbgfyc/LMf1i1IXtXhplCL0xP8ULwC78WmDyPFuZIg87cCRlAKvY+VngZJVn4jSAveYYMeEpLK+6e2nX55evVOpBV/avBowzbk+Z2lZj6HIdW7OTvpo4Hz0py26KtwzpPNAmt6LCurxIIOq85nQHeJ9gR7h0aleqwybW+9wfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cas8tNl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cas8tNl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3CC2BCB0;
	Fri, 17 Apr 2026 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776431762;
	bh=ZwXQ0B97mAqYw+Pj4q1qkn3w0VEkp8PC3RW3zFe6OsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cas8tNl9CxmcLPr+klpYOiOUpWw43pvARwfWzkMhAldp4ZiMUUD85xhwTjq7t6hVg
	 bIcshTUeASvThAOLJ6gi/HwyuE/Dir1wBYF/Hj5q8lgD/slBp7IQ7i63f0qexpV3wJ
	 Dpdik+ZOT2LUCaDE9CzA3t21t9MAph0JK/phP//57EZbMMfSI9howf1iEOjXKH+sGI
	 wHm+HbRaq2FdZdHUEirPh/MOgchAVjivRph3vR+xdxflx0o/dn8vCQediYu6KxEK78
	 e7BzDvigmM3Xpx9AtOQL++z/+7AN13/idhGEszTreTBLHfZ6xObY5Sgu3f+zx0TmNO
	 CMyLhJqHZ9Drw==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: reserved-memory: Change maintainer for BPMP SHMEM
Date: Fri, 17 Apr 2026 15:15:48 +0200
Message-ID: <20260417131549.3154534-3-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417131549.3154534-1-thierry.reding@kernel.org>
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Peter sadly passed away a while ago, so change the maintainers for BPMP
SHMEM to Jon and myself.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
index 4380f622f9a9..6efadc5f8078 100644
--- a/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Tegra CPU-NS - BPMP IPC reserved memory
 
 maintainers:
-  - Peter De Schrijver <pdeschrijver@nvidia.com>
+  - Thierry Reding <thierry.reding@kernel.org>
+  - Jonathan Hunter <jonathanh@nvidia.com>
 
 description: |
   Define a memory region used for communication between CPU-NS and BPMP.
-- 
2.52.0

