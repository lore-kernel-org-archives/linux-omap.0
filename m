Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0B362127
	for <linux-omap@vger.kernel.org>; Tue, 10 Mar 2026 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129362; cv=none; b=Kg2LRdcKDyPsiGt+kT3Q1NXWu8MzN/OVd41YpJK3mL3k5zIYAB9QcqHR5audR78RfWPFUxfflt6ulKoAVyDTK2driGQvV13OArWazshHNOGUoUNTA1z4qFpIX6vTkiTZYLz45E2Cw3WkcFBZ2glAxAEXTjPFRsWMyCSN/HALd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129362; c=relaxed/simple;
	bh=FMS4BVUajKAUxKcjzcddBgaLVt+yOxMuuGFj9UUkSaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teXJR1rrD2rkyWTFcOs/gaE+GPAO4wEWZG4FyY4/gEYVRZQ7hNQynC3BO9VfUHy07rG5GGyJvq5qoPrBB4hMs+Q5OKbUbuHKccnobb/lkpZL8z0Z/RvnngwBW36ZS8LEzOgeZTR5tP+dVd8NQWc61KW5S9+PQYbA8ZSMsf0ABX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=grFET2Q/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="grFET2Q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=/a0tRwE4WB1N7m
	bM38o7pQ2y610kAMXzD8AqisAnlgU=; b=grFET2Q/L5BDbD2xTndWCxfWXxtyl2
	MrNW6Nu3qAN1EmBl/MYyb9CKwe54CLj7IvlqLMC5IMLgb11+UnMtwsIpNOpeZHWa
	GVPU+ybqbKsVtIcDblhf8AAmfEvK69zbgwZTCdiSqJFfuZQ3G9lnG2U3m4tzAMVJ
	QnwiFLc/jqMR9GpmUHV3igEQ4pjuUCRsM0Hm2OZQ1Li9cwvsXq2py2+kvdhFHYP2
	jC6TKSVnNybFyfIppa6NtLkCKTYZrYUqHsFkz7SYD5URwCS66vb5yN0vG/p3qKDq
	87t1xNh8zF1QjL/xdXPPlibUyKgxw31YNVsxPQuxV575FpunGlhflHgw==
Received: (qmail 3112474 invoked from network); 10 Mar 2026 08:55:47 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Mar 2026 08:55:47 +0100
X-UD-Smtp-Session: l3s3148p1@UTnb2KZMmJAujntP
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 00/15] hwspinlock: move device alloc into core and refactor includes
Date: Tue, 10 Mar 2026 08:55:15 +0100
Message-ID: <20260310075539.11701-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:

* removed useless __iomem annotations (Thanks, sparse + buildbots)
  So, the newly introduced callback only operates on void* and doesn't
  use __iomem annotations now. Note that most of the drivers will still
  trigger a sparse warning because they use an __iomem pointer in
  .con_priv. But they also did so before this series, so it keeps
  current behaviour. Fixing these sparse warnings should be done
  independently IMO.
* rebased to 7.0-rc3
* added tags (Thanks!)

My ultimate goal is to allow hwspinlock provider drivers outside of the
subsystem directory. It turned out that a simple split of the headers
files into a public provider and a public consumer header file is not
enough because core internal structures need to stay hidden. Even more,
their opaqueness could and should even be increased. That would also
allow the core to handle the de-/allocation of the hwspinlock device
itself.

This series does all that. Patches 1-2 remove the meanwhile unused
platform_data to ease further refactoring. Patches 3-9 abstract access
to internal structures away using helpers. Patch 10 then moves
hwspinlock device handling to the core, simplifying drivers. The
remaining patches refactor the headers until the internal one is gone
and the public ones are divided into provider and consumer parts. More
details are given in the patch descriptions.

One note about using a callback to initialize hwspinlock priv: I also
experimented with a dedicated 'set_priv' helper function. It felt a bit
clumsy to me. Drivers would need to save the 'bank' pointer again and
iterate over it. Because most drivers will only have a simple callback
anyhow, it looked leaner to me.

This series has been tested on a Renesas SparrowHawk board (R-Car V4H)
with a yet-to-be-upstreamed hwspinlock driver for the MFIS IP core. A
branch can be found here (without the MFIS driver currently):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/hwspinlock/refactor-alloc-buildtest

Happy hacking,

   Wolfram


Wolfram Sang (15):
  hwspinlock: u8500: delete driver
  hwspinlock: remove now unused pdata from header file
  hwspinlock: add helpers to retrieve core data
  hwspinlock: add callback to fill private data of a hwspinlock
  hwspinlock: omap: use new callback to initialize hwspinlock priv
  hwspinlock: qcom: use new callback to initialize hwspinlock priv
  hwspinlock: sprd: use new callback to initialize hwspinlock priv
  hwspinlock: stm32: use new callback to initialize hwspinlock priv
  hwspinlock: sun6i: use new callback to initialize hwspinlock priv
  hwspinlock: handle hwspinlock device allocation in the core
  hwspinlock: move entries from internal to public header
  hwspinlock: remove internal header
  hwspinlock: sort include and update copyright
  hwspinlock: refactor provider.h from public header
  hwspinlock/treewide: refactor consumer.h from public header

 Documentation/locking/hwspinlock.rst          |   2 +-
 MAINTAINERS                                   |   3 +-
 drivers/base/regmap/regmap.c                  |   2 +-
 drivers/hwspinlock/Kconfig                    |  10 --
 drivers/hwspinlock/Makefile                   |   1 -
 drivers/hwspinlock/hwspinlock_core.c          | 129 +++++++++++----
 drivers/hwspinlock/hwspinlock_internal.h      |  72 --------
 drivers/hwspinlock/omap_hwspinlock.c          |  27 ++-
 drivers/hwspinlock/qcom_hwspinlock.c          |  69 ++++----
 drivers/hwspinlock/sprd_hwspinlock.c          |  39 ++---
 drivers/hwspinlock/stm32_hwspinlock.c         |  26 +--
 drivers/hwspinlock/sun6i_hwspinlock.c         |  36 ++--
 drivers/hwspinlock/u8500_hsem.c               | 155 ------------------
 drivers/iio/adc/sc27xx_adc.c                  |   2 +-
 drivers/irqchip/irq-stm32mp-exti.c            |   2 +-
 drivers/mfd/syscon.c                          |   2 +-
 drivers/nvmem/sc27xx-efuse.c                  |   2 +-
 drivers/nvmem/sprd-efuse.c                    |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c         |   2 +-
 drivers/soc/qcom/smem.c                       |   2 +-
 drivers/spi/spi-sprd-adi.c                    |   2 +-
 .../{hwspinlock.h => hwspinlock/consumer.h}   |  57 +------
 include/linux/hwspinlock/provider.h           |  60 +++++++
 23 files changed, 260 insertions(+), 444 deletions(-)
 delete mode 100644 drivers/hwspinlock/hwspinlock_internal.h
 delete mode 100644 drivers/hwspinlock/u8500_hsem.c
 rename include/linux/{hwspinlock.h => hwspinlock/consumer.h} (87%)
 create mode 100644 include/linux/hwspinlock/provider.h

-- 
2.47.3

