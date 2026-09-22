Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85826ED41;
	Tue, 22 Sep 2026 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037885; cv=none; b=Q4rvleuhjNObGail99q4OkDG2k63W2YZ3inozq+ZbzHQlfzwgmSMtnKFK8IIUgWgIQdNTh9sbioP+uJozqwkFwqjT5hnX4hU7ZNj3hM8oxx7AMGMlN0Q35pGBUWhcISlrgLnhzZbXB9JY5FG6Dc4tE0wi5xfSWEvDCOLzEnT8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037885; c=relaxed/simple;
	bh=YRE3I9V9LgTIHSrT7f+dRMMrJCp7JxzlqsGHBsYx5sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xdite1KFlzZiykzJJj0W3++qn4EVBdwxjYOvvNgXbkvIf9e33Eu+Ax4EmhpJ91aExUC5nLxetnYPY85xj2rkvcHxLuruKd0tNw/loARA5OPXdhoO3lvVx6nEkl3prfDNaEy8id749+/BWQ23lH3oeWYJ00k0i+jyuF8oSknFaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ej2rlcfj; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ej2rlcfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RV
	zMyC+r9D22h4eDwlIzSQLAEBrAcaYYSZoKW4bzXQU=; b=Ej2rlcfjMPIjTPK68s
	PjaoGDSfn1yo1gA9E7PebQ8q8c1ulNGEIvXdjuo5qCrQCD2bEL0zbC4NT5xiWsjv
	t8lE4GHwxuExqPIbqAQaYOVVmHC5w44uGWC/WB6cbkKsa5lwgtWMEFtbHlYWUdFf
	7B/Q9JFpZkuMLZyVel6bWMXKA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnR1Zgz7FqqM3RAg--.28552S2;
	Tue, 22 Sep 2026 08:44:17 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: b-liu@ti.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.nawrocki@samsung.com,
	kishon@kernel.org,
	balbi@ti.com,
	tony@atomide.com,
	hppiscas@163.com
Subject: [PATCH v2 0/3] usb: musb: omap2430: handle PHY setup failures across PM
Date: Tue, 22 Sep 2026 08:44:11 +0800
Message-ID: <20260922004414.4192-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnR1Zgz7FqqM3RAg--.28552S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUGw1rJw1fWw45GrWUCFg_yoW8Zw13pF
	W3Kr45CrWDJ34xtanIyw47tF95t39Yv3y5W343X34kurZ8GF1xCr4jqF109F1qyr4kKa1q
	va1Dt3W8uFn0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziK9adUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxgET22qxz2FPVAAA3h

The OMAP2430 glue has three unchecked PHY setup sites: initial setup,
runtime resume and system resume. This v2 resends them as one threaded
series, as Greg requested, and closes the shared reference-ownership gap
before adding the remaining error propagation.

Patch 1 records initialization and power references independently and
uses common helpers in init, PM and exit. Patch 2 stops runtime resume
and mailbox work when resuming fails. Patch 3 reports normal system-resume
failure while ending the temporary I2C/SPI PHY deferral, allowing a later
runtime resume to retry.

The existing phy_suspended flag controls system-sleep ordering, not
resource ownership. Keeping those roles separate avoids double-release
on another suspend or platform exit after a failed resume. A release
failure retains its ownership flag rather than silently discarding it.

The three original setup sites share this lifecycle machinery. They are
not three independent proofs of hardware faults, and this series does
not address errors hidden inside individual PHY providers.

The issues were found by our static-analysis tool.

Changes since v1:
- resend with all three members replying directly to this cover
- share reference tracking across init, runtime PM, system PM and exit
- account for a cleanup operation itself failing
- stop mailbox access when runtime resume fails
- retain needs_resume until early resume succeeds and end system PHY
  deferral after normal resume even when setup fails

Previous series:
https://lore.kernel.org/all/20260906034149.85550-1-hppiscas@163.com/

Pengpeng Hou (3):
  usb: musb: omap2430: track PHY references and check initial setup
  usb: musb: omap2430: stop runtime resume after PHY setup failure
  usb: musb: omap2430: report system-resume PHY setup failures

 drivers/usb/musb/omap2430.c | 123 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 107 insertions(+), 16 deletions(-)

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4

