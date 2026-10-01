Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8B4A68B1
	for <linux-omap@vger.kernel.org>; Thu,  1 Oct 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844756; cv=none; b=ZadCevwKxftJPD67Epx9oJeus5UFE9mFFJYpXnUu8RoO7TczWVYtgPwvYjOgDgHPmwzMPocwz390wPy6l/8GngbpWmUu8f5HPWJiaWDuL70KOd0EPN5D2NkwkH5hFihmWgG7sLmOg/MPiZ1h1EIr2qy5Ud68q5HPsokJCorQThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844756; c=relaxed/simple;
	bh=22RhtB3hdeb1YMxctDv2stx3hL2tFI2So2wluhKRzrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qR5znxVeyZTK89OLBOmMFfD1OFkdyUlEhdCLfxQzmYLi4rHzHVVSQgM0cdofPMoDilfckZZU3i+qTbptw6P9ELB6dJ24JomtvLnKa2/Z09FzXm46LsJL1sh6xoBY3yCZiDPwYnITc78tB1VyEIl7yS8pmWXzlYrjeaAUTh6/9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=pDn4MZM+; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="pDn4MZM+"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026100108522070091255f200020716
        for <linux-omap@vger.kernel.org>;
        Thu, 01 Oct 2026 10:52:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yOfbXfp6ub02CLaVkSzncgam2NRXSN2eMhn2KnSsSd0=;
 b=pDn4MZM+/qgU33ijPc193ZPMjNuZoCFP3Zv8BNZDmuco+rPp+RIXRcK74TTgJW1x5dSbps
 GLYZI96ML7kXlbRosOcMP2gZoH0BGRRt9PqDj+LS0BcYZyFGussWkmlNRDETXMx9p5tgbeM/
 bUdmbZQLWjHuJ5DrmqshemH5407NykB5cydcj+Jcinf0nB/DdmZqXv/aaz3oDGWTfxYuYynD
 HMwbMff14FFF5YOK3vGDrAKmY8c6Has1ZLsN3X+AsyUkAECFZi4dR5KRbmaGIowOTPejQ+WH
 kcpRRQ70QvkYrhlSX248MoaNfRswNTBDiGFAjaIm1WnYSPi9wSPiHjwQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-gpio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: fix group/function table leaks on consumer re-probe
Date: Thu,  1 Oct 2026 10:52:09 +0200
Message-ID: <20261001085217.1778645-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Pinctrl drivers that create their groups/functions lazily from the
consumer's device-tree node in .dt_node_to_map() leak the per-mapping
tables when the same node is mapped again. The core deduplicates
groups/functions by name and keeps the first instance for the controller's
lifetime, so it silently drops the copies built on every subsequent
mapping - e.g. on each re-probe of the consumer device. kmemleak does not
flag them because they stay reachable from the controller's devres list.

Reproducer (patch 1, pinctrl-single) - any board where a device referencing
a pinctrl-single state is repeatedly re-probed; here an I2C TPM whose node
has a "default" pinctrl state:

  while modprobe tpm_tis_i2c; do rmmod tpm_tis_i2c; done

The tables land in a generic kmalloc-N cache (kmalloc-192 on arm64, where
ARCH_KMALLOC_MINALIGN pads every devres allocation; the bucket differs by
config), so watch it cache-independently by diffing /proc/slabinfo after
dropping the reclaimable slab:

  sync; echo 3 > /proc/sys/vm/drop_caches
  cat /proc/slabinfo | awk 'NR>2{print $1,$2}' | sort > /tmp/a
  <run N cycles>
  sync; echo 3 > /proc/sys/vm/drop_caches
  cat /proc/slabinfo | awk 'NR>2{print $1,$2}' | sort > /tmp/b
  join /tmp/a /tmp/b | awk '$3>$2{print $1,$3-$2}'

Patch 1 (pinctrl-single) was found and fixed with the above test on real
hardware. Patch 2 (ti-iodelay) has the same bug pattern - plus a missing
.dt_free_map that leaks the mapping table as well - but was found by code
review only and is compile-tested only; I have no such hardware to
reproduce it.

Alexander Sverdlin (2):
  pinctrl: single: don't leak group/function tables on consumer re-probe
  pinctrl: ti-iodelay: fix memory leaks on consumer re-probe

 drivers/pinctrl/pinctrl-single.c        | 21 +++++++++++++++++++++
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 24 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.55.0
