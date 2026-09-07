Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D241A50B
	for <linux-omap@vger.kernel.org>; Mon,  7 Sep 2026 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763682; cv=none; b=BwnT8GpSFk0jemuk05IzijS3ywa6+e0L5Yx6whq8uUmDgYuwSBAzrkpBlKHFyZ2SAJZfLEE/ESGvWs+njGSdmNRFhus4DyDhR+6fawZGCBnhXlny8Lmu8dcfwkR+WD/1KoJke2Qs6s2W+zVrQ0r6t3nqTWUynxvsN7Q/+vAtggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763682; c=relaxed/simple;
	bh=yXnUcv5qVGtYzgWj9FiGbfPJUzxRYD9YlLEosr6E6dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ0L1ourN7WSjfzar9/ruMZL5T8gBMZ2WqInwi0Dj5C3fYqd0R3fpwqSYmgn48REnq/wNo25PXYvKUnqfQm6OweXlGDBVI0FzkHv0c4RkZe1X8V3S8VFTteCJD3JQUxAN1gPuvrILl2TUQ19sUYQK1QSzUbEO32HaH+QOAzoKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEkA2AXz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEkA2AXz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2096985a12.2
        for <linux-omap@vger.kernel.org>; Sun, 06 Sep 2026 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763678; x=1789368478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HpKYH0amj/dwSRkLCI992Ocp0fThRc8J4K3VwmqlP48=;
        b=TEkA2AXzP1ykjfqACx/jwed0U0LNdDZW6cGOrZ5RQo//9jTV+EFTNwnnmVzXjhb2op
         6BPX5Ow09lMovUQMg3a5IJ+aIFH0adXTPVdP0+KC5v45Q5TFr0f11AG/7dNn7t5RbItV
         c/FOxNxh3mUnUZ2+Z5UAmFDnsEqqDhQAaznTL5N3yyR4KmX3CkHPYapRil6wIcYCS1+B
         6X0ch2njIoFDNS7TwVF+yChN9zUPBvQ3zn8HogDmLXr+Jpyh2s+XiGYvjuK/a5zqhILT
         J+innFog8GVkrLiD5DdP+1vhX0F+laIpVd0uaIFiMElXfHI3JY7CLHyK4iKOUZITTDw1
         P+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763678; x=1789368478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HpKYH0amj/dwSRkLCI992Ocp0fThRc8J4K3VwmqlP48=;
        b=W3/Ilszf847ddVPK8ryEj1BjIZULNXNXENSwpa+dRt6ZwF0ghERsxtDKIo5uYU6elu
         aA4WqZ/dy+jPeYgXcWXkKsXEzvd/+RJsrZb57Ui+EI9/xgskRon+HTmXkid+ioPzBRA+
         C0XbJWJgCaMHL791G0ASzuJzTxTnROXRGhS4fRuzShN5tDcXj1f5JsrIwG9gUwKCpQnK
         bYsJZVNlNKNcPZ1/JR1iTFP3U0Fxq9xzA2XJimZiSps36P1NycUmWtYf546jN5bQ12cv
         HGBNCbtpdDJk3Me5pAc3SCFvy26YcKCGIA+iHT4yQTvfd0cJI/pwxO+5fEymbEvsl6pn
         5xxw==
X-Forwarded-Encrypted: i=1; AKwUvBzDXn9cvwbcsgPkepfr7duDRgk2l/raEvbqrlb+k8kCvgku/6vKo1kgi7USfxzahr6mDLtuzB5ZWyxJ@vger.kernel.org
X-Gm-Message-State: AFuF++nhSRYDqYO0ACMy8ZjawHJA268cy7GJ34VIkogUEAGkfYPSzcZ1
	TE4RwI9BkLxS2XuFJ1bNn/J9ZKpBo2SnhOpft6tSw2kfekB9WpD+SkOd
X-Gm-Gg: AYBFou31hEP3MGppxe7iIEePb0WlWvp01PdI5jxtcAmyOwvdnXh91c09NquTVxP77ub
	N5I2BZHCgMMbvrGnJiTwbrbJkY4AKBIW5Wqev2ONfQ9Yb4iz0Nujo4WJejBuz3DVtsHKs5fHq3P
	ZNEcs/HPq1Q6J2LmmpFW576L0YubP4CVlZD9JTyu0cGXCNIDbbKcyCh0hnw8MiIp1mENo2ClLL6
	JOJVVhB21qYpLQGIlknQpyKS+R1mnhLlbPLfkI2jHblfbFeHY9lCGSxokxZ3LqYQdoNECALpVR5
	pOib/U25AzAHQlQM+lUM5NOsq4l9HRVu5YwZQ9V0SzDbb6LqBBzBasydzcVXXqkJ/wUyw9mGzJw
	7/hhIWCLLXXQx6GunBTMPGWNoBBgGMT9Sm7mJXLPYMXysiL6033IuKXkv7MX5PMgzd5rDbJjG9A
	818c8oYU7wtu8RDaribyrd/uttn1WgE3QJWUWhDl06/iqmoC2p7yf9bSk5gZ5xLIWKTbphBYAjH
	llEvf5GDZlP6A==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39b261ae617mr36625720a91.11.1788763678086;
        Sun, 06 Sep 2026 23:47:58 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:57 -0700 (PDT)
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
Subject: [PATCH 4/5] cpuidle: fix repeated word 'that' in comment
Date: Mon,  7 Sep 2026 12:17:24 +0530
Message-ID: <20260907064725.10686-5-hemanth.selam@gmail.com>
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

Drop the second 'that', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index aca907a62bb5..d2fc216c38fc 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -281,7 +281,7 @@ static int tegra114_enter_s2idle(struct cpuidle_device *dev,
  * LP2 | C7	(CPU core power gating)
  * LP2 | CC6	(CPU cluster power gating)
  *
- * Note that that the older CPUIDLE driver versions didn't explicitly
+ * Note that the older CPUIDLE driver versions didn't explicitly
  * differentiate the LP2 states because these states either used the same
  * code path or because CC6 wasn't supported.
  */
-- 
2.48.1

