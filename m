Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557241686D
	for <linux-omap@vger.kernel.org>; Mon,  7 Sep 2026 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763674; cv=none; b=MlcOZ/T9eLVImDzO4UTuNTlmBYNebYfFUGgn/1iTQY03C+2KKYvlzYhJcqMGx/NE3dFPnFpR737PJcDO+SPIel4CNljRbc5MqvMd90o6ih5KWJegA4GY7HmSSF3FqXn5eatZTJR3tQbtF7KGIYydvYli/iXyZqHIoJT0Yb3sHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763674; c=relaxed/simple;
	bh=p91ao2AKO1u40gx02a/XDSpFyO2CsKWUxeRtlMlap68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I52erbhUfqQd7yGHSjZnbL8Ee+l1YlIiKyCgsd0K/AVgV7xTnnTbsU+17C48jwhhykpXGKG0Xnc6489//0VdkbgaeAtBChOw0A5RwpOYQurNuQ4trxgOqdGWNcpEderu0Bij3OMDQzMBA6gccKIxUloJyQ+RBoJ2FCblKwjEFuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEjHzrbw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEjHzrbw"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so2608520a12.2
        for <linux-omap@vger.kernel.org>; Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763672; x=1789368472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=kEjHzrbwtRg1hg4bzJm7knqJe2KFnNf1OSbeA8WSAnrjQM2zPStzHl92eMayZ67S2f
         Rh3Qb/Cwmct/oY3uD10q1HnmJ4CIXqOTZqyf4nuPfpS0AL4ozel78IbL0krJo4eFKhGR
         QT5VibDE5/FrGVkkHOgobYfuNQ4R8+vk5F+HNgP8mvDBg880XowBvwtu7uzvGzP188qn
         zNCTOT2hqZSE2Lftix4aIHtVV+WxDT9oI1uKe9T7x54funPrKbh+50+pMZD8SnvUo/i3
         dbCR//vBRDmMpMSaPvaWvkCTWpkaJxCqhJDUqjOOE7c69mjWG1kIqATi6JwhadcZ9OUA
         xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763672; x=1789368472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=bnNr8h3f3yqTl/Zq+Whuekoh864wNxKsM/5USgJl0gPdkL8BhTPU8s9S3Py0qJygwP
         JzReTBFv2Kn3PdtDLKaG+ebMgWSevzao4Iqer365BTYShz443MiDkZhjcq0VXhHI/F3R
         MlZu9wd3eaP1U6hrqjF6VHm4CPGSt+DAOw8lH+sHXReyYBTlNDEvi9iFAJMawwaqhHqi
         Kl/+tNX1hR52x50VV3uRRJdDizkV327w0QVNQGAOaE2tZv5RhTM3LVZHMzd+6S2XHvtK
         5YDwVo6etS0YqecdprMgKtBVMfarSMAlofn0y11ZqSGx1+9g2/pdPWib7slVbQruR2mz
         m3wg==
X-Forwarded-Encrypted: i=1; AKwUvByh/1Hqv9noWxIIaiaZuaEJNNJPXNL9TYTy9vG+ENIn8+N5qYazedhlQtwV0k9IR4F4M4L2dGz81090@vger.kernel.org
X-Gm-Message-State: AFuF++l+hMesQiqZtE06f6oaNbo/OSkP2RgZa5aLIVUUYw+/cure1eaL
	m+8szpgWYo0G47zWWRVIwDCyHL7EwOblujUhKvG+941nLXf5aYFiLnxN
X-Gm-Gg: AYBFou0axO/FmVczFdHgOqcndXVpP0FynQQ7mJy6V3vBNoTeeAz1MlW9l5qQYfsw7pc
	4jXWQvXJgGtHzTupIQ7lDyYhmSlcQ/oXeXuH8zEayxiBZhfZxVNjECeV1U4BLeNLNAhPcUv+hYf
	LsPnhZzaTTlU80XP7/84jLuD1lIKsWiK4xa7JYU5+iwtXCcS1Oxu1ooG7EuxzociXCUPVgM8Svp
	opf1h6Bz36y6qDbRvQSvYZdVHPneTvQATc3tHyRZrP9Mj5P0xNWKN8GJMXlWUQHvX4DF6qm0nLq
	RGm649IAlnAp5j+sCabgtkxaGENogOS/4Qx93HC1eMdBcBRM3dQ2gswv9gqiKL5j0HAw/f6eqZ1
	W+Dhy264RezTORn90lYLcfcnXqCzGk6jZOIZE6bm9ZblF6JG88pfLYfxm8SEmYr5DQsmPJP7Lvo
	xhRVldV/nJgzjdXiTXjvyrwgGiuPhFjzRRtx4JwBoundvP+bmpDCBxHDtj0paJmkq5QtScbSpyl
	9Y0BoDVBogLyw==
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39b260d2f07mr32517136a91.3.1788763672025;
        Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 3/5] tools/thermal: fix typo "binded" in comments
Date: Mon,  7 Sep 2026 12:17:23 +0530
Message-ID: <20260907064725.10686-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/thermal/tmon/sysfs.c | 2 +-
 tools/thermal/tmon/tmon.h  | 2 +-
 tools/thermal/tmon/tui.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108bc9249..5d64aff12a86 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -225,7 +225,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 				cdev_name, cdev_name_linked, cdev_id);
 			tzi->cdev_binding |= (1 << cdev_id);
 
-			/* find the trip point in which the cdev is binded to
+			/* find the trip point in which the cdev is bound to
 			 * in this tzone
 			 */
 			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..f347efb47c96 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -77,7 +77,7 @@ struct tz_info {
 	char type[256]; /* e.g. acpitz */
 	int instance;
 	int passive; /* active zone has passive node to force passive mode */
-	int nr_cdev; /* number of cooling device binded */
+	int nr_cdev; /* number of cooling device bound */
 	int nr_trip_pts;
 	struct trip_point tp[MAX_NR_TRIP];
 	unsigned long cdev_binding; /* bitmap for attached cdevs */
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b87f15..b982c1d77402 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -238,7 +238,7 @@ void show_cooling_device(void)
 				unsigned long trip_binding =
 					ptdata.tzi[i].trip_binding[cdev_inst];
 				int k = 0; /* per zone trip point id that
-					    * binded to this cdev, one to
+					    * bound to this cdev, one to
 					    * many possible based on the
 					    * binding bitmask.
 					    */
-- 
2.48.1

