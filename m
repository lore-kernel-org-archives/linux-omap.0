Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C943242BE;
	Thu, 16 Apr 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345499; cv=none; b=qk99pI8b728JM0TfmaGe3IcagSVkfrQJmQkNJkJvdihaJCJqCyHEs9VCZl8R13c3xRsZlNKxQ/BwwOWl6SU/i3MfSf2NRaV65jXJLDiwPOgrZI5Ul2FEI4OrHQwDDPQwZrrv61pbQ7XqPUP5aqR0AkOhE4mB0jfEMbCbUoS+AXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345499; c=relaxed/simple;
	bh=v2KfXvmyoYN0U8cDqXs3PNwqipn6UcHYXc0jmP5Hn7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQLlNTZjukDYfKZFXzC3qFt9OtxCgYcrthAFKfZQurqalytZHV1lB7a/XU+QXvgcRM+bR9B+CY6EMaHcCCVkNwchSwV+xE1wpkUGElWCD8D3ovNCayBseYRwLoEEs/BNUY35wGmh3rlwgLnDlenlscAzZAWJIQA+OVzeIQ2+8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHVocQXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHVocQXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6384C2BCAF;
	Thu, 16 Apr 2026 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345499;
	bh=v2KfXvmyoYN0U8cDqXs3PNwqipn6UcHYXc0jmP5Hn7o=;
	h=From:To:Cc:Subject:Date:From;
	b=PHVocQXhRNsqLT7YGQNw3ajVv1Llnz03oiIhn0EiUKuk5XLmAMbk5xqNmflj+BnI+
	 WAixTVjjAXbjTnaAEdatFvRRVwIltR/jE7owPnoFQaoDqdcg6lYwNZUGB8YDwQAnLa
	 KxNrpZwhqwWP96aLBx/13ve0bO1E+FY1h9LS2QzjUrkd42U0T/JWXRR1Sm0ZFEPjSn
	 2ZAMt6W9sYKu4fREvXh5+IfDmZEZg7LR6hdhNy5tKArtMbgZT9UKXehutZAy+f2JPB
	 4IG6tZZ9an13fhmfAjv/x6cYtrI2/30bDnXcYL/XG4CdLBPrUp34VyLyrdvCNKg8Lg
	 dmH//b/BScw4g==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH] MAINTAINERS: Move Peter De Schrijver to CREDITS
Date: Thu, 16 Apr 2026 15:18:10 +0200
Message-ID: <20260416131810.3116408-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Peter sadly passed away a while back. Paul did a much better job at
finding the right words to mourn this loss than I ever could, so I will
leave this link here:

  https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u

Co-developed-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 885fb05d8816..29fcfa679430 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3645,7 +3645,13 @@ D: Macintosh IDE Driver
 
 N: Peter De Schrijver
 E: stud11@cc4.kuleuven.ac.be
+E: p2@mind.be
+E: peter.de-schrijver@nokia.com
+E: pdeschrijver@nvidia.com
+E: p2@psychaos.be
 D: Mitsumi CD-ROM driver patches March version
+D: OMAP power management
+D: NVIDIA Tegra clock and BPMP drivers, among many other things
 S: Molenbaan 29
 S: B2240 Zandhoven
 S: Belgium
diff --git a/MAINTAINERS b/MAINTAINERS
index ef978bfca514..ffe20d770249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26145,7 +26145,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
 N:	[^a-z]tegra
 
 TEGRA CLOCK DRIVER
-M:	Peter De Schrijver <pdeschrijver@nvidia.com>
 M:	Prashant Gaikwad <pgaikwad@nvidia.com>
 S:	Supported
 F:	drivers/clk/tegra/
-- 
2.52.0

